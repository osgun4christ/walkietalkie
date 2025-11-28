import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';
import '../firebase_options.dart';

/// Handles app initialization tasks like Firebase and permissions
class AppInitializer {
  /// Initializes Firebase with platform-specific options
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  /// Requests microphone permission
  static Future<bool> requestMicrophonePermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  /// Initializes all app services
  static Future<void> initialize() async {
    await initializeFirebase();
    await requestMicrophonePermission();
  }
}

