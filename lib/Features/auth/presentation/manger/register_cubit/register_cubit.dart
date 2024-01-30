import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pteye/Features/auth/data/repos/auth_repo.dart';
import 'package:pteye/Features/auth/presentation/manger/register_cubit/register_state.dart';

abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String email;
  final String password;

  RegisterButtonPressed({required this.email, required this.password});
}

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;

  RegisterCubit({required this.authRepo}) : super(RegisterInitial());

  void registerUser({required String email, required String password}) async {
    emit(RegisterLoading());

    final result = await authRepo.registerUser(email, password);

    result.fold(
      (error) => emit(RegisterFailure(error: error)),
      (success) => emit(RegisterSuccess()),
    );
  }
}
