import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/connection_state.dart';
import '../constants/app_constants.dart';

/// Service for managing WebRTC peer connections and signaling
class WebRTCService {
  RTCPeerConnection? _peerConnection;
  MediaStream? _localStream;
  MediaStream? _remoteStream;
  
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  String? _channelId;
  String? _userId;
  
  final StreamController<ConnectionState> _connectionStateController =
      StreamController<ConnectionState>.broadcast();
  Stream<ConnectionState> get connectionStateStream => _connectionStateController.stream;
  
  final StreamController<MediaStream> _remoteStreamController =
      StreamController<MediaStream>.broadcast();
  Stream<MediaStream> get remoteStreamStream => _remoteStreamController.stream;
  
  bool get isConnected => _peerConnection != null && 
      _peerConnection!.connectionState == RTCPeerConnectionState.RTCPeerConnectionStateConnected;
  
  MediaStream? get localStream => _localStream;
  MediaStream? get remoteStream => _remoteStream;

  /// Initializes WebRTC connection for a channel
  Future<void> initialize(String channelId, String userId) async {
    try {
      _channelId = channelId;
      _userId = userId;
      
      await _createPeerConnection();
      await _setupLocalStream();
      _setupSignalingListeners();
    } catch (e) {
      debugPrint('Error initializing WebRTC: $e');
      rethrow;
    }
  }

  /// Creates and configures the peer connection
  Future<void> _createPeerConnection() async {
    final configuration = {
      'iceServers': [
        {'urls': AppConstants.stunServer},
      ],
      'sdpSemantics': 'unified-plan',
    };
    
    _peerConnection = await createPeerConnection(configuration);
    
    // Set up event handlers
    _peerConnection!.onIceCandidate = (RTCIceCandidate candidate) {
      _sendIceCandidate(candidate);
    };
    
    _peerConnection!.onConnectionState = (RTCPeerConnectionState state) {
      _connectionStateController.add(ConnectionState(
        state: state.toString(),
        isConnected: state == RTCPeerConnectionState.RTCPeerConnectionStateConnected,
      ));
    };
    
    _peerConnection!.onTrack = (RTCTrackEvent event) {
      if (event.streams.isNotEmpty) {
        _remoteStream = event.streams[0];
        _remoteStreamController.add(_remoteStream!);
      }
    };
  }

  /// Sets up the local audio stream
  Future<void> _setupLocalStream() async {
    _localStream = await navigator.mediaDevices.getUserMedia({
      'audio': {
        'echoCancellation': true,
        'noiseSuppression': true,
        'autoGainControl': true,
        'sampleRate': AppConstants.audioSampleRate,
        'channelCount': AppConstants.audioChannels,
      },
    });
    
    _localStream!.getTracks().forEach((track) {
      _peerConnection!.addTrack(track, _localStream!);
    });
  }

  /// Sets up Firebase listeners for WebRTC signaling
  void _setupSignalingListeners() {
    if (_channelId == null || _userId == null) {
      debugPrint('Cannot setup signaling listeners: channelId or userId is null');
      return;
    }

    // Listen for offers
    _database.child(AppConstants.offersPath(_channelId!)).onChildAdded.listen((event) {
      if (event.snapshot.key != _userId) {
        final offer = event.snapshot.value as Map<dynamic, dynamic>;
        _handleOffer(offer, event.snapshot.key!);
      }
    });
    
    // Listen for answers
    _database.child(AppConstants.answersPath(_channelId!)).onChildAdded.listen((event) {
      if (event.snapshot.key != _userId) {
        final answer = event.snapshot.value as Map<dynamic, dynamic>;
        _handleAnswer(answer);
      }
    });
    
    // Listen for ICE candidates
    _database.child(AppConstants.iceCandidatesPath(_channelId!)).onChildAdded.listen((event) {
      if (event.snapshot.key != _userId) {
        final candidate = event.snapshot.value as Map<dynamic, dynamic>;
        _handleIceCandidate(candidate);
      }
    });
  }

  /// Creates and sends an SDP offer
  Future<void> createOffer() async {
    if (_peerConnection == null) {
      debugPrint('Cannot create offer: peer connection is null');
      return;
    }
    
    if (_channelId == null || _userId == null) {
      debugPrint('Cannot create offer: channelId or userId is null');
      return;
    }

    try {
      final offer = await _peerConnection!.createOffer({
        'offerToReceiveAudio': true,
        'offerToReceiveVideo': false,
      });
      
      await _peerConnection!.setLocalDescription(offer);
      
      // Send offer to Firebase
      await _database.child('${AppConstants.offersPath(_channelId!)}/$_userId').set({
        'type': offer.type,
        'sdp': offer.sdp,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      debugPrint('Error creating offer: $e');
      rethrow;
    }
  }

  /// Handles an incoming SDP offer and creates an answer
  Future<void> _handleOffer(Map<dynamic, dynamic> offerData, String fromUserId) async {
    if (_peerConnection == null) {
      debugPrint('Cannot handle offer: peer connection is null');
      return;
    }

    if (_channelId == null || _userId == null) {
      debugPrint('Cannot handle offer: channelId or userId is null');
      return;
    }

    try {
      final offer = RTCSessionDescription(
        offerData['sdp'] as String,
        offerData['type'] as String,
      );
      
      await _peerConnection!.setRemoteDescription(offer);
      
      final answer = await _peerConnection!.createAnswer({
        'offerToReceiveAudio': true,
        'offerToReceiveVideo': false,
      });
      
      await _peerConnection!.setLocalDescription(answer);
      
      // Send answer to Firebase
      await _database.child('${AppConstants.answersPath(_channelId!)}/$_userId').set({
        'type': answer.type,
        'sdp': answer.sdp,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      debugPrint('Error handling offer: $e');
    }
  }

  /// Handles an incoming SDP answer
  Future<void> _handleAnswer(Map<dynamic, dynamic> answerData) async {
    if (_peerConnection == null) {
      debugPrint('Cannot handle answer: peer connection is null');
      return;
    }

    try {
      final answer = RTCSessionDescription(
        answerData['sdp'] as String,
        answerData['type'] as String,
      );
      
      await _peerConnection!.setRemoteDescription(answer);
    } catch (e) {
      debugPrint('Error handling answer: $e');
    }
  }

  /// Sends an ICE candidate to Firebase
  Future<void> _sendIceCandidate(RTCIceCandidate candidate) async {
    if (_channelId == null || _userId == null) {
      debugPrint('Cannot send ICE candidate: channelId or userId is null');
      return;
    }

    try {
      await _database.child('${AppConstants.iceCandidatesPath(_channelId!)}/$_userId').push().set({
        'candidate': candidate.candidate,
        'sdpMid': candidate.sdpMid,
        'sdpMLineIndex': candidate.sdpMLineIndex,
        'timestamp': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      debugPrint('Error sending ICE candidate: $e');
    }
  }

  /// Handles an incoming ICE candidate
  Future<void> _handleIceCandidate(Map<dynamic, dynamic> candidateData) async {
    if (_peerConnection == null) {
      debugPrint('Cannot handle ICE candidate: peer connection is null');
      return;
    }

    try {
      final candidate = RTCIceCandidate(
        candidateData['candidate'] as String,
        candidateData['sdpMid'] as String?,
        candidateData['sdpMLineIndex'] as int?,
      );
      
      await _peerConnection!.addCandidate(candidate);
    } catch (e) {
      debugPrint('Error handling ICE candidate: $e');
    }
  }

  /// Disconnects and cleans up the WebRTC connection
  Future<void> disconnect() async {
    try {
      await _localStream?.dispose();
      await _remoteStream?.dispose();
      await _peerConnection?.close();
      
      // Clean up Firebase
      if (_channelId != null && _userId != null) {
        await _database.child('${AppConstants.offersPath(_channelId!)}/$_userId').remove();
        await _database.child('${AppConstants.answersPath(_channelId!)}/$_userId').remove();
        await _database.child('${AppConstants.iceCandidatesPath(_channelId!)}/$_userId').remove();
      }
    } catch (e) {
      debugPrint('Error during disconnect: $e');
    } finally {
      _peerConnection = null;
      _localStream = null;
      _remoteStream = null;
      _channelId = null;
      _userId = null;
    }
  }

  void dispose() {
    disconnect();
    _connectionStateController.close();
    _remoteStreamController.close();
  }
}

