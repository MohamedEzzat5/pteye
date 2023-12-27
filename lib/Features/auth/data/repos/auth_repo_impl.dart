import 'package:firebase_auth/firebase_auth.dart';
import 'package:pteye/Features/auth/data/repos/auth_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepoImplementation implements AuthRepo {
  @override
  Future<void> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save user credentials to SharedPreferences after successful login
      await saveUserCredentials(email, password);
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication exceptions
      if (e.code == 'user-not-found') {
        throw 'بريد الكتروني غير صحيح!';
      } else if (e.code == 'wrong-password') {
        throw 'كلمة مرور غير صحيحة!';
      } else if (e.code == 'invalid-email') {
        throw 'بريد إلكتروني غير صالح!';
      } else {
        throw 'خطأ: ادخل بيانات صحيحة';
      }
    } catch (e) {
      // Handle other unexpected errors
      throw 'حدث خطأ غير متوقع';
    }
  }


  @override
  Future<void> registerUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase authentication exceptions for registration
      if (e.code == 'email-already-in-use') {
        throw 'this email is already exist';
      } else if (e.code == 'weak-password') {
        throw 'weak password';
      } else {
        throw 'حدث خطأ غير متوقع';
      }
    } catch (e) {
      // Handle other unexpected errors
      throw 'حدث خطأ غير متوقع';
    }
  }

  // Save user credentials to SharedPreferences
  @override
  Future<void> saveUserCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_email', email);
    await prefs.setString('user_password', password);
  }

  // Retrieve user credentials from SharedPreferences
  @override
  Future<Map<String, String>> getUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? email = prefs.getString('user_email');
    String? password = prefs.getString('user_password');

    return {'email': email ?? '', 'password': password ?? ''};
  }
}
