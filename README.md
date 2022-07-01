# app

A Flutter bootstrap project on Steroids.

## Setup

1. Git clone
2. _Run `flutterfire configure` to reconfigure firebase for new project_

```
After this initial running of flutterfire configure, you need to re-run the command any time that you:
Start supporting a new platform in your Flutter app.
Start using a new Firebase service or product in your Flutter app, especially if you start using sign-in with Google, Crashlytics, Performance Monitoring, or Realtime Database.
Re-running the command ensures that your Flutter app's Firebase configuration is up-to-date and (for Android) automatically adds any required Gradle plugins to your app.
```

## Contains

- State management with [Provider](https://pub.dev/packages/provider)
- [Firebase remote config](https://pub.dev/packages/firebase_remote_config)
- Load configuration from environment files using [flutter_dotenv](https://pub.dev/packages/flutter_dotenv)
- Firebase ([setup](https://firebase.google.com/docs/flutter/setup))

  - Use remoteConfig from Firebase ([setup](https://firebase.google.com/docs/remote-config/get-started?platform=flutter))

- Social Authentication
  - Google ([instructions](https://www.youtube.com/watch?v=Q00Foa8CiDk&ab_channel=CodeX))
- Internet connectivity checker (based on [connectivity_plus](https://pub.dev/packages/connectivity_plus))
- [http client](https://pub.dev/packages/http/install)
- Form creation via [flutter_form_builder](https://pub.dev/packages/flutter_form_builder)
- Support for Native splash screen using [flutter_native_splash](https://pub.dev/packages/flutter_native_splash)
  Run `flutter pub run flutter_native_splash:create --path=flutter_native_splash.yaml` to update native code every time you edit `flutter_native_splash.yaml`.
