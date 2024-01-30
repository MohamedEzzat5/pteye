import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pteye/Features/auth/data/repos/auth_repo.dart';
import 'package:pteye/core/errors/failures.dart';


class AuthRepoImplementation implements AuthRepo {
  @override
  Future<Either<String, Unit>> loginUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return left('بريد الكتروني غير صحيح!');
      } else if (e.code == 'wrong-password') {
        return left('كلمة مرور غير صحيحة!');
      } else if (e.code == 'invalid-email') {
        return left('بريد إلكتروني غير صالح!');
      } else {
        return left('ادخل بيانات صحيحة!');
      }
    } catch (e) {
      return left('حدث خطأ غير متوقع');
    }
  }


  @override
  Future<Either<String, Unit>> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

      if (googleSignInAccount == null) {
        return left('تم الغاء تسجيل الدخول بواسطه جوجل');
      }

      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      return right(unit);
    } on FirebaseAuthException catch (e) {
      return left(FirebaseAuthExceptionHandler.handleException(e));
    } catch (e) {
      return left('Google login failed: $e');
    }
  }
  @override
  Future<Either<String, Unit>> registerUser(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return left('البريد الإلكتروني مستخدم بالفعل!');
      } else if (e.code == 'invalid-email') {
        return left('بريد إلكتروني غير صالح!');
      } else if (e.code == 'weak-password') {
        return left('كلمة المرور ضعيفة جداً!');
      } else {
        return left('خطأ: فشل التسجيل');
      }
    } catch (e) {
      return left('حدث خطأ غير متوقع أثناء التسجيل');
    }
  }


}
