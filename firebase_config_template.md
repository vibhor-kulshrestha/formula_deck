# Firebase Configuration Template

## Setup Instructions

### 1. Create Firebase Project

1. Go to https://console.firebase.google.com
2. Click "Add project"
3. Enter project name: "FormulaDeck"
4. Enable Google Analytics (optional)
5. Create project

### 2. Add Android App

1. Click "Add app" → Android
2. Package name: `com.example.formula_deck` (update to your package)
3. App nickname: "FormulaDeck Android"
4. Download `google-services.json`
5. Place in: `android/app/google-services.json`

### 3. Add iOS App

1. Click "Add app" → iOS
2. Bundle ID: `com.example.formulaDeck` (update to your bundle ID)
3. App nickname: "FormulaDeck iOS"
4. Download `GoogleService-Info.plist`
5. Place in: `ios/Runner/GoogleService-Info.plist`

### 4. Enable Authentication

1. Go to Authentication → Sign-in method
2. Enable "Google" sign-in provider
3. Add support email
4. Save

### 5. Firestore Setup (Optional - for bookmark sync)

1. Go to Firestore Database
2. Create database
3. Start in test mode (update rules for production)
4. Set location

### 6. Update Android Configuration

Add to `android/app/build.gradle`:
```gradle
dependencies {
    // ... existing dependencies
    implementation platform('com.google.firebase:firebase-bom:32.7.0')
    implementation 'com.google.firebase:firebase-core'
    implementation 'com.google.firebase:firebase-auth'
}
```

Add to `android/build.gradle`:
```gradle
dependencies {
    classpath 'com.google.gms:google-services:4.4.0'
}
```

Add to end of `android/app/build.gradle`:
```gradle
apply plugin: 'com.google.gms.google-services'
```

### 7. Update iOS Configuration

Add to `ios/Podfile`:
```ruby
pod 'Firebase/Auth'
pod 'Firebase/Core'
```

Run:
```bash
cd ios
pod install
```

### 8. Security Rules (Firestore)

For production, update Firestore rules:
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## Testing Without Firebase

The app works without Firebase configuration. Google Sign-In will simply not be available, but all other features (formulas, bookmarks, calculator) work offline.

To disable Firebase initialization errors, the app already handles Firebase initialization gracefully in `main.dart`.

