import 'package:flutter/material.dart';

import '../routes.dart';
import '../widgets/app_button.dart';
import '../widgets/auth_widgets.dart';

class Under18Screen extends StatelessWidget {
  const Under18Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MessageBlock(
                icon: Icons.shield_outlined,
                title: 'Gatherly is for 18 and over',
                message:
                    'Thanks for your interest. You need to be 18 or older to '
                    'use Gatherly, so we could not create an account. We have '
                    'not kept your details.',
              ),
              const SizedBox(height: 16),
              AppButton(
                label: 'Close',
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
