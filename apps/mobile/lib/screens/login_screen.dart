import 'package:flutter/material.dart';

import '../routes.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../utils/validators.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/auth_widgets.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.authService});

  final AuthService authService;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _logIn() async {
    if (!_formKey.currentState!.validate()) return;

    await _run(
      () => widget.authService.signIn(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  Future<void> _logInWithGoogle() => _run(widget.authService.signInWithGoogle);

  Future<void> _run(Future<void> Function() request) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await request();
      if (!mounted) return;
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
    } on AuthException catch (error) {
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorMessage = error.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // fills the screen so the sign-up link sits at the bottom
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const GatherlyLogo(),
                      const SizedBox(height: 24),
                      const ScreenHeading(
                        title: 'Welcome back',
                        subtitle: 'Log in to see what is happening this week.',
                      ),
                      const SizedBox(height: 16),
                      if (_errorMessage != null) ...[
                        ErrorBanner(message: _errorMessage!),
                        const SizedBox(height: 16),
                      ],
                      AppTextField(
                        label: 'Email',
                        hint: 'you@example.com',
                        icon: Icons.mail_outline,
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: validateEmail,
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        label: 'Password',
                        hint: 'Your password',
                        icon: Icons.lock_outline,
                        controller: _passwordController,
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onSubmitted: _logIn,
                        validator: (value) => (value ?? '').isEmpty
                            ? 'Enter your password.'
                            : null,
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () => Navigator.pushNamed(
                            context,
                            AppRoutes.resetPassword,
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              'Forgot password?',
                              style: AppTextStyles.label,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      AppButton(
                        label: _isLoading ? 'Logging in…' : 'Log in',
                        onPressed: _isLoading ? null : _logIn,
                      ),
                      const SizedBox(height: 16),
                      const OrDivider(),
                      const SizedBox(height: 16),
                      AppButton(
                        label: 'Continue with Google',
                        kind: AppButtonKind.secondary,
                        onPressed: _isLoading ? null : _logInWithGoogle,
                      ),
                      const Spacer(),
                      LinkLine(
                        question: "Don't have an account?",
                        linkText: 'Sign up',
                        onTap: () => Navigator.pushReplacementNamed(
                          context,
                          AppRoutes.signUp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
