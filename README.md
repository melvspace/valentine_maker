# Valentine Maker - Flutter application

## [Try it yourself - valentine.melv.space](https://valentine.melv.space/)

[![main image](.assets/image.png)](https://valentine.melv.space/)

## Development

Requires Flutter 3.47 or newer (Dart 3.13 or newer). The project uses FVM's
`stable` channel.

```sh
fvm install
fvm flutter pub get
fvm dart run build_runner build
fvm flutter analyze
fvm flutter test
fvm flutter build web
```

Theme Tailor generates `lib/theme/theme.tailor.dart`, which is not checked in.
Run code generation after fetching dependencies and after changing theme models.

Android builds require Java 17 or newer. The updated Firebase SDK requires iOS 15
and macOS 10.15 or newer. On macOS, refresh the existing CocoaPods lockfile before
building the macOS app:

```sh
pod update --project-directory=macos --repo-update
```

Linux builds require the GStreamer development packages used by `audioplayers`:
`libgstreamer1.0-dev` and `libgstreamer-plugins-base1.0-dev` on Ubuntu/Debian.

### Dependency compatibility

- Sentry is currently on 8.14.2: Sentry 9.30.1 pins JNI 0.14.2, while the current
  `path_provider_android` requires JNI 1.x. The Android build includes a scoped
  Kotlin language-version adjustment for Sentry 8.
- Theme Tailor currently constrains `analyzer` to 13.x.
- `flutter_painter_v2` 2.1.1 is the last published version and is discontinued.
