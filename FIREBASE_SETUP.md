# Firebase Setup Guide

This walkie-talkie app uses Firebase Realtime Database for WebRTC signaling. Follow these steps to set up Firebase:

## 1. Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project" or select an existing project
3. Follow the setup wizard (disable Google Analytics if you want)

## 2. Enable Realtime Database

1. In your Firebase project, go to **Build** > **Realtime Database**
2. Click **Create Database**
3. Choose a location (preferably close to your users)
4. Start in **test mode** (for development) or **production mode** (for production)

## 3. Set Database Rules

For development/testing, use these rules (in **Realtime Database** > **Rules**):

```json
{
  "rules": {
    "channels": {
      ".read": true,
      ".write": true
    }
  }
}
```

**⚠️ Warning:** These rules allow anyone to read/write. For production, implement proper authentication.

For production with authentication:
```json
{
  "rules": {
    "channels": {
      "$channelId": {
        ".read": "auth != null",
        ".write": "auth != null",
        "offers": {
          ".read": true,
          ".write": true
        },
        "answers": {
          ".read": true,
          ".write": true
        },
        "iceCandidates": {
          ".read": true,
          ".write": true
        }
      }
    }
  }
}
```

## 4. Android Setup

1. In Firebase Console, click the Android icon (or go to **Project Settings** > **Add app** > **Android**)
2. Enter package name: `com.example.walkietalkie` (or your custom package name)
3. Download `google-services.json`
4. Place it in `android/app/` directory
5. Update `android/build.gradle` to include:
   ```gradle
   buildscript {
       dependencies {
           classpath 'com.google.gms:google-services:4.4.0'
       }
   }
   ```
6. Update `android/app/build.gradle` to add at the bottom:
   ```gradle
   apply plugin: 'com.google.gms.google-services'
   ```

## 5. iOS Setup

1. In Firebase Console, click the iOS icon (or go to **Project Settings** > **Add app** > **iOS**)
2. Enter bundle ID: `com.example.walkietalkie` (must match your iOS bundle ID)
3. Download `GoogleService-Info.plist`
4. Open Xcode and add the file to your `ios/Runner` directory
5. Make sure it's added to the Runner target

## 6. Install Dependencies

Run:
```bash
flutter pub get
```

## 7. Test the Setup

1. Run the app on multiple devices/emulators
2. Enter the same channel name on both devices
3. Enter different usernames
4. The devices should connect via WebRTC

## Troubleshooting

- **Connection issues**: Check that both devices are on the same network or have proper NAT traversal
- **Firebase errors**: Verify `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) are in the correct locations
- **WebRTC not connecting**: Check Firebase Realtime Database rules allow read/write access
- **Audio not working**: Ensure microphone permissions are granted

## Production Considerations

1. **TURN Servers**: For NAT traversal, add TURN servers to WebRTC configuration
2. **Authentication**: Implement Firebase Authentication for secure channels
3. **Database Rules**: Tighten security rules based on your use case
4. **Error Handling**: Add retry logic and better error messages
5. **Monitoring**: Set up Firebase Analytics and Crashlytics


