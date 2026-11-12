import 'package:flutter/material.dart';

import '../routes.dart';
import '../theme/app_theme.dart';
import '../widgets/app_button.dart';

// temporary, until Discover is built
class HomePlaceholderScreen extends StatelessWidget {
  const HomePlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Discover comes next', style: AppTextStyles.title),
              const SizedBox(height: 6),
              const Text(
                'The home feed is not built yet.',
                style: AppTextStyles.body,
              ),
              const SizedBox(height: 24),
              AppButton(
                label: 'Back to welcome',
                kind: AppButtonKind.secondary,
                onPressed: () => Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.welcome,
                  (route) => false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
