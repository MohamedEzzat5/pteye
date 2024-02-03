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
  final AuthRepo authRepo;

  LoginCubit({required this.authRepo}) : super(LoginInitial());

  void loginUser({required String email, required String password}) async {
    emit(LoginLoading());

    final result = await authRepo.loginUser(email, password);

    result.fold(
          (error) => emit(LoginFailure(error: error)),
          (success) => emit(LoginSuccess()),
    );
  }

  void loginWithGoogle() async {
    emit(LoginLoading());
    final result = await authRepo.signUpWithGoogle();

    result.fold(
          (error) => emit(LoginFailure(error: error)),
          (success) => emit(LoginSuccess()),
    );
  }
}
