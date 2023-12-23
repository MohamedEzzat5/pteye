import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(LoginSuccess());
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginFailure(errMessage: 'بريد الكتروني غير صحيح!'));
      } else if (e.code == 'wrong-password') {
        emit(LoginFailure(errMessage: 'كلمة مرور غير صحيحة!'));
      } else if (e.code == 'invalid-email') {
        emit(LoginFailure(errMessage: 'بريد إلكتروني غير صالح!'));
      } else {
        emit(LoginFailure(errMessage: 'خطأ: ادخل بيانات صحيحة'));
        // Log additional details for debugging if needed
        print('Firebase Authentication Error: ${e.code}, ${e.message}');
      }
    } catch (e) {
      emit(LoginFailure(errMessage: 'حدث خطأ غير متوقع'));
      // Log additional details for debugging if needed
      print('Unexpected Error during login: $e');
    }
  }
}
