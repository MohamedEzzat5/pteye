// import 'dart:js';
//
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:pteye/Features/auth/data/repos/auth_repo.dart';
// import 'package:pteye/core/utils/widgets/show_snackbar.dart';
//
// class AuthRepoImpl implements AuthRepo
// {
//   @override
//   Future<void> loginUser(email,password) async {
//     try {
//       UserCredential user = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);
//       // Handle successful login here
//     } on FirebaseAuthException catch (e) {
//       String errorMessage = 'please enter correct email and password!';
//
//       if (e.code == 'user-not-found') {
//         errorMessage = 'User not found';
//          return showSnackBar(context , message: 'user not found') ;
//       } else if (e.code == 'wrong-password') {
//         errorMessage = 'Wrong password';
//       }
//       return showSnackBar(context , message: 'wrong password') ;
//     } catch (e) {
//       return showSnackBar(context , message: 'please enter correct email and password!') ;
//     }
//   }
//
//   @override
//   Future<void> registerUser(email , password) async{
//     try {
//       UserCredential user = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//       // Handle successful login here
//     } on FirebaseAuthException catch (e) {
//       String errorMessage = 'email in use, try again';
//
//       if (e.code == 'email-already-in-use') {
//         errorMessage = 'User not found';
//         return showSnackBar(context , message: errorMessage) ;
//       } else if (e.code == 'weak-password') {
//         errorMessage = 'Weak password';
//       }
//       return showSnackBar(context , message: 'weak password') ;
//     } catch (e) {
//       return showSnackBar(context , message: 'email in use, try again') ;
//     }
//   }
//
// }