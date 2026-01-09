# Quick Start Guide

## Get Started in 5 Minutes

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Run the App

```bash
flutter run
```

That's it! The app will run with:
- ✅ All 529 formulas available offline
- ✅ Search and bookmark functionality
- ✅ Calculator for supported formulas
- ✅ Test ads (in debug mode)
- ✅ Light theme (dark mode requires IAP)

## Development Setup

### Prerequisites
- Flutter SDK 3.10.0+
- Android Studio / Xcode
- Dart SDK

### Run Tests

```bash
flutter test
```

### Check Code Quality

```bash
flutter analyze
flutter format .
```

### Generate Formulas (if needed)

```bash
python3 scripts/generate_formulas.py
```

## Configuration

### Minimal Setup (Works Out of the Box)

The app works immediately without any configuration:
- Formulas are stored locally
- Bookmarks work offline
- Calculator works for common formulas
- Test ads are used in debug mode

### Full Setup (For Production)

1. **AdMob** (for monetization)
   - Create account at https://admob.google.com
   - Get ad unit IDs
   - Update `lib/services/ads_service.dart`

2. **Firebase** (for Google Sign-In)
   - Follow `firebase_config_template.md`
   - Optional - app works without it

3. **IAP** (for premium features)
   - Set up products in store consoles
   - Update `lib/services/iap_service.dart`

## Project Structure Overview

```
lib/
├── main.dart              # Entry point
├── models/               # Data structures
├── services/             # Business logic
├── providers/            # State (Riverpod)
├── screens/              # UI screens
├── widgets/              # Reusable components
└── utils/                # Helpers

assets/
└── formulas.json         # 529 formulas

test/                     # Unit tests
```

## Common Tasks

### Add a New Formula

1. Edit `assets/formulas.json`
2. Add formula object with required fields
3. Restart app

### Modify Calculator Logic

Edit `lib/services/calculator_service.dart`

### Change Theme

Edit `lib/utils/app_theme.dart`

### Add New Screen

1. Create screen in `lib/screens/`
2. Add route in `lib/utils/app_router.dart`

## Troubleshooting

### LaTeX Not Rendering
- Check formula syntax in `formulas.json`
- Verify `flutter_math_fork` is installed

### Ads Not Showing
- Check AdMob configuration
- Verify ad unit IDs
- Check if ads are removed via IAP

### Calculator Not Working
- Verify formula has `calculator` config
- Check input variable names match
- See `calculator_service.dart` for supported formulas

### Build Errors
- Run `flutter clean`
- Run `flutter pub get`
- Check Flutter version: `flutter --version`

## Next Steps

1. Read `README.md` for detailed documentation
2. Check `ARCHITECTURE.md` for design decisions
3. Review `RELEASE_CHECKLIST.md` before publishing
4. Follow `firebase_config_template.md` for Firebase setup

## Support

For issues:
1. Check existing documentation
2. Review code comments
3. Check Flutter/Dart documentation
4. Create GitHub issue

## Happy Coding! 🚀

