import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pteye/Features/auth/data/repos/auth_repo.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());
final AuthRepo authRepo;


  Future<void> loginUser(String email, String password) async {
    try {
      emit(LoginLoading());

      // Call the AuthRepo to log in the user
      await authRepo.loginUser(email, password);

      // If the login is successful, emit the LoginSuccess state
      emit(LoginSuccess());
    } catch (error) {
      // If there's an error during login, emit the LoginError state
      emit(LoginFailure(error.toString()));
    }
  }

}
