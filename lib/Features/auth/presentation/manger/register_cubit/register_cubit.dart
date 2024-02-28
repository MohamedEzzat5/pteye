import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pteye/Features/auth/data/repos/auth_repo.dart';
import 'package:pteye/Features/auth/presentation/manger/register_cubit/register_state.dart';
import 'package:pteye/core/network/network_info.dart';

abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String email;
  final String password;
  final String userName;
  final String phoneNumber;

  RegisterButtonPressed({required this.userName, required this.phoneNumber, required this.email, required this.password});
}

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;
  final NetworkInfo networkInfo;

  RegisterCubit({required this.authRepo, required this.networkInfo}) : super(RegisterInitial());

  void registerUser({required String email, required String password, required String userName, required String phoneNumber}) async {
    emit(RegisterLoading());

    // Check for internet connection
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      emit(RegisterFailure(error: "تأكد من الاتصال بالإنترنت"));
      return;
    }

    final result = await authRepo.registerUser(email, password, userName, phoneNumber);

    result.fold(
          (error) => emit(RegisterFailure(error: error)),
          (success) => emit(RegisterSuccess()),
    );
  }
}
