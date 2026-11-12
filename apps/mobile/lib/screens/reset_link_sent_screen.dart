import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../routes.dart';
import '../widgets/app_button.dart';
import '../widgets/auth_widgets.dart';

class ResetLinkSentScreen extends StatelessWidget {
  const ResetLinkSentScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reset password')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MessageBlock(
                icon: Icons.mail_outline,
                title: 'Reset link sent',
                message:
                    'If $email has an account, a reset link is on its way. '
                    'It expires in 30 minutes.',
              ),
              const SizedBox(height: 16),
              AppButton(
                label: 'Back to log in',
                kind: AppButtonKind.secondary,
                onPressed: () => goToLogin(context),
              ),
              // debug only: stands in for the link in the email
              if (kDebugMode) ...[
                const SizedBox(height: 16),
                AppButton(
                  label: 'Open the reset link (debug)',
                  kind: AppButtonKind.text,
                  onPressed: () => Navigator.pushReplacementNamed(
                    context,
                    AppRoutes.newPassword,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
