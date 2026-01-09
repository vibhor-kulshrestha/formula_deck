# Release Checklist

## Pre-Release

### Code Quality
- [ ] All unit tests passing (`flutter test`)
- [ ] No linter errors (`flutter analyze`)
- [ ] Code formatted (`flutter format .`)
- [ ] All TODOs resolved or documented
- [ ] No debug print statements in production code

### Functionality Testing
- [ ] Test on Android (multiple devices/versions)
- [ ] Test on iOS (multiple devices/versions)
- [ ] Test offline functionality
- [ ] Test search functionality
- [ ] Test bookmark functionality
- [ ] Test calculator functionality
- [ ] Test LaTeX rendering
- [ ] Test dark mode toggle
- [ ] Test ad display (if applicable)
- [ ] Test IAP purchase flow
- [ ] Test Google Sign-In (if implemented)

### Assets & Resources
- [ ] App icon configured for all platforms
- [ ] Splash screen configured
- [ ] All required assets included
- [ ] formulas.json file validated
- [ ] No missing assets

### Configuration
- [ ] Version number updated in `pubspec.yaml`
- [ ] Build number incremented
- [ ] AdMob ad unit IDs configured
- [ ] IAP product IDs configured
- [ ] Firebase configuration files added (if using)
- [ ] API keys secured (not in code)

## Android Release

### Build Configuration
- [ ] `minSdkVersion` set appropriately (21+)
- [ ] `targetSdkVersion` set to latest
- [ ] ProGuard rules configured (if using)
- [ ] Signing configuration set up
- [ ] App bundle created (`flutter build appbundle`)

### Google Play Console
- [ ] App created in Google Play Console
- [ ] Store listing completed:
  - [ ] App name
  - [ ] Short description
  - [ ] Full description
  - [ ] Screenshots (phone, tablet)
  - [ ] Feature graphic
  - [ ] App icon
- [ ] Content rating completed
- [ ] Privacy policy URL provided
- [ ] Data safety section completed
- [ ] In-app products configured
- [ ] AdMob app ID added to store listing
- [ ] Release notes prepared

### Testing
- [ ] Internal testing track tested
- [ ] Closed testing track tested
- [ ] Open testing track tested (optional)

### Release
- [ ] Production release created
- [ ] Rollout percentage set (start with 20%)
- [ ] Release notes added
- [ ] Release submitted for review

## iOS Release

### Build Configuration
- [ ] iOS deployment target set (12.0+)
- [ ] Bundle identifier configured
- [ ] Signing & capabilities configured
- [ ] Info.plist updated
- [ ] App icons added to Assets.xcassets
- [ ] Launch screen configured

### App Store Connect
- [ ] App created in App Store Connect
- [ ] App information completed:
  - [ ] Name
  - [ ] Subtitle
  - [ ] Category
  - [ ] Content rights
- [ ] Pricing and availability set
- [ ] App privacy details completed
- [ ] In-app purchases configured
- [ ] Screenshots uploaded (all required sizes)
- [ ] App preview videos (optional)
- [ ] Description and keywords
- [ ] Support URL
- [ ] Marketing URL (optional)
- [ ] Privacy policy URL

### Testing
- [ ] TestFlight build uploaded
- [ ] Internal testing completed
- [ ] External testing completed (if applicable)

### Release
- [ ] Version information set
- [ ] Build selected
- [ ] Release notes prepared
- [ ] Submit for review

## Post-Release

### Monitoring
- [ ] Monitor crash reports (Firebase Crashlytics)
- [ ] Monitor analytics (Firebase Analytics)
- [ ] Monitor user reviews
- [ ] Monitor ad performance (AdMob)
- [ ] Monitor IAP purchases

### Updates
- [ ] Prepare hotfix if critical issues found
- [ ] Plan next version features
- [ ] Update documentation

## Compliance

### Google Play Store Policies
- [ ] Content policy compliance
- [ ] Privacy policy accessible
- [ ] Data collection disclosed
- [ ] Ads policy compliance
- [ ] IAP policy compliance
- [ ] Target audience appropriate

### Apple App Store Guidelines
- [ ] App Store Review Guidelines compliance
- [ ] Privacy policy accessible
- [ ] Data collection disclosed
- [ ] Ads policy compliance
- [ ] IAP policy compliance
- [ ] Age rating appropriate

### General
- [ ] GDPR compliance (if applicable)
- [ ] COPPA compliance (if targeting children)
- [ ] Accessibility features considered
- [ ] Localization considered (if applicable)

## Marketing

- [ ] App Store Optimization (ASO) keywords optimized
- [ ] Social media posts prepared
- [ ] Website/blog updated
- [ ] Press release (if applicable)
- [ ] User acquisition strategy planned

