// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:pteye/Features/auth/data/repos/auth_repo.dart';
//
// part 'register_state.dart';
//
// class RegisterCubit extends Cubit<RegisterState> {
//   RegisterCubit(this.authRepo) : super(RegisterInitial());
//   final AuthRepo authRepo;
//
//   Future<void> registerUser(email ,password) async{
//     emit(RegisterLoading());
//     try {
//       authRepo.registerUser(email, password);
//       emit(RegisterSuccess());
//     } catch (e) {
//       emit(RegisterFailure(e.toString()));
//     }
//
//
//   }
// }
