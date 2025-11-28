import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import '../constants/app_constants.dart';

/// Service for handling audio recording and playback
class AudioService {
  final AudioRecorder _recorder = AudioRecorder();
  final AudioPlayer _player = AudioPlayer();
  bool _isRecording = false;
  bool _isPlaying = false;
  
  // For real-time streaming during PTT
  StreamSubscription<Amplitude>? _amplitudeSubscription;
  final StreamController<double> _amplitudeController = StreamController<double>.broadcast();
  Stream<double> get amplitudeStream => _amplitudeController.stream;

  bool get isRecording => _isRecording;
  bool get isPlaying => _isPlaying;

  Future<bool> startRecording() async {
    try {
      if (!await _recorder.hasPermission()) {
        debugPrint('Microphone permission not granted');
        return false;
      }

      // Get temporary directory for recording file
      // Note: For WebRTC, audio is streamed directly, but we record for amplitude feedback
      final directory = await getTemporaryDirectory();
      final path = '${directory.path}/recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
      
      await _recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: AppConstants.audioBitRate,
          sampleRate: AppConstants.audioSampleRate,
          numChannels: AppConstants.audioChannels,
        ),
        path: path,
      );
      
      _isRecording = true;
      
      // Monitor amplitude for UI feedback
      _amplitudeSubscription = _recorder.onAmplitudeChanged(
        AppConstants.amplitudeUpdateInterval,
      ).listen((amplitude) {
        _amplitudeController.add(amplitude.current);
      });
      
      return true;
    } catch (e) {
      debugPrint('Error starting recording: $e');
      _isRecording = false;
      return false;
    }
  }

  Future<void> stopRecording() async {
    try {
      if (_isRecording) {
        await _recorder.stop();
        _isRecording = false;
        await _amplitudeSubscription?.cancel();
        _amplitudeSubscription = null;
      }
    } catch (e) {
      debugPrint('Error stopping recording: $e');
    }
  }

  Future<void> playAudioStream(Stream<List<int>> audioStream) async {
    try {
      if (_isPlaying) {
        await _player.stop();
      }
      
      // For WebRTC, audio is handled by the platform directly
      // This method is kept for compatibility
      _isPlaying = true;
    } catch (e) {
      debugPrint('Error playing audio: $e');
      _isPlaying = false;
    }
  }

  Future<void> stopPlaying() async {
    try {
      await _player.stop();
      _isPlaying = false;
    } catch (e) {
      debugPrint('Error stopping playback: $e');
    }
  }

  void dispose() {
    _recorder.dispose();
    _player.dispose();
    _amplitudeSubscription?.cancel();
    _amplitudeController.close();
  }
}
