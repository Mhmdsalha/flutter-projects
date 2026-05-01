# Social App

A Flutter social networking app powered by Firebase. The project includes authentication, feeds, chat, user discovery, profile management, image uploads, friend interactions, and push notifications.

## Features

- Email/password and Google sign-in
- Welcome, login, and registration flows
- Create posts with text and images
- Home feed with comments and social interactions
- User search and profile browsing
- One-to-one chat and messaging
- Friend requests and notifications
- Profile editing and image uploads
- Arabic and English interface support
- Light and dark theme support

## Tech Stack

- Flutter
- BLoC / Cubit state management
- Firebase Authentication
- Cloud Firestore
- Firebase Storage
- Firebase Messaging
- Flutter Local Notifications

## Firebase Setup

This project includes Firebase client configuration files for Android and iOS:

- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

For push notification sending, the server key is not stored in source control. Run the app with:

```bash
flutter run --dart-define=FCM_SERVER_KEY=your_fcm_server_key
```

## Project Structure

```text
lib/
  layout/                 Cubits and app state
  models/                 Firebase and app data models
  modules/                Screens and feature flows
  shered/Network/         Local/remote helpers
  shered/components/      Shared widgets and utilities
  styles/                 Themes and text styles
```

## Getting Started

1. Install dependencies:

```bash
flutter pub get
```

2. Ensure Firebase is configured for your app targets.

3. Run the app:

```bash
flutter run --dart-define=FCM_SERVER_KEY=your_fcm_server_key
```

## Notes

- The current package name and imports inside the source still use `shop` from the original project structure.
- The repository does not include the FCM server key anymore, which makes public publishing safer.
- Some generated Flutter platform files are intentionally kept because they are part of the app setup.

## License

This project is shared for learning and portfolio purposes.
