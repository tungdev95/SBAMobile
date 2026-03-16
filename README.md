## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Build for environment
fvm flutter build apk --no-tree-shake-icons --flavor dev --dart-define=ENV=dev
fvm flutter build appbundle --no-tree-shake-icons --flavor dev --dart-define=ENV=dev

fvm flutter build apk --no-tree-shake-icons --flavor uat --dart-define=ENV=uat
fvm flutter build appbundle --no-tree-shake-icons --flavor uat --dart-define=ENV=uat

fvm flutter build apk --no-tree-shake-icons --flavor pro --dart-define=ENV=pro
fvm flutter build appbundle --no-tree-shake-icons --flavor pro --dart-define=ENV=pro

### iOS
fvm flutter build ipa --flavor uat --release --dart-define=ENV=uat