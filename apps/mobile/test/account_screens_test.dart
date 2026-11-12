import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gatherly/main.dart';
import 'package:gatherly/routes.dart';
import 'package:gatherly/services/fake_auth_service.dart';

Future<void> pumpApp(WidgetTester tester, String route) async {
  tester.view.physicalSize = const Size(440, 956);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);

  await tester.pumpWidget(
    GatherlyApp(
      authService: FakeAuthService(delay: Duration.zero),
      initialRoute: route,
    ),
  );
  await tester.pumpAndSettle();
}

// fields are found by their order on screen
Future<void> enterField(WidgetTester tester, int index, String text) {
  return tester.enterText(find.byType(TextFormField).at(index), text);
}

Future<void> tapButton(WidgetTester tester, String label) async {
  await tester.tap(find.widgetWithText(TextButton, label));
  await tester.pumpAndSettle();
}

Future<void> fillSignUp(WidgetTester tester, {required String born}) async {
  await enterField(tester, 0, 'Thabo Mokoena');
  await enterField(tester, 1, 'new@example.com');
  await enterField(tester, 2, born);
  await enterField(tester, 3, 'gatherly1');
  await tester.tap(find.byType(Checkbox));
  await tester.pump();
}

void main() {
  testWidgets('splash moves on to welcome', (tester) async {
    await tester.pumpWidget(
      GatherlyApp(authService: FakeAuthService(delay: Duration.zero)),
    );
    expect(find.text('Create an account'), findsNothing);

    await tester.pumpAndSettle(const Duration(seconds: 2));
    expect(find.text('Create an account'), findsOneWidget);
  });

  testWidgets('welcome opens log in and sign up', (tester) async {
    await pumpApp(tester, AppRoutes.welcome);

    await tapButton(tester, 'Log in');
    expect(find.text('Welcome back'), findsOneWidget);

    await tester.tap(find.text('Sign up'));
    await tester.pumpAndSettle();
    expect(find.text('Create your account'), findsOneWidget);
  });

  group('log in', () {
    testWidgets('shows field errors for bad input', (tester) async {
      await pumpApp(tester, AppRoutes.login);

      await enterField(tester, 0, 'not-an-email');
      await tapButton(tester, 'Log in');

      expect(
        find.text('Enter a valid email, like you@example.com.'),
        findsOneWidget,
      );
      expect(find.text('Enter your password.'), findsOneWidget);
    });

    testWidgets('shows a banner for the wrong password', (tester) async {
      await pumpApp(tester, AppRoutes.login);

      await enterField(tester, 0, FakeAuthService.demoEmail);
      await enterField(tester, 1, 'wrong-password');
      await tapButton(tester, 'Log in');

      expect(find.textContaining('do not match'), findsOneWidget);
    });

    testWidgets('opens the app with the right details', (tester) async {
      await pumpApp(tester, AppRoutes.login);

      await enterField(tester, 0, FakeAuthService.demoEmail);
      await enterField(tester, 1, FakeAuthService.demoPassword);
      await tapButton(tester, 'Log in');

      expect(find.text('Discover comes next'), findsOneWidget);
    });
  });

  group('sign up', () {
    testWidgets('shows errors when the form is empty', (tester) async {
      await pumpApp(tester, AppRoutes.signUp);

      await tapButton(tester, 'Create account');

      expect(find.text('Enter your name.'), findsOneWidget);
      expect(find.text('Enter your email.'), findsOneWidget);
      expect(find.text('Enter your date of birth.'), findsOneWidget);
      expect(find.text('Use at least 8 characters.'), findsOneWidget);
      expect(find.text('Please accept the terms to continue.'), findsOneWidget);
    });

    testWidgets('blocks someone under 18', (tester) async {
      await pumpApp(tester, AppRoutes.signUp);

      final tenYearsAgo = DateTime.now().year - 10;
      await fillSignUp(tester, born: '01/01/$tenYearsAgo');
      await tapButton(tester, 'Create account');

      expect(find.text('Gatherly is for 18 and over'), findsOneWidget);
    });

    testWidgets('sends an adult to verify their email', (tester) async {
      await pumpApp(tester, AppRoutes.signUp);

      await fillSignUp(tester, born: '01/01/2000');
      await tapButton(tester, 'Create account');

      expect(find.text('Check your inbox'), findsOneWidget);
      expect(find.textContaining('new@example.com'), findsOneWidget);
    });
  });

  group('reset password', () {
    testWidgets('goes from log in to the link sent screen', (tester) async {
      await pumpApp(tester, AppRoutes.login);

      await tester.tap(find.text('Forgot password?'));
      await tester.pumpAndSettle();
      await enterField(tester, 0, 'thabo@example.com');
      await tapButton(tester, 'Send reset link');

      expect(find.text('Reset link sent'), findsOneWidget);

      await tapButton(tester, 'Back to log in');
      expect(find.text('Welcome back'), findsOneWidget);
    });

    testWidgets('new passwords have to match', (tester) async {
      await pumpApp(tester, AppRoutes.newPassword);

      await enterField(tester, 0, 'gatherly1');
      await enterField(tester, 1, 'gatherly2');
      await tapButton(tester, 'Save password');

      expect(find.text('The passwords do not match.'), findsOneWidget);
    });
  });
}
