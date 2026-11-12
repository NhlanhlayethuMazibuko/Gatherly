import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

enum AppButtonKind { primary, secondary, text }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.kind = AppButtonKind.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonKind kind;

  @override
  Widget build(BuildContext context) {
    final isPrimary = kind == AppButtonKind.primary;
    final isSecondary = kind == AppButtonKind.secondary;

    Color? background;
    if (isPrimary) background = AppColors.accent;
    if (isSecondary) background = AppColors.surface;

    return SizedBox(
      width: double.infinity,
      height: 48,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: background,
          disabledBackgroundColor: isPrimary ? AppColors.disabled : background,
          foregroundColor: AppColors.text,
          disabledForegroundColor: AppColors.textMuted,
          textStyle: AppTextStyles.button,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isSecondary
                ? const BorderSide(color: AppColors.border)
                : BorderSide.none,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}
