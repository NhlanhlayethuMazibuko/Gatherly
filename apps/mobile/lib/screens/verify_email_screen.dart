import 'package:flutter/material.dart';

import '../routes.dart';
import '../services/auth_service.dart';
import '../widgets/app_button.dart';
import '../widgets/auth_widgets.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({
    super.key,
    required this.authService,
    required this.email,
  });

  final AuthService authService;
  final String email;

  Future<void> _resendLink(BuildContext context) async {
    // get this before the await
    final messenger = ScaffoldMessenger.of(context);
    await authService.resendVerificationEmail(email);
    messenger.showSnackBar(
      const SnackBar(content: Text('We sent the link again.')),
    );
  }

  void _openEmailApp(BuildContext context) {
    // TODO: open the mail app (needs url_launcher)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Open your email app to find the link.')),
    );
  }

  void _skip(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.home,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MessageBlock(
                icon: Icons.mail_outline,
                title: 'Check your inbox',
                message:
                    'We sent a link to $email. Tap it to verify your email. '
                    'You need this before hosting a gathering or submitting '
                    'an event.',
              ),
              const SizedBox(height: 16),
              AppButton(
                label: 'Open email app',
                onPressed: () => _openEmailApp(context),
              ),
              const SizedBox(height: 16),
              AppButton(
                label: 'Resend link',
                kind: AppButtonKind.secondary,
                onPressed: () => _resendLink(context),
              ),
              const SizedBox(height: 16),
              AppButton(
                label: 'Skip for now',
                kind: AppButtonKind.text,
                onPressed: () => _skip(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
