import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pteye/Features/auth/data/repos/auth_repo.dart';
import 'package:pteye/Features/auth/presentation/manger/login_cubit/login_state.dart';
import 'package:pteye/core/errors/failures.dart';

// Events
abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password});
}



// Cubit
class LoginCubit extends Cubit<LoginState> {
  final AuthRepo authRepo;

  LoginCubit({required this.authRepo}) : super(LoginInitial());

  void loginUser({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      // Call the authentication method from the repository
      await authRepo.loginUser(email, password);

      // Save user credentials to SharedPreferences after successful login
      await authRepo.saveUserCredentials(email, password);

      // If successful, emit the success state
      emit(LoginSuccess());
    }on FirebaseAuthException catch (e){
      final errorMessage =FirebaseAuthExceptionHandler.handleException(e);
      emit(LoginFailure(error: errorMessage));
    }
    catch (e) {
      emit(LoginFailure(error: 'من فضلك ادخل بيانات صحيحة'));
    }
  }
}
