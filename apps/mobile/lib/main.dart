import 'package:flutter/material.dart';

import 'routes.dart';
import 'services/auth_service.dart';
import 'services/fake_auth_service.dart';
import 'theme/app_theme.dart';

void main() {
  // fake for now, swap for Supabase later
  runApp(GatherlyApp(authService: FakeAuthService()));
}

class GatherlyApp extends StatelessWidget {
  const GatherlyApp({
    super.key,
    required this.authService,
    this.initialRoute = AppRoutes.splash,
  });

  final AuthService authService;

  // lets tests skip the splash
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gatherly',
      debugShowCheckedModeBanner: false,
      theme: buildAppTheme(),
      // keeps the app phone-width in a wide browser window
      builder: (context, child) => ColoredBox(
        color: AppColors.background,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: child,
          ),
        ),
      ),
      initialRoute: initialRoute,
      // otherwise Flutter also loads the splash under the first screen
      onGenerateInitialRoutes: (name) => [
        generateRoute(RouteSettings(name: name), authService),
      ],
      onGenerateRoute: (settings) => generateRoute(settings, authService),
    );
  }
}
