import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pteye/Features/auth/presentation/manger/login_cubit/login_cubit.dart';
import 'package:pteye/Features/auth/presentation/manger/login_cubit/login_state.dart';
import 'package:pteye/core/utils/app_router.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/utils/style.dart';
import 'package:pteye/core/utils/widgets/show_snackbar.dart';
import 'package:pteye/core/widgets/default_button.dart';
import 'package:pteye/core/widgets/default_form_field.dart';
import 'package:pteye/core/widgets/default_text.dart';
import 'package:pteye/generated/assets.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    //var width = MediaQuery.of(context).size.width;
    return BlocConsumer<LoginCubit, LoginState>(
  listener: (context, state) {
    if (state is LoginLoading) {
      isLoaded = true;
    } else if (state is LoginSuccess) {
      GoRouter.of(context).push(AppRouter.kHomeView);
      isLoaded =false;
      return showSnackBar(
        (context),
        message: 'تم تسجيل الدخول بنجاح',
      );
    } else if (state is LoginFailure) {
      return showSnackBar(context, message: state.error);

    }
  },
  builder: (context, state) {
    bool isLoaded = state is LoginLoading;
    return ModalProgressHUD(
      inAsyncCall: isLoaded,
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: height * .08,
                  ),
                  Image.asset(
                    Assets.imagesLogo1,
                    height: height * .090,
                  ),
                  const SizedBox(
                    height: 5
                  ),
                  Text(
                    'تسجيل الدخول',
                    style: Styles.textStyle24.copyWith(color: kPrimaryColor),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomFormField(
                    controller: emailController,
                    //focusNode: emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    hintText: 'البريد الالكتروني',
                    textAlign: TextAlign.right,
                    suffixIcon: const Icon(
                      Icons.email_outlined,
                      size: 22,
                    ),
                    inputBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    inputFocusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                        )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    maxLines: 1,
                    hintText: 'كلمة المرور',
                    textAlign: TextAlign.right,
                    suffixIcon: const Icon(
                      Icons.lock_open_outlined,
                      size: 22,
                    ),
                    inputBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    inputFocusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: kPrimaryColor,
                        )),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomMaterialButton(
                    onPressed: ()
                    {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<LoginCubit>(context).loginUser(
                            email: emailController.text,
                            password: passwordController.text);
                      } else {}
                    },
                    text: 'تسجيل الدخول',
                    fontSize: 20,
                    radius: 15,
                    fontWeight: FontWeight.w600,
                    splashColor: Colors.blueGrey,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  TextButton(
                    onPressed: () {
                      // Navigate back to the login page
                      GoRouter.of(context).push(AppRouter.kRegisterView);
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DefaultText(
                          text: 'سجل هنا ',
                          color: kPrimaryColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        DefaultText(
                          text: 'ليس لديك حساب؟',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  },
);
  }
}
