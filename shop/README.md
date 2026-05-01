# Shop App

A Flutter e-commerce application built with BLoC/Cubit state management. The app connects to the Valux demo shop API and includes authentication, product browsing, favorites, cart management, search, profile updates, and Arabic/English UI support.

## Features

- Login and register flows
- Browse products and categories
- Search for products
- Add and remove favorites
- Add and remove cart items
- View and update user profile
- Switch between Arabic and English layouts
- Toggle light and dark theme
- Persist session, language, and theme locally

## Tech Stack

- Flutter
- BLoC / Cubit
- Dio
- SharedPreferences
- Carousel Slider
- Google Nav Bar

## Backend

This project uses the public demo API provided by Valux:

- Base URL: `https://student.valuxapps.com/api/`

## Project Structure

```text
lib/
  layout/                 Cubits and app state
  models/                 API response models
  modules/                Screens and feature flows
  shered/Network/         Remote and local data helpers
  shered/components/      Shared widgets and utilities
  styles/                 Themes and adaptive UI helpers
```

## Getting Started

1. Install dependencies:

```bash
flutter pub get
```

2. Run the app:

```bash
flutter run
```

## Notes

- The project stores the login token locally after authentication.
- No private API keys are committed in this repository.
- Some folder names, such as `shered`, are preserved to match the original project structure.

## License

This project is shared for learning and portfolio purposes.
