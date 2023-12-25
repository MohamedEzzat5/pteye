import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pteye/Features/auth/data/repos/auth_repo.dart';
import 'package:pteye/Features/auth/presentation/manger/register_cubit/register_state.dart';

// Events
abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String email;
  final String password;

  RegisterButtonPressed({required this.email, required this.password});
}



// Cubit
class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo _authRepo;

  RegisterCubit(this._authRepo) : super(RegisterInitial());

  void registerUser({required String email, required String password}) async {
    emit(RegisterLoading());

    try {
      // Call the registration method from the repository
      await _authRepo.registerUser(email, password);
      // If successful, emit the success state
      emit(RegisterSuccess());
    } catch (e) {
      // If an error occurs, emit the failure state with the error message
      if (e is String) {
        emit(RegisterFailure(error: e));
      } else {
        emit(RegisterFailure(error: 'حدث خطأ غير متوقع'));
        // Log additional details for debugging if needed
        print('Unexpected Error during registration: $e');
      }
    }
  }
}
