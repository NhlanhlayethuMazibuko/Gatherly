import 'package:flutter/material.dart';

import '../routes.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../utils/validators.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/auth_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key, required this.authService});

  final AuthService authService;

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dateOfBirthController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _acceptedTerms = false;
  bool _showTermsError = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _dateOfBirthController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _createAccount() async {
    final fieldsAreValid = _formKey.currentState!.validate();
    setState(() => _showTermsError = !_acceptedTerms);
    if (!fieldsAreValid || !_acceptedTerms) return;

    // check age before calling the service so nothing is saved for under-18s
    final dateOfBirth = parseDate(_dateOfBirthController.text)!;
    if (!isAdult(dateOfBirth)) {
      Navigator.pushReplacementNamed(context, AppRoutes.under18);
      return;
    }

    final email = _emailController.text.trim();
    await _run(
      () => widget.authService.signUp(
        name: _nameController.text.trim(),
        email: email,
        password: _passwordController.text,
        dateOfBirth: dateOfBirth,
      ),
      onSuccess: () => Navigator.pushReplacementNamed(
        context,
        AppRoutes.verifyEmail,
        arguments: email,
      ),
    );
  }

  Future<void> _continueWithGoogle() {
    return _run(
      widget.authService.signInWithGoogle,
      onSuccess: () => Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      ),
    );
  }

  Future<void> _run(
    Future<void> Function() request, {
    required VoidCallback onSuccess,
  }) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await request();
      if (!mounted) return;
      onSuccess();
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const GatherlyLogo(),
                const SizedBox(height: 24),
                const ScreenHeading(
                  title: 'Create your account',
                  subtitle: 'Gatherly is for people aged 18 and over.',
                ),
                const SizedBox(height: 16),
                if (_errorMessage != null) ...[
                  ErrorBanner(message: _errorMessage!),
                  const SizedBox(height: 16),
                ],
                AppTextField(
                  label: 'Full name',
                  hint: 'Your name',
                  icon: Icons.person_outline,
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  validator: validateName,
                ),
                const SizedBox(height: 16),
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
                  label: 'Date of birth',
                  hint: 'DD / MM / YYYY',
                  icon: Icons.calendar_today_outlined,
                  controller: _dateOfBirthController,
                  keyboardType: TextInputType.datetime,
                  validator: validateDateOfBirth,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Password',
                  hint: 'At least 8 characters',
                  icon: Icons.lock_outline,
                  controller: _passwordController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: _createAccount,
                  validator: validateNewPassword,
                ),
                const SizedBox(height: 16),
                _buildTermsRow(),
                const SizedBox(height: 16),
                AppButton(
                  label: _isLoading ? 'Creating account…' : 'Create account',
                  onPressed: _isLoading ? null : _createAccount,
                ),
                const SizedBox(height: 16),
                const OrDivider(),
                const SizedBox(height: 16),
                AppButton(
                  label: 'Continue with Google',
                  kind: AppButtonKind.secondary,
                  onPressed: _isLoading ? null : _continueWithGoogle,
                ),
                const SizedBox(height: 8),
                LinkLine(
                  question: 'Already have an account?',
                  linkText: 'Log in',
                  onTap: () =>
                      Navigator.pushReplacementNamed(context, AppRoutes.login),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTermsRow() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 22,
              height: 22,
              child: Checkbox(
                value: _acceptedTerms,
                onChanged: (value) => setState(() {
                  _acceptedTerms = value ?? false;
                  _showTermsError = false;
                }),
              ),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'I agree to the Terms, Privacy Policy and Community Guidelines.',
                style: AppTextStyles.small,
              ),
            ),
          ],
        ),
        if (_showTermsError) ...[
          const SizedBox(height: 6),
          Text(
            'Please accept the terms to continue.',
            style: AppTextStyles.small.copyWith(color: AppColors.error),
          ),
        ],
      ],
    );
  }
}
