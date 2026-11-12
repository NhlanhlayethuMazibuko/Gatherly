import 'package:flutter/material.dart';

import '../routes.dart';
import '../widgets/app_button.dart';
import '../widgets/auth_widgets.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // photo shrinks on short phones
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'assets/images/welcome.jpg',
                    width: double.infinity,
                    height: 380,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              const GatherlyLogo(),
              const SizedBox(height: 12),
              const ScreenHeading(
                title: 'Find your people. Find your plans.',
                subtitle:
                    'Events, gatherings and things to do near you, all in one place.',
              ),
              const SizedBox(height: 32),
              AppButton(
                label: 'Create an account',
                onPressed: () => Navigator.pushNamed(context, AppRoutes.signUp),
              ),
              const SizedBox(height: 12),
              AppButton(
                label: 'Log in',
                kind: AppButtonKind.secondary,
                onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
              ),
              const SizedBox(height: 12),
              AppButton(
                label: 'Browse first',
                kind: AppButtonKind.text,
                onPressed: () => Navigator.pushNamed(context, AppRoutes.home),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
