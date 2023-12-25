import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pteye/Features/auth/data/repos/auth_repo.dart';
import 'package:pteye/Features/auth/presentation/manger/login_cubit/login_state.dart';

// Events
abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  LoginButtonPressed({required this.email, required this.password});
}



// Cubit
class LoginCubit extends Cubit<LoginState> {
  final AuthRepo _authRepo;

  LoginCubit(this._authRepo) : super(LoginInitial());

  void loginUser({required String email, required String password}) async {
    emit(LoginLoading());

    try {
      // Call the authentication method from the repository
      await _authRepo.loginUser(email, password);

      // Save user credentials to SharedPreferences after successful login
      await _authRepo.saveUserCredentials(email, password);

      // If successful, emit the success state
      emit(LoginSuccess());
    } catch (e) {
      // If an error occurs, emit the failure state with the error message
      if (e is String) {
        emit(LoginFailure(error: e));
      } else {
        emit(LoginFailure(error: 'حدث خطأ غير متوقع'));
        // Log additional details for debugging if needed
        if (kDebugMode) {
          print('Unexpected Error during login: $e');
        }
      }
    }
  }
}
