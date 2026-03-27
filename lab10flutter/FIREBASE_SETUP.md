# Firebase Google Sign-In Setup Guide

## ✅ Đã Hoàn Thành

- ✓ Thêm `google-services.json` vào `android/app/`
- ✓ Cập nhật `android/build.gradle.kts`
- ✓ Cập nhật `android/app/build.gradle.kts`
- ✓ Tạo `FirebaseAuthService`
- ✓ Tạo Auth Screen với Google Sign-In
- ✓ Tạo Home Screen hiển thị thông tin user

## 🔧 Các Bước Tiếp Theo

### 1. Lấy Firebase Configuration từ Firebase Console

#### Bước 1.1: Mở Firebase Console
1. Truy cập: https://console.firebase.google.com
2. Chọn project của bạn
3. Click vào biểu tượng **Settings (⚙️)** > **Project settings**

#### Bước 1.2: Lấy Android Configuration
1. Scroll xuống phần **Your apps**
2. Chọn Android app của bạn
3. Click **SDK setup and configuration**
4. Copy các giá trị sau:

```dart
apiKey: "AIza......"
appId: "1:123456789:android:abc123"
messagingSenderId: "123456789"
projectId: "your-project-id"
```

#### Bước 1.3: Cập nhật file `lib/firebase_options.dart`

Mở file `lib/firebase_options.dart` và thay thế:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'AIzaSy...', // Từ Firebase Console
  appId: '1:1234567890:android:abcd1234', // Từ Firebase Console
  messagingSenderId: '1234567890', // Từ Firebase Console
  projectId: 'your-project-id', // Từ Firebase Console
  storageBucket: 'your-project-id.appspot.com',
);
```

### 2. Lấy SHA-1 Certificate Fingerprint

SHA-1 key cần thiết để Google Sign-In hoạt động trên Android.

#### Bước 2.1: Lấy Debug SHA-1 (cho development)

Chạy lệnh này trong terminal:

**Windows:**
```bash
cd android
.\gradlew signingReport
```

**macOS/Linux:**
```bash
cd android
./gradlew signingReport
```

#### Bước 2.2: Tìm SHA-1 trong output

Tìm dòng có chữ **SHA1** trong phần **debug**:

```
Variant: debug
Config: debug
Store: C:\Users\YourName\.android\debug.keystore
Alias: AndroidDebugKey
MD5: XX:XX:XX...
SHA1: AA:BB:CC:DD:EE:FF:00:11:22:33:44:55:66:77:88:99:AA:BB:CC:DD
SHA-256: ...
```

Copy giá trị SHA1 (ví dụ: `AA:BB:CC:DD:EE:FF:00:11:22:33:44:55:66:77:88:99:AA:BB:CC:DD`)

#### Bước 2.3: Thêm SHA-1 vào Firebase

1. Quay lại Firebase Console
2. **Project Settings** > **Your apps** > Chọn Android app
3. Scroll xuống phần **SHA certificate fingerprints**
4. Click **Add fingerprint**
5. Paste SHA-1 key và click **Save**

### 3. Enable Google Sign-In trong Firebase

1. Trong Firebase Console, vào **Authentication**
2. Click tab **Sign-in method**
3. Click vào **Google**
4. Enable switch
5. Chọn **Support email** (email của bạn)
6. Click **Save**

### 4. Download và Replace google-services.json mới

Sau khi add SHA-1, bạn cần download lại file `google-services.json`:

1. Firebase Console > **Project Settings**
2. Scroll xuống phần **Your apps** > Android app
3. Click **Download google-services.json**
4. **REPLACE** file cũ trong `android/app/google-services.json`

### 5. Clean và Rebuild Project

```bash
cd d:\GiaoTrinhHoc\Ky8\PRM393\lab10flutter
flutter clean
flutter pub get
cd android
.\gradlew clean
cd ..
flutter run
```

## 🧪 Test Google Sign-In

1. Chạy app: `flutter run`
2. Từ menu chính, chọn **Lab 10.4 - Firebase Google Sign-In**
3. Đợi Firebase initialize
4. Click **Sign in with Google**
5. Chọn Google account
6. Grant permissions
7. ✅ Đăng nhập thành công!

## ⚠️ Troubleshooting

### Lỗi: "PlatformException (sign_in_failed, com.google.android.gms.common.api.ApiException: 10:)"

**Nguyên nhân:** SHA-1 certificate chưa được thêm vào Firebase

**Giải pháp:**
1. Lấy SHA-1 bằng `gradlew signingReport`
2. Add SHA-1 vào Firebase Console
3. Download lại `google-services.json`
4. Replace file cũ
5. Clean và rebuild

### Lỗi: "Firebase initialization failed"

**Giải pháp:**
1. Kiểm tra file `lib/firebase_options.dart` đã được cập nhật đúng
2. Kiểm tra `google-services.json` có trong `android/app/`
3. Chạy `flutter clean` và `flutter pub get`

### Lỗi: "A network error occurred"

**Giải pháp:**
1. Kiểm tra internet connection
2. Enable Google Sign-In trong Firebase Console
3. Kiểm tra SHA-1 đã được add

### Lỗi build Gradle

**Giải pháp:**
```bash
cd android
.\gradlew clean
cd ..
flutter clean
flutter pub get
flutter run
```

## 📝 Checklist Hoàn Thành

- [ ] File `google-services.json` trong `android/app/`
- [ ] Cập nhật `firebase_options.dart` với config từ Firebase Console
- [ ] Lấy SHA-1 fingerprint
- [ ] Add SHA-1 vào Firebase Console
- [ ] Download lại `google-services.json` mới
- [ ] Enable Google Sign-In trong Firebase Authentication
- [ ] Clean và rebuild project
- [ ] Test Google Sign-In thành công

## 🎯 Kết Quả Mong Đợi

Sau khi hoàn thành tất cả các bước:

1. ✅ App khởi động không lỗi
2. ✅ Firebase initialize thành công
3. ✅ Click "Sign in with Google" mở dialog chọn account
4. ✅ Sau khi chọn account, điều hướng đến Home screen
5. ✅ Hiển thị thông tin user: tên, email, avatar
6. ✅ Có thể sign out thành công

## 📞 Cần Trợ Giúp?

Nếu gặp vấn đề, hãy kiểm tra:

1. **Firebase Console**: Authentication > Sign-in method > Google (enabled?)
2. **SHA-1**: Đã add vào Firebase Console chưa?
3. **google-services.json**: File mới nhất từ Firebase Console?
4. **firebase_options.dart**: Config values đã đúng?
5. **Internet**: App có kết nối được không?

## 🚀 Hoàn Thành!

Sau khi làm xong các bước trên, Lab 10.4 sẽ hoạt động hoàn hảo với Google Sign-In!

Good luck! 🎉
