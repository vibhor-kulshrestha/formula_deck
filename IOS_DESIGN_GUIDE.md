# iOS Design Guide for FormulaDeck

## Overview

FormulaDeck has been extended to provide a premium, native iOS experience using Cupertino design principles and Liquid Glass (glassmorphism) effects. The app automatically adapts its UI based on the platform, providing Material 3 design on Android and Cupertino design on iOS.

## Platform Detection

The app uses `PlatformUtils` to detect the platform and iOS version:

- **iOS Detection**: Uses `Platform.isIOS` to detect iOS/iPadOS devices
- **iPad Detection**: Uses `DeviceInfoPlus` to detect iPad devices
- **iOS Version Check**: Checks iOS version to enable Liquid Glass effects (iOS 15+)

## Architecture

### Adaptive Theme System

The app uses `AdaptiveTheme` to switch between Material and Cupertino themes:

- **iOS**: Uses `CupertinoApp` with `CupertinoThemeData`
- **Android**: Uses `MaterialApp` with Material 3 theme
- **Theme Switching**: Automatically switches based on platform detection

### Adaptive Widgets

All UI components are platform-adaptive:

1. **AdaptiveAppBar**: Uses `CupertinoNavigationBar` on iOS, `AppBar` on Android
2. **AdaptiveSearchField**: Uses `CupertinoSearchTextField` on iOS, `TextField` on Android
3. **AdaptiveScaffold**: Uses `CupertinoPageScaffold` on iOS, `Scaffold` on Android
4. **AdaptiveListTile**: Uses `CupertinoListTile` on iOS, `ListTile` on Android
5. **AdaptiveButton**: Uses `CupertinoButton` on iOS, `ElevatedButton` on Android

## Liquid Glass Effects

### Implementation

Liquid Glass (glassmorphism) effects are implemented using:

- **BackdropFilter**: Uses Flutter's `BackdropFilter` with blur effects
- **Translucent Backgrounds**: Semi-transparent backgrounds with blur
- **Border Highlights**: Subtle white borders for depth
- **Version Detection**: Only enabled on iOS 15+ devices

### Usage

```dart
LiquidGlass(
  opacity: 0.7,
  borderRadius: BorderRadius.circular(12),
  child: YourWidget(),
)
```

### Fallback

For older iOS versions (< iOS 15), the app uses:
- Semi-transparent backgrounds without blur
- Same visual structure but simpler effects

## iOS-Specific Screens

### Home Screen (`IOSHomeScreen`)

- **Navigation**: Uses `CupertinoNavigationBar` with large title
- **Search**: Uses `CupertinoSearchTextField` with native iOS styling
- **List**: Uses `CustomScrollView` with `SliverList` for smooth scrolling
- **Cards**: Uses `IOSFormulaCard` with Liquid Glass effects
- **iPad Support**: Automatically wraps with `IPadScaffold` on iPad

### Formula Detail Screen (`IOSFormulaDetailScreen`)

- **Layout**: Uses `CupertinoPageScaffold` with translucent navigation bar
- **Formula Display**: LaTeX rendered in Liquid Glass container
- **Calculator**: Uses `CupertinoTextField` for inputs
- **Animations**: Smooth iOS-style transitions

### Bookmarks Screen (`IOSBookmarksScreen`)

- **Empty State**: Native iOS empty state with SF Symbols icons
- **List**: Uses `CustomScrollView` with `SliverList`
- **Cards**: Consistent with home screen design

### Settings Screen (`IOSSettingsScreen`)

- **Sections**: Uses `CupertinoListSection` for grouped settings
- **Toggles**: Uses `CupertinoSwitch` for boolean settings
- **Actions**: Uses `CupertinoButton` for actions
- **Dialogs**: Uses `CupertinoAlertDialog` for confirmations

## iPad Support

### Sidebar Navigation

On iPad, the app uses a sidebar navigation pattern:

- **Sidebar**: Fixed-width sidebar (280px) with navigation items
- **Main Content**: Expanded content area
- **Liquid Glass**: Sidebar uses Liquid Glass effects
- **Responsive**: Automatically detects iPad and adjusts layout

### Implementation

```dart
IPadScaffold(
  body: YourContent(),
)
```

The `IPadScaffold` automatically:
- Detects iPad devices
- Adds sidebar navigation
- Adjusts layout for larger screens

## Typography

### iOS Typography

The app uses Apple's San Francisco font family:

- **Display Font**: `.SF Pro Display` for headings
- **Text Font**: `.SF Pro Text` for body text
- **Sizes**: Follows iOS Human Interface Guidelines
  - Large Title: 34pt
  - Title: 28pt
  - Headline: 22pt
  - Body: 17pt
  - Subheadline: 15pt
  - Footnote: 13pt

## Icons

### SF Symbols

The app uses SF Symbols (CupertinoIcons) for consistency:

- **Bookmark**: `CupertinoIcons.bookmark` / `CupertinoIcons.bookmark_fill`
- **Settings**: `CupertinoIcons.settings`
- **Search**: `CupertinoIcons.search`
- **Home**: `CupertinoIcons.home`
- **Person**: `CupertinoIcons.person_circle`

## Colors

### iOS Color System

The app uses Cupertino's dynamic color system:

- **System Colors**: `CupertinoColors.systemBlue`, `systemGrey`, etc.
- **Adaptive Colors**: Colors adapt to light/dark mode
- **Semantic Colors**: Uses semantic color names (label, secondaryLabel, etc.)

## Navigation

### GoRouter Integration

The app uses GoRouter for navigation, with platform-specific screens:

- **iOS Routes**: Automatically use iOS screens on iOS devices
- **Android Routes**: Use Material screens on Android devices
- **Back Navigation**: Proper back button handling with `PopScope`

## Haptics

### iOS Haptic Feedback

The app uses iOS-style haptic feedback:

- **Light Impact**: For button taps
- **Medium Impact**: For important actions (bookmark toggle)
- **Selection**: For list item selection

## App Store Compliance

### Guidelines

The iOS implementation follows Apple's App Store guidelines:

1. **Human Interface Guidelines**: Follows iOS design patterns
2. **Accessibility**: Supports Dynamic Type and VoiceOver
3. **Privacy**: Proper handling of user data
4. **IAP**: Proper implementation of in-app purchases
5. **Ads**: Compliant ad placement and disclosure

## Testing

### Platform Testing

Test the iOS implementation on:

1. **iPhone**: Test on various iPhone models (iPhone SE, iPhone 14, iPhone 15 Pro Max)
2. **iPad**: Test on iPad models (iPad Air, iPad Pro)
3. **iOS Versions**: Test on iOS 14+ (with fallbacks for older versions)

### Visual Testing

Verify:

- Liquid Glass effects render correctly
- Navigation transitions are smooth
- Typography scales properly
- Colors adapt to light/dark mode
- iPad layout works correctly

## Maintenance

### Adding New Screens

When adding new screens:

1. Create iOS-specific version if needed
2. Use adaptive widgets where possible
3. Add Liquid Glass effects for iOS 15+
4. Test on both iPhone and iPad
5. Ensure proper navigation handling

### Updating Styles

To update iOS styles:

1. Modify `AdaptiveTheme.getCupertinoTheme()`
2. Update widget styles in iOS-specific screens
3. Test on multiple iOS versions
4. Ensure Material styles remain unchanged

## Resources

- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [SF Symbols](https://developer.apple.com/sf-symbols/)
- [Cupertino Widgets](https://api.flutter.dev/flutter/cupertino/cupertino-library.html)
- [Flutter Platform Detection](https://docs.flutter.dev/development/platform-integration/platform-adaptations)

