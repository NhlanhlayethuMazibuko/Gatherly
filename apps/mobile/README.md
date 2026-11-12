# Gatherly mobile app

Flutter app for Android and iOS. See [docs/development.md](../../docs/development.md) to run it.

## What's built so far

The start and account screens from the Figma file:

- Splash, Welcome
- Log in, Sign up, Under 18, Verify your email
- Reset password, Reset link sent, New password

There is no backend yet. Sign-in goes through `AuthService`, and for now the app uses `FakeAuthService`, which keeps accounts in memory. To try logging in, use `thabo@example.com` with the password `gatherly1`, or create an account first.

## Where things are

```
lib/
  main.dart        app entry point
  routes.dart      route names and which screen each one opens
  theme/           colours, text styles and the app theme
  screens/         one file per screen
  widgets/         button, text field and other shared pieces
  services/        AuthService and the fake version of it
  utils/           form validators and the 18+ check
test/              validator and screen tests
```

## Running it

```
flutter run -d chrome
```

For Android, start the emulator first (`flutter emulators --launch Medium_Phone_API_36.0`), then `flutter run`. The emulator needs a lot of memory, so close other apps first.

## Checks

```
flutter analyze
flutter test
```

Poppins is bundled in `assets/fonts` under the SIL Open Font License.
