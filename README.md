# Walkie Talkie

A mobile app that serves as a walkie talkie over IP using WebRTC for real-time peer-to-peer audio communication.

## Features

- **Real-Time Communication**: Uses WebRTC (via flutter_webrtc) for peer-to-peer audio streaming
- **Firebase Signaling**: Firebase Realtime Database handles signaling (SDP offers/answers and ICE candidates)
- **Low Latency**: Configured for audio-only with Opus codec for <500ms delay on good networks
- **Push-to-Talk**: Hold button to record, release to send
- **Channel-Based**: Join channels by name to connect with other users
- **State Management**: Provider for managing connection status and user state
- **Material Design 3**: Modern, clean UI

## Setup

### Prerequisites

- Flutter SDK 3.0+ installed
- Android Studio / Xcode for mobile development
- Firebase account (free tier works)

### Installation

1. **Clone and install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Set up Firebase:**
   - Follow the detailed guide in [FIREBASE_SETUP.md](FIREBASE_SETUP.md)
   - Create a Firebase project
   - Enable Realtime Database
   - Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Place them in the appropriate directories

3. **Run the app:**
   ```bash
   flutter run
   ```

## Usage

1. Launch the app
2. Enter a channel name (same name on multiple devices to connect)
3. Enter your username
4. Tap "Join Channel"
5. Wait for connection (status will show "Connected")
6. Hold the large button to talk, release to send

## Technical Details

### Architecture

- **WebRTC Service**: Handles peer-to-peer connections, signaling via Firebase
- **Audio Service**: Manages microphone recording and playback using `record` and `audioplayers`
- **Provider**: State management for connection state, users, and recording status
- **Firebase**: Signaling backend for WebRTC (no custom server needed)

### Audio Configuration

- **Sample Rate**: 16kHz (efficient for voice)
- **Channels**: Mono (1 channel)
- **Codec**: Opus (via WebRTC)
- **Latency**: <500ms on good networks

### Permissions

- Microphone: Required for recording audio
- Internet: Required for WebRTC signaling and communication

## Limitations

- Basic P2P setup; for production, add TURN servers for NAT traversal
- Audio is mono, 16kHz for efficiency
- Requires devices on the same network or proper NAT traversal
- Firebase rules are open for demo; implement authentication for production

## Testing

Test with multiple devices:
1. Install on 2+ devices/emulators
2. Join the same channel on all devices
3. Use different usernames
4. Test push-to-talk functionality

## Production Considerations

1. **TURN Servers**: Add TURN servers for NAT traversal (via Firebase or custom)
2. **Authentication**: Implement Firebase Authentication for secure channels
3. **Database Rules**: Tighten security rules based on your use case
4. **Error Handling**: Add retry logic and better error messages
5. **Monitoring**: Set up Firebase Analytics and Crashlytics

## Dependencies

- `flutter_webrtc`: WebRTC for peer-to-peer communication
- `firebase_core` & `firebase_database`: Firebase integration
- `record`: Audio recording
- `audioplayers`: Audio playback
- `provider`: State management
- `permission_handler`: Handle permissions
- `connectivity_plus`: Network connectivity checks

## License

This project is open source and available for use.
