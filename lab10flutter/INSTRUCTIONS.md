# Lab 10 - Detailed Instructions

## Overview

This project contains ALL 6 lab modules in a single Flutter application. Each lab is organized as a separate module under the `lib/` directory.

## Quick Start

### 1. Install Dependencies

```bash
cd d:\GiaoTrinhHoc\Ky8\PRM393\lab10flutter
flutter pub get
```

### 2. Run the Application

```bash
flutter run
```

The app will start with a **Main Menu** showing all 6 lab options. Tap any lab to explore its features.

## Lab Modules Explained

### Lab 10.1 - Mock Login (15%)
**Location:** `lib/lab1_mock_login/`

**What it does:**
- Displays a login form with email and password fields
- Validates input (email format, password length)
- Simulates backend authentication with 2-second delay
- Shows success/error messages
- Navigates to Home screen on successful login

**How to test:**
1. From main menu, tap "Lab 10.1 - Mock Login"
2. Enter: demo@example.com / password123
3. Click "Login"
4. Wait 2 seconds
5. See Home screen with user info

**Key files:**
- `services/mock_auth_service.dart` - Mock authentication logic
- `screens/login_screen.dart` - Login UI with form validation
- `screens/home_screen.dart` - Success screen

---

### Lab 10.2 - Real API Login (20%)
**Location:** `lib/lab2_real_api_login/`

**What it does:**
- Authenticates users via DummyJSON REST API
- Sends HTTP POST request to https://dummyjson.com/auth/login
- Parses JSON response
- Displays user profile data from API
- Handles loading states and errors

**How to test:**
1. From main menu, tap "Lab 10.2 - Real API Login"
2. Enter: emilys / emilyspass
3. Click "Login"
4. See real user data from API
5. View profile with avatar, username, email

**Key files:**
- `services/auth_service.dart` - HTTP REST API calls
- `screens/login_screen.dart` - Login UI with API integration
- `screens/home_screen.dart` - Profile display

**API Details:**
- Endpoint: POST https://dummyjson.com/auth/login
- Body: `{"username": "emilys", "password": "emilyspass"}`
- Response: User object with token

---

### Lab 10.3 - Auto Login & Logout (25%)
**Location:** `lib/lab3_auto_login_logout/`

**What it does:**
- Saves authentication token using SharedPreferences
- Implements Splash screen that checks for existing session
- Auto-logs in user if valid token exists
- Displays session duration
- Clears session on logout

**How to test:**
1. From main menu, tap "Lab 10.3 - Auto Login & Logout"
2. See Splash screen (2 seconds)
3. Login with: emilys / emilyspass
4. See Home screen with session info
5. **Close app completely** (swipe away from recent apps)
6. **Reopen app**
7. Notice: App skips login and goes straight to Home screen
8. Click "Logout" to clear session

**Key files:**
- `services/session_manager.dart` - SharedPreferences wrapper
- `services/auth_service.dart` - Auth with session saving
- `screens/splash_screen.dart` - Initial routing logic
- `screens/login_screen.dart` - Login UI
- `screens/home_screen.dart` - Home with session display

**Important:** To test auto-login, you MUST close and reopen the app!

---

### Lab 10.4 - Firebase Google Sign-In (20%)
**Location:** `lib/lab4_firebase_google_signin/`

**What it does:**
- Shows Firebase setup instructions
- Placeholder for Google Sign-In implementation
- Requires Firebase project configuration

**How to test:**
1. From main menu, tap "Lab 10.4 - Firebase Google Sign-In"
2. Read setup instructions
3. Click "Sign in with Google" button (shows info message)

**Full implementation requires:**
1. Create Firebase project at https://console.firebase.google.com
2. Add Android app with package name: `com.example.lab10flutter`
3. Download `google-services.json` → place in `android/app/`
4. Add iOS app
5. Download `GoogleService-Info.plist` → place in `ios/Runner/`
6. Enable Google Sign-In in Authentication section
7. Configure SHA-1 fingerprint for Android:
   ```bash
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```

**Key files:**
- `screens/auth_screen.dart` - Firebase auth screen with instructions

**Note:** This lab is a placeholder. Full implementation available in Lab10_Full (when Firebase is configured).

---

### Lab 10.5 - Local Notifications (10%) - MANDATORY (LO7)
**Location:** `lib/lab5_notification/`

**What it does:**
- Integrates flutter_local_notifications package
- Requests notification permission (Android 13+)
- Shows simple notifications
- Demonstrates login/logout notifications
- Customizable with titles, bodies, icons

**How to test:**
1. From main menu, tap "Lab 10.5 - Local Notifications"
2. Grant notification permission if prompted
3. Tap "Simple Notification" button
4. Check notification tray - see notification
5. Tap "Login Success Notification" button
6. Check notification tray again

**Key files:**
- `services/notification_service.dart` - Notification logic
- `screens/notification_demo_screen.dart` - Demo UI

**Permissions:**
- Android 13+: Automatically requests at runtime
- iOS: Prompts user on first notification

**Important:** Test on a physical device for best results. Emulators may have notification limitations.

---

### Lab 10 Full - Integrated Project (10%)
**Location:** `lib/lab_full/`

**What it does:**
- Combines ALL features from Labs 1-5
- Real API authentication (DummyJSON)
- Session persistence with SharedPreferences
- Auto-login on app restart
- Local notifications on login AND logout
- Complete authentication flow

**How to test:**
1. From main menu, tap "Lab 10 Full - Integrated Project"
2. See Splash screen (initializing notifications + checking session)
3. Login with: emilys / emilyspass
4. **Check notification tray** - see "Login Successful" notification
5. See Home screen with full user info and session details
6. Close app, reopen - auto-login works
7. Click "Logout"
8. **Check notification tray** - see "Logged Out" notification
9. Redirected to Login screen

**Key files:**
- `services/session_manager.dart` - Session management
- `services/auth_service.dart` - Auth + notifications
- `screens/splash_screen.dart` - Splash with auto-login
- `screens/login_screen.dart` - Login UI
- `screens/home_screen.dart` - Home with all info

**This is the complete, production-ready implementation!**

---

## Project Structure

```
lab10flutter/
├── lib/
│   ├── main.dart                          # Main menu
│   ├── lab1_mock_login/
│   │   ├── services/
│   │   │   └── mock_auth_service.dart
│   │   └── screens/
│   │       ├── login_screen.dart
│   │       └── home_screen.dart
│   ├── lab2_real_api_login/
│   │   ├── services/
│   │   │   └── auth_service.dart
│   │   └── screens/
│   │       ├── login_screen.dart
│   │       └── home_screen.dart
│   ├── lab3_auto_login_logout/
│   │   ├── services/
│   │   │   ├── auth_service.dart
│   │   │   └── session_manager.dart
│   │   └── screens/
│   │       ├── splash_screen.dart
│   │       ├── login_screen.dart
│   │       └── home_screen.dart
│   ├── lab4_firebase_google_signin/
│   │   └── screens/
│   │       └── auth_screen.dart
│   ├── lab5_notification/
│   │   ├── services/
│   │   │   └── notification_service.dart
│   │   └── screens/
│   │       └── notification_demo_screen.dart
│   └── lab_full/
│       ├── services/
│       │   ├── auth_service.dart
│       │   └── session_manager.dart
│       └── screens/
│           ├── splash_screen.dart
│           ├── login_screen.dart
│           └── home_screen.dart
├── android/
├── ios/
├── pubspec.yaml
└── README.md
```

## Test Credentials

### For Mock Login (Lab 10.1):
- Email: demo@example.com
- Password: password123

### For Real API (Labs 10.2, 10.3, 10 Full):
- Username: emilys
- Password: emilyspass

**More test users:**
- michaelw / michaelwpass
- sophiab / sophiabpass
- View all: https://dummyjson.com/users

## Common Issues & Solutions

### Issue: Dependencies not found
```bash
flutter clean
flutter pub get
```

### Issue: Notification permission not working
- Check device settings → Apps → lab10flutter → Permissions → Notifications
- Enable notifications manually
- Restart app

### Issue: Notifications not showing
- Use physical device (emulator may have issues)
- Check notification sound/vibration settings
- Pull down notification tray manually

### Issue: Auto-login not working
- Make sure you COMPLETELY close the app (swipe from recent apps)
- Don't just minimize - must terminate
- Reopen app fresh

### Issue: API errors
- Check internet connection
- Verify credentials exactly: emilys / emilyspass
- DummyJSON API status: https://dummyjson.com

### Issue: App crashes on start
```bash
flutter clean
flutter pub get
flutter run
```

## Running on Different Platforms

### Android
```bash
flutter run
```

### iOS (Mac only)
```bash
cd ios
pod install
cd ..
flutter run
```

### Web
```bash
flutter run -d chrome
```

### Windows
```bash
flutter run -d windows
```

## Submission Checklist

According to requirements, you need separate projects. Since all labs are in ONE project here, you can:

### Option 1: Submit this single project
- Explain in submission that all labs are integrated
- Demonstrate each lab from the menu

### Option 2: Create separate project folders
Copy this structure 6 times and modify `main.dart` for each:

1. **Lab10_1_MockLogin**: Change `main.dart` to start with Lab 1 login screen
2. **Lab10_2_RealApiLogin**: Change `main.dart` to start with Lab 2 login screen
3. **Lab10_3_AutoLogin_Logout**: Change `main.dart` to start with Lab 3 splash screen
4. **Lab10_4_FirebaseGoogleSignIn**: Change `main.dart` to start with Lab 4 auth screen
5. **Lab10_5_Notification**: Change `main.dart` to start with Lab 5 notification screen
6. **Lab10_Full**: Change `main.dart` to start with Lab Full splash screen

## Score Distribution

- Lab 10.1 - Mock Login: **15%**
- Lab 10.2 - Real REST API Login: **20%**
- Lab 10.3 - Auto Login & Logout: **25%**
- Lab 10.4 - Firebase Google Sign-In: **20%**
- Lab 10.5 - Local Notification (LO7): **10%** ✓ MANDATORY
- Lab10_Full - Integrated Project: **10%**

**Total: 100%**

## Additional Resources

- DummyJSON API Docs: https://dummyjson.com/docs
- SharedPreferences: https://pub.dev/packages/shared_preferences
- Local Notifications: https://pub.dev/packages/flutter_local_notifications
- Firebase Setup: https://firebase.google.com/docs/flutter/setup
- HTTP Package: https://pub.dev/packages/http

## Contact

If you have issues, check:
1. README.md
2. This INSTRUCTIONS.md file
3. Code comments in each file
4. Flutter documentation

Good luck with your lab! 🚀
