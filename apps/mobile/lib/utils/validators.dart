// each returns an error message, or null if the value is ok

final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
final _datePattern = RegExp(r'^(\d{1,2})/(\d{1,2})/(\d{4})$');

String? validateName(String? value) {
  if (value == null || value.trim().isEmpty) return 'Enter your name.';
  return null;
}

String? validateEmail(String? value) {
  final email = value?.trim() ?? '';
  if (email.isEmpty) return 'Enter your email.';
  if (!_emailPattern.hasMatch(email)) {
    return 'Enter a valid email, like you@example.com.';
  }
  return null;
}

String? validateNewPassword(String? value) {
  final password = value ?? '';
  if (password.length < 8) return 'Use at least 8 characters.';
  if (!password.contains(RegExp(r'\d'))) return 'Add at least one number.';
  return null;
}

String? validateDateOfBirth(String? value) {
  if (value == null || value.trim().isEmpty) return 'Enter your date of birth.';
  if (parseDate(value) == null) return 'Use the format DD / MM / YYYY.';
  return null;
}

// expects DD/MM/YYYY
DateTime? parseDate(String input) {
  final match = _datePattern.firstMatch(input.replaceAll(' ', ''));
  if (match == null) return null;

  final day = int.parse(match.group(1)!);
  final month = int.parse(match.group(2)!);
  final year = int.parse(match.group(3)!);
  final date = DateTime(year, month, day);

  // DateTime turns 31/02 into 3 March, so make sure it didn't change
  if (date.day != day || date.month != month) return null;
  if (year < 1900 || date.isAfter(DateTime.now())) return null;
  return date;
}

bool isAdult(DateTime dateOfBirth, {DateTime? today}) {
  final now = today ?? DateTime.now();
  final eighteenthBirthday = DateTime(
    dateOfBirth.year + 18,
    dateOfBirth.month,
    dateOfBirth.day,
  );
  return !eighteenthBirthday.isAfter(now);
}
