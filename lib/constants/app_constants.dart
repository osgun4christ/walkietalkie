/// Application-wide constants
class AppConstants {
  // Audio configuration
  static const int audioSampleRate = 16000; // 16kHz for efficiency
  static const int audioBitRate = 128000;
  static const int audioChannels = 1; // Mono
  
  // WebRTC configuration
  static const String stunServer = 'stun:stun.l.google.com:19302';
  
  // Validation
  static const int minChannelNameLength = 3;
  static const int minUsernameLength = 2;
  
  // UI
  static const Duration connectionCheckInterval = Duration(seconds: 2);
  static const Duration amplitudeUpdateInterval = Duration(milliseconds: 100);
  
  // Firebase paths
  static String channelPath(String channelId) => 'channels/$channelId';
  static String offersPath(String channelId) => 'channels/$channelId/offers';
  static String answersPath(String channelId) => 'channels/$channelId/answers';
  static String iceCandidatesPath(String channelId) => 'channels/$channelId/iceCandidates';
}

