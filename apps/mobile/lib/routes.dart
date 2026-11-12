import 'package:flutter/material.dart';

import 'screens/home_placeholder_screen.dart';
import 'screens/login_screen.dart';
import 'screens/new_password_screen.dart';
import 'screens/reset_link_sent_screen.dart';
import 'screens/reset_password_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/under_18_screen.dart';
import 'screens/verify_email_screen.dart';
import 'screens/welcome_screen.dart';
import 'services/auth_service.dart';

class AppRoutes {
  static const splash = '/';
  static const welcome = '/welcome';
  static const login = '/login';
  static const signUp = '/sign-up';
  static const under18 = '/under-18';
  static const verifyEmail = '/verify-email';
  static const resetPassword = '/reset-password';
  static const resetLinkSent = '/reset-password/sent';
  static const newPassword = '/reset-password/new';
  static const home = '/home';
}

Route<dynamic> generateRoute(RouteSettings settings, AuthService authService) {
  Widget screen;
  // null if the page was opened directly, e.g. a browser refresh
  final email = settings.arguments as String?;

  switch (settings.name) {
    case AppRoutes.welcome:
      screen = const WelcomeScreen();
    case AppRoutes.login:
      screen = LoginScreen(authService: authService);
    case AppRoutes.signUp:
      screen = SignUpScreen(authService: authService);
    case AppRoutes.under18:
      screen = const Under18Screen();
    case AppRoutes.verifyEmail:
      screen = email == null
          ? const WelcomeScreen()
          : VerifyEmailScreen(authService: authService, email: email);
    case AppRoutes.resetPassword:
      screen = ResetPasswordScreen(authService: authService);
    case AppRoutes.resetLinkSent:
      screen = email == null
          ? const WelcomeScreen()
          : ResetLinkSentScreen(email: email);
    case AppRoutes.newPassword:
      screen = NewPasswordScreen(authService: authService);
    case AppRoutes.home:
      screen = const HomePlaceholderScreen();
    default:
      screen = const SplashScreen();
  }

  return MaterialPageRoute(builder: (_) => screen, settings: settings);
}

void goToLogin(BuildContext context) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    AppRoutes.login,
    (route) => route.settings.name == AppRoutes.welcome,
  );
}
