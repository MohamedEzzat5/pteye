import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pteye/Features/auth/data/repos/auth_repo.dart';


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
  // Future<Either<String, Unit>> loginWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
  //
  //     if (googleSignInAccount == null) {
  //       return left('تم الغاء تسجيل الدخول بواسطه جوجل');
  //     }
  //
  //     final GoogleSignInAuthentication googleSignInAuthentication =
  //     await googleSignInAccount.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleSignInAuthentication.accessToken,
  //       idToken: googleSignInAuthentication.idToken,
  //     );
  //
  //     await FirebaseAuth.instance.signInWithCredential(credential);
  //
  //     return right(unit);
  //   } on FirebaseAuthException catch (e) {
  //     return left(FirebaseAuthExceptionHandler.handleException(e));
  //   } catch (e) {
  //     return left('Google login failed: $e');
  //   }
  // }
  @override
  Future<Either<String, UserCredential?>> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();

      if (googleSignInAccount == null) {
        // User canceled Google Sign In
        return left("User canceled Google Sign In");
      }

      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      // Store user details in Firestore
      final eitherResult = await storeUserDetailsInFirestore(userCredential.user!);

      return eitherResult.fold(
            (error) => left(error),
            (_) => right(userCredential),
      );
    } catch (e) {
      // Handle exceptions
      if (kDebugMode) {
        print("Error signing up with Google: $e");
      }
      return left("Error signing up with Google");
    }
  }

  Future<Either<String, Unit>> storeUserDetailsInFirestore(User user) async {
    try {
      final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

      // Check if the user already exists in Firestore
      final DocumentSnapshot userSnapshot = await usersCollection.doc(user.uid).get();
      if (!userSnapshot.exists) {
        // If the user doesn't exist, add their details to Firestore
        await usersCollection.doc(user.uid).set({
          'email': user.email,
          'username': user.displayName ?? 'User', // You may need to adjust this based on your user data
          'phoneNumber': user.phoneNumber ?? '', // You may need to adjust this based on your user data
        });
      }

      return right(unit);
    } catch (e) {
      if (kDebugMode) {
        print("Error storing user details in Firestore: $e");
      }
      return left("Error storing user details in Firestore");
    }
  }
  @override
  Future<Either<String, Unit>> registerUser(String email, String password ,String userName,String phoneNumber) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'email': email,
        'username': userName,
        'phoneNumber': phoneNumber,
      });

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
