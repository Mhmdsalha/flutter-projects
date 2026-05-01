# News App

A Flutter news application that fetches headlines from NewsAPI and presents them in a clean mobile UI with support for Arabic and English layouts.

## Features

- Browse top headlines in Business, Sports, and Science categories
- Search for articles by keyword
- Open full articles inside the app using WebView
- Switch between light and dark mode
- Toggle language direction between Arabic and English
- Persist theme and language preferences locally with SharedPreferences

## Tech Stack

- Flutter
- BLoC / Cubit state management
- Dio for HTTP requests
- SharedPreferences for local storage
- WebView Flutter for article previews

## Project Structure

```text
lib/
  layout/                 State management and app-level cubits
  modules/                Screens and feature modules
  shered/Network/         API and local cache helpers
  shered/components/      Shared widgets and constants
  styles/                 Theme and adaptive UI helpers
```

## Requirements

- Flutter SDK
- Dart SDK
- A valid [NewsAPI](https://newsapi.org/) key

## Run Locally

1. Install dependencies:

```bash
flutter pub get
```

2. Run the app with your NewsAPI key:

```bash
flutter run --dart-define=NEWS_API_KEY=your_api_key_here
```

## Build Example

```bash
flutter build apk --dart-define=NEWS_API_KEY=your_api_key_here
```

## Notes

- The repository does not include a real API key so it is safe to publish publicly.
- The current source code reflects an older Flutter project structure and dependency set.
- Folder names under `lib/shered/` are kept as-is to match the original project layout.

## License

This project is available for learning and personal use.
