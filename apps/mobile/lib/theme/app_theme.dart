import 'package:flutter/material.dart';

// colours and text styles from the Figma file

class AppColors {
  static const background = Color(0xFFFEF7E8);
  static const surface = Color(0xFFFFFFFF);
  static const accent = Color(0xFFFA8C63);
  static const accentSoft = Color(0xFFFDE4D8);
  static const text = Color(0xFF222222);
  static const textMuted = Color(0xFF5F5A52);
  static const border = Color(0xFFE8DFCB);
  static const disabled = Color(0xFFEFE6D2);
  static const error = Color(0xFFC23B2E);
  static const errorSoft = Color(0xFFF8DEDA);
}

class AppTextStyles {
  static const heading = TextStyle(
    fontSize: 28,
    height: 34 / 28,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  static const title = TextStyle(
    fontSize: 22,
    height: 28 / 22,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  static const subtitle = TextStyle(
    fontSize: 18,
    height: 24 / 18,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );
  static const body = TextStyle(
    fontSize: 15,
    height: 22 / 15,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );
  static const button = TextStyle(
    fontFamily: 'Poppins',
    fontSize: 15,
    height: 22 / 15,
    fontWeight: FontWeight.w500,
  );
  static const label = TextStyle(
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.w500,
    color: AppColors.text,
  );
  static const small = TextStyle(
    fontSize: 13,
    height: 18 / 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );
}

OutlineInputBorder _fieldBorder(Color color, [double width = 1]) {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(12),
    borderSide: BorderSide(color: color, width: width),
  );
}

ThemeData buildAppTheme() {
  return ThemeData(
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.accent,
      primary: AppColors.accent,
      surface: AppColors.background,
      error: AppColors.error,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.text,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.text,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,
      hoverColor: Colors.transparent,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      hintStyle: AppTextStyles.body,
      errorStyle: AppTextStyles.small.copyWith(color: AppColors.error),
      errorMaxLines: 2,
      prefixIconColor: AppColors.textMuted,
      border: _fieldBorder(AppColors.border),
      enabledBorder: _fieldBorder(AppColors.border),
      focusedBorder: _fieldBorder(AppColors.accent, 1.5),
      errorBorder: _fieldBorder(AppColors.error),
      focusedErrorBorder: _fieldBorder(AppColors.error, 1.5),
    ),
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      side: const BorderSide(color: AppColors.border, width: 1.5),
      checkColor: WidgetStateProperty.all(AppColors.text),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: AppColors.text,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
