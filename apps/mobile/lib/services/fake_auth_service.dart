import 'auth_service.dart';

// in-memory accounts until the backend exists
class FakeAuthService implements AuthService {
  FakeAuthService({this.delay = const Duration(milliseconds: 800)});

  // fake network delay
  final Duration delay;

  static const demoEmail = 'thabo@example.com';
  static const demoPassword = 'gatherly1';

  final Map<String, String> _passwords = {demoEmail: demoPassword};

  @override
  Future<void> signIn({required String email, required String password}) async {
    await Future.delayed(delay);
    if (_passwords[email.toLowerCase()] != password) {
      throw const AuthException(
        'That email and password do not match. Check them and try again.',
      );
    }
  }

  @override
  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required DateTime dateOfBirth,
  }) async {
    await Future.delayed(delay);
    final key = email.toLowerCase();
    if (_passwords.containsKey(key)) {
      throw const AuthException(
        'There is already an account with that email. Try logging in.',
      );
    }
    _passwords[key] = password;
  }

  @override
  Future<void> signInWithGoogle() async {
    await Future.delayed(delay);
    throw const AuthException('Google sign-in is not set up yet.');
  }

  @override
  Future<void> resendVerificationEmail(String email) => Future.delayed(delay);

  // always succeeds so we don't leak which emails have accounts
  @override
  Future<void> sendPasswordResetEmail(String email) => Future.delayed(delay);

  @override
  Future<void> updatePassword(String newPassword) => Future.delayed(delay);
}
