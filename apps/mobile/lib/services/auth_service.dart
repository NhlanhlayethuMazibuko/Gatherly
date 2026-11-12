// screens only talk to this, so the fake can be swapped for Supabase
abstract class AuthService {
  Future<void> signIn({required String email, required String password});

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required DateTime dateOfBirth,
  });

  Future<void> signInWithGoogle();

  Future<void> resendVerificationEmail(String email);

  Future<void> sendPasswordResetEmail(String email);

  Future<void> updatePassword(String newPassword);
}

// message is shown to the user
class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => 'AuthException: $message';
}
