# Firebase Data Connect Setup

## Dependencies Updated

The following dependencies have been added/updated in `pubspec.yaml`:

- `firebase_core: ^3.15.0` (upgraded from ^2.32.0)
- `firebase_database: ^11.1.0` (upgraded from ^10.4.0)
- `firebase_data_connect: ^0.1.5` (new dependency)
- SDK constraint updated to `>=3.4.0 <4.0.0` (from >=3.0.0)

## Required Actions

1. **Upgrade Flutter** to get Dart SDK 3.4.0 or higher:
   ```bash
   flutter upgrade
   ```
   
   If you have local changes, you may need to:
   ```bash
   git stash
   flutter upgrade
   git stash pop
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Verify installation**:
   ```bash
   flutter analyze lib/dataconnect_generated/
   ```

## Note

The generated files in `lib/dataconnect_generated/` are currently not being used in the application code. If you plan to use Firebase Data Connect features, you'll need to import and use the generated connector classes in your code.

