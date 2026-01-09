# FormulaDeck - The Lazy Student's Vault

A comprehensive offline-first Flutter app for students to reference mathematical and physics formulas with built-in calculators, bookmarks, and premium features.

## Features

- **500+ Formulas**: Comprehensive collection of formulas from Algebra, Geometry, Trigonometry, Calculus, Mechanics, Electricity, Waves, Thermodynamics, Chemistry, and Statistics
- **Offline First**: All formulas stored locally - works without internet
- **LaTeX Rendering**: Beautiful mathematical notation using flutter_math_fork
- **Built-in Calculator**: Auto-calculate results for formulas with calculator support
- **Bookmarks**: Save favorite formulas locally using Hive
- **Search & Filter**: Real-time search and category filtering
- **Material 3 Design**: Premium Material You design with smooth animations
- **Haptic Feedback**: Expressive tactile feedback for better UX
- **Google Sign-In**: Optional sign-in for bookmark sync (future feature)
- **AdMob Integration**: Native ads and banner ads for monetization
- **In-App Purchase**: Remove Ads + Dark Mode unlock

## Architecture

### Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   ├── formula.dart         # Formula, Variable, CalculatorConfig
│   └── category.dart        # Category model
├── services/                 # Business logic services
│   ├── formula_service.dart  # Formula loading and search
│   ├── calculator_service.dart # Formula calculations
│   ├── hive_service.dart    # Local storage (bookmarks, settings)
│   ├── auth_service.dart    # Google Sign-In
│   ├── ads_service.dart     # AdMob integration
│   └── iap_service.dart     # In-App Purchase
├── providers/                # Riverpod state providers
│   └── formula_provider.dart
├── screens/                  # UI screens
│   ├── home_screen.dart     # Main formula list
│   ├── formula_detail_screen.dart # Formula details + calculator
│   ├── bookmarks_screen.dart
│   └── settings_screen.dart
├── widgets/                  # Reusable widgets
│   ├── formula_card.dart    # Formula card widget
│   ├── latex_widget.dart    # LaTeX renderer
│   ├── native_ad_widget.dart
│   └── banner_ad_widget.dart
└── utils/                    # Utilities
    ├── app_theme.dart       # Material 3 theme
    └── app_router.dart      # GoRouter configuration
```

### State Management

- **Riverpod**: Used for state management
- Providers for formulas, search, bookmarks, settings

### Data Storage

- **Hive**: Local NoSQL database for bookmarks and settings
- **JSON Assets**: Formulas stored in `assets/formulas.json`

### Navigation

- **GoRouter**: Declarative routing with type-safe navigation

## Setup Instructions

### Prerequisites

- Flutter SDK 3.10.0 or higher
- Android Studio / Xcode for platform-specific setup
- Firebase project (optional, for Google Sign-In)
- AdMob account (for ads)
- Google Play Console / App Store Connect (for IAP)

### Installation

1. Clone the repository
```bash
git clone <repository-url>
cd formula_deck
```

2. Install dependencies
```bash
flutter pub get
```

3. Generate formulas JSON (if needed)
```bash
python3 scripts/generate_formulas.py
```

### Firebase Setup (Optional)

1. Create a Firebase project at https://console.firebase.google.com
2. Add Android/iOS apps to your Firebase project
3. Download `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
4. Place them in:
   - Android: `android/app/google-services.json`
   - iOS: `ios/Runner/GoogleService-Info.plist`

### AdMob Setup

1. Create an AdMob account at https://admob.google.com
2. Create ad units:
   - Banner Ad Unit ID
   - Native Ad Unit ID
3. Update `lib/services/ads_service.dart` with your ad unit IDs:
```dart
static const String _bannerAdUnitId = 'YOUR_BANNER_AD_UNIT_ID';
static const String _nativeAdUnitId = 'YOUR_NATIVE_AD_UNIT_ID';
```

### In-App Purchase Setup

1. **Android (Google Play)**:
   - Create a product in Google Play Console
   - Product ID: `remove_ads_dark_mode`
   - Update `lib/services/iap_service.dart` with your product ID

2. **iOS (App Store)**:
   - Create an in-app purchase in App Store Connect
   - Product ID: `remove_ads_dark_mode`
   - Update `lib/services/iap_service.dart` with your product ID

### Android Configuration

1. Update `android/app/build.gradle.kts`:
```kotlin
minSdk = 21
```

2. Add AdMob App ID to `android/app/src/main/AndroidManifest.xml` (already added with test ID):
```xml
<!-- AdMob App ID - Replace with your actual App ID from AdMob -->
<meta-data
    android:name="com.google.android.gms.ads.APPLICATION_ID"
    android:value="ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX"/>
```

**Note**: The manifest already includes a test App ID (`ca-app-pub-3940256099942544~3347511713`) for development. Replace it with your actual App ID from AdMob before releasing to production.

### iOS Configuration

1. Update `ios/Podfile`:
```ruby
platform :ios, '12.0'
```

2. Add AdMob App ID to `ios/Runner/Info.plist`:
```xml
<key>GADApplicationIdentifier</key>
<string>ca-app-pub-XXXXXXXXXXXXXXXX~XXXXXXXXXX</string>
```

## Building & Running

### Development
```bash
flutter run
```

### Build APK (Android)
```bash
flutter build apk --release
```

### Build IPA (iOS)
```bash
flutter build ipa --release
```

## Testing

Run unit tests:
```bash
flutter test
```

## Store Release Checklist

### Google Play Store

- [ ] Update version in `pubspec.yaml`
- [ ] Update `android/app/build.gradle` version code
- [ ] Test on multiple Android devices
- [ ] Generate signed APK/AAB
- [ ] Create store listing (screenshots, description)
- [ ] Set up pricing and distribution
- [ ] Submit for review

### Apple App Store

- [ ] Update version in `pubspec.yaml`
- [ ] Update `ios/Runner/Info.plist` version
- [ ] Test on multiple iOS devices
- [ ] Archive and upload via Xcode
- [ ] Create App Store listing
- [ ] Set up pricing and availability
- [ ] Submit for review

## Formula Data

Formulas are stored in `assets/formulas.json` with the following structure:

```json
{
  "formulas": [
    {
      "id": "unique_id",
      "title": "Formula Name",
      "category": "Category",
      "latex": "LaTeX expression",
      "description": "Description",
      "variables": [
        {"name": "var", "type": "double", "unit": "m", "description": "..."}
      ],
      "calculator": {
        "inputs": ["var1", "var2"],
        "output": "result"
      }
    }
  ]
}
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Submit a pull request

## License

[Your License Here]

## Support

For issues and feature requests, please use the GitHub issue tracker.

## Acknowledgments

- Formulas sourced from standard academic references
- Material Design 3 by Google
- Flutter community packages
