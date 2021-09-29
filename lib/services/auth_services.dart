part of 'services.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<SignInSignUpResult> signUp(
      String email,
      String password,
      String name,
      List<String> selectedGenres,
      String selectedLanguange) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      UserReal userReal = result.user.convertToUser(
          name: name,
          selectedGenres: selectedGenres,
          selectedLanguange: selectedLanguange);

      await UserServices.updateUser(userReal);

      return SignInSignUpResult(userReal: userReal);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split('] ')[1].trim());
    }
  }

  static Future<SignInSignUpResult> signIn(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      UserReal userReal = await result.user.fromFirestore();
      return SignInSignUpResult(userReal: userReal);
    } catch (e) {
      return SignInSignUpResult(message: e.toString().split('] ')[1].trim());
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Stream<User> get userStream => _auth.authStateChanges();
}

class SignInSignUpResult {
  final UserReal userReal;
  final String message;

  SignInSignUpResult({this.userReal, this.message});
}
