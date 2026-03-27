# Lab 10 - Authentication, Session Management & Notifications

Complete Flutter application demonstrating authentication flows, session management, and local notifications.

## Project Structure

This project contains all 6 lab modules in a single Flutter app:

```
lib/
├── main.dart                              # Main menu to navigate between labs
├── lab1_mock_login/                       # Lab 10.1: Mock Login
│   ├── services/
│   │   └── mock_auth_service.dart
│   └── screens/
│       ├── login_screen.dart
│       └── home_screen.dart
├── lab2_real_api_login/                   # Lab 10.2: Real API Login
│   ├── services/
│   │   └── auth_service.dart
│   └── screens/
│       ├── login_screen.dart
│       └── home_screen.dart
├── lab3_auto_login_logout/                # Lab 10.3: Auto Login & Logout
│   ├── services/
│   │   ├── auth_service.dart
│   │   └── session_manager.dart
│   └── screens/
│       ├── splash_screen.dart
│       ├── login_screen.dart
│       └── home_screen.dart
├── lab4_firebase_google_signin/           # Lab 10.4: Firebase Google Sign-In
│   └── screens/
│       └── auth_screen.dart
├── lab5_notification/                     # Lab 10.5: Local Notifications
│   ├── services/
│   │   └── notification_service.dart
│   └── screens/
│       └── notification_demo_screen.dart
└── lab_full/                              # Lab 10 Full: Integrated Project
    ├── services/
    │   ├── auth_service.dart
    │   └── session_manager.dart
    └── screens/
        ├── splash_screen.dart
        ├── login_screen.dart
        └── home_screen.dart
```

## Features

### Lab 10.1 - Mock Login (15%)
- Login UI with form validation
- Mock authentication with 2-second delay
- Email and password validation
- Navigation to Home screen on success
- **Test:** demo@example.com / password123

### Lab 10.2 - Real API Login (20%)
- Real REST API integration (DummyJSON)
- HTTP POST request for authentication
- JSON response parsing
- Loading and error states
- User profile display
- **Test:** emilys / emilyspass

### Lab 10.3 - Auto Login & Logout (25%)
- Session persistence with SharedPreferences
- Splash screen with auto-login check
- Automatic login if valid session exists
- Logout with session clearing
- Session duration tracking
- **Test:** emilys / emilyspass (restart app to test auto-login)

### Lab 10.4 - Firebase Google Sign-In (20%)
- Firebase Authentication setup guide
- Google Sign-In integration placeholder
- Configuration instructions included
- **Note:** Requires Firebase project setup

### Lab 10.5 - Local Notifications (10%) - MANDATORY (LO7)
- Flutter Local Notifications integration
- Permission handling for Android 13+
- Simple notifications
- Login success notifications
- Logout notifications
- **Test:** Tap buttons to trigger notifications

### Lab 10 Full - Integrated Project (10%)
- All features combined
- Real API authentication
- Session persistence
- Auto-login functionality
- Local notifications on login/logout
- Complete user flow
- **Test:** emilys / emilyspass

## Setup Instructions

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Run the Application

```bash
flutter run
```

### 3. Test Each Lab

The app starts with a menu showing all 6 labs. Tap any lab to explore its features.

## Dependencies

```yaml
dependencies:
  http: ^1.2.0                            # REST API calls
  shared_preferences: ^2.2.2              # Session persistence
  firebase_core: ^2.24.2                  # Firebase SDK
  firebase_auth: ^4.16.0                  # Firebase Authentication
  google_sign_in: ^6.2.1                  # Google Sign-In
  flutter_local_notifications: ^16.3.2    # Local notifications
```

## API Documentation

- **DummyJSON API:** https://dummyjson.com/docs/auth
- **Test Users:** https://dummyjson.com/users
- **SharedPreferences:** https://pub.dev/packages/shared_preferences
- **Local Notifications:** https://pub.dev/packages/flutter_local_notifications

## Test Credentials

For all labs using DummyJSON API:

- **Username:** emilys
- **Password:** emilyspass

Alternative users:
- michaelw / michaelwpass
- sophiab / sophiabpass

## Important Notes

### Android 13+ Notifications
Notifications require runtime permission on Android 13+. The app automatically requests permission when initialized.

### Firebase Setup (Lab 10.4)
To fully implement Firebase Google Sign-In:

1. Create a Firebase project at https://console.firebase.google.com
2. Add Android app with package name
3. Download `google-services.json` to `android/app/`
4. Add iOS app and download `GoogleService-Info.plist` to `ios/Runner/`
5. Configure SHA-1 key for Android
6. Enable Google Sign-In in Firebase Console

### Auto-Login Testing (Lab 10.3 & Full)
To test auto-login:
1. Login with valid credentials
2. Close the app completely (terminate)
3. Reopen the app
4. App should automatically navigate to Home screen

## Score Distribution

- Lab 10.1 - Mock Login: 15%
- Lab 10.2 - Real REST API Login: 20%
- Lab 10.3 - Auto Login & Logout: 25%
- Lab 10.4 - Firebase Google Sign-In: 20%
- Lab 10.5 - Local Notification (LO7): 10%
- Lab10_Full - Integrated Project: 10%

**Total: 100%**

## Learning Outcomes

After completing this lab, students will be able to:
- ✓ Implement authentication flows using mock and real REST APIs
- ✓ Manage user sessions using local persistence
- ✓ Implement auto-login and logout mechanisms
- ✓ Understand Firebase Authentication integration
- ✓ Integrate local notifications in mobile applications (LO7)

## Troubleshooting

### Dependencies not found
```bash
flutter pub get
flutter clean
flutter pub get
```

### Notification not showing
- Check notification permission in device settings
- Ensure app has notification permission granted
- Test on physical device (emulator may have limitations)

### API errors
- Check internet connection
- Verify credentials are correct
- Check API status at https://dummyjson.com

## Author

Lab 10 - PRM393 - Mobile Application Development

## License

This project is for educational purposes only.
