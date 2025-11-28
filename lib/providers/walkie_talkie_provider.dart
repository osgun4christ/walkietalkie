import 'package:flutter/foundation.dart';
import '../services/webrtc_service.dart';
import '../services/audio_service.dart';
import '../models/connection_state.dart';

/// Provider for managing walkie-talkie app state
class WalkieTalkieProvider with ChangeNotifier {
  final WebRTCService _webrtcService = WebRTCService();
  final AudioService _audioService = AudioService();
  
  String? _channelId;
  String? _username;
  ConnectionState? _connectionState;
  bool _isRecording = false;
  bool _isConnected = false;
  final List<String> _users = [];
  String? _errorMessage;
  
  String? get channelId => _channelId;
  String? get username => _username;
  ConnectionState? get connectionState => _connectionState;
  bool get isRecording => _isRecording;
  bool get isConnected => _isConnected;
  List<String> get users => List.unmodifiable(_users);
  String? get errorMessage => _errorMessage;
  
  WebRTCService get webrtcService => _webrtcService;
  AudioService get audioService => _audioService;

  WalkieTalkieProvider() {
    _webrtcService.connectionStateStream.listen((state) {
      _connectionState = state;
      _isConnected = state.isConnected;
      _errorMessage = null; // Clear error on successful connection
      notifyListeners();
    });
  }

  /// Joins a channel with the given ID and username
  Future<bool> joinChannel(String channelId, String username) async {
    try {
      _channelId = channelId;
      _username = username;
      _errorMessage = null;
      notifyListeners();
      
      await _webrtcService.initialize(channelId, username);
      await _webrtcService.createOffer();
      
      return true;
    } catch (e) {
      _errorMessage = 'Failed to join channel: ${e.toString()}';
      debugPrint('Error joining channel: $e');
      notifyListeners();
      return false;
    }
  }

  /// Starts recording audio
  Future<void> startRecording() async {
    if (!_isConnected) {
      debugPrint('Cannot start recording: not connected');
      return;
    }
    
    _isRecording = true;
    notifyListeners();
  }

  /// Stops recording audio
  Future<void> stopRecording() async {
    if (_isRecording) {
      _isRecording = false;
      notifyListeners();
    }
  }

  /// Disconnects from the current channel
  Future<void> disconnect() async {
    try {
      await _webrtcService.disconnect();
      _channelId = null;
      _username = null;
      _isConnected = false;
      _isRecording = false;
      _users.clear();
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      debugPrint('Error disconnecting: $e');
      _errorMessage = 'Error disconnecting: ${e.toString()}';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _webrtcService.dispose();
    _audioService.dispose();
    super.dispose();
  }
}


