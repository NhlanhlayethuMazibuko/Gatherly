import 'package:flutter/material.dart';

import '../routes.dart';
import '../services/auth_service.dart';
import '../theme/app_theme.dart';
import '../utils/validators.dart';
import '../widgets/app_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/auth_widgets.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key, required this.authService});

  final AuthService authService;

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _savePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await widget.authService.updatePassword(_passwordController.text);
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Password saved. Log in with it now.')),
    );
    goToLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('New password')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ScreenHeading(
                  title: 'Set a new password',
                  titleStyle: AppTextStyles.title,
                  subtitle: 'Use at least 8 characters, with a number.',
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'New password',
                  hint: 'At least 8 characters',
                  icon: Icons.lock_outline,
                  controller: _passwordController,
                  obscureText: true,
                  validator: validateNewPassword,
                ),
                const SizedBox(height: 16),
                AppTextField(
                  label: 'Confirm new password',
                  hint: 'Type it again',
                  icon: Icons.lock_outline,
                  controller: _confirmController,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onSubmitted: _savePassword,
                  validator: (value) => value == _passwordController.text
                      ? null
                      : 'The passwords do not match.',
                ),
                const SizedBox(height: 16),
                AppButton(
                  label: _isLoading ? 'Saving…' : 'Save password',
                  onPressed: _isLoading ? null : _savePassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
