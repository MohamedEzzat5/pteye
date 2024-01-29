import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pteye/Features/auth/data/repos/auth_repo.dart';
import 'package:pteye/Features/auth/presentation/manger/register_cubit/register_state.dart';
import 'package:pteye/core/errors/failures.dart';

// Events
abstract class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String email;
  final String password;
  final String name;

  RegisterButtonPressed({required this.email, required this.password,required this.name});
}



// Cubit
class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepo authRepo;

  RegisterCubit({required this.authRepo}) : super(RegisterInitial());

  void registerUser({required String email, required String password}) async {
    emit(RegisterLoading());

    try {
      await authRepo.registerUser(email, password);
      emit(RegisterSuccess());
    }on FirebaseAuthException catch (e){
      final errorMessage =FirebaseAuthExceptionHandler.handleException(e);
      emit(RegisterFailure(error: errorMessage));
    }
    catch (e) {
      emit(RegisterFailure(error: 'من فضلك اعد المحاولة مع مراعاة ادخال بيانات صحيحة'));
    }
    }
  }

