import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepo {
  Future<Either<String, Unit>> loginUser(String email, String password);
  Future<Either<String, UserCredential?>> signUpWithGoogle();
  Future<Either<String, Unit>> registerUser(String email, String password , String userName,String phoneNumber);
}
