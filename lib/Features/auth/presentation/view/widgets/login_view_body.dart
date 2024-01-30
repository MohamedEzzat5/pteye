import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pteye/Features/auth/presentation/manger/login_cubit/login_cubit.dart';
import 'package:pteye/Features/auth/presentation/manger/login_cubit/login_state.dart';
import 'package:pteye/core/utils/app_router.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/utils/style.dart';
import 'package:pteye/core/widgets/default_button.dart';
import 'package:pteye/core/widgets/default_form_field.dart';
import 'package:pteye/core/widgets/default_text.dart';
import 'package:pteye/generated/assets.dart';

// ignore: depend_on_referenced_packages
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/widgets/alert_dialog.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    bool isLoaded = false;
    var height = MediaQuery.of(context).size.height;
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          isLoaded = true;
        } else if (state is LoginSuccess) {
          GoRouter.of(context).push(AppRouter.kHomeView);
          isLoaded = false;
        } else if (state is LoginFailure) {
          isLoaded = false;
          customAwesomeDialog(
            buildContext: context,
            title: 'خطأ',
            dialogType: DialogType.error,
            animType: AnimType.scale,
            description: state.error,
          );
        }
      },
      builder: (context, state) {
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
                        height: height * .1,
                      ),
                      Image.asset(
                        Assets.imagesLogo,
                        height: height * .090,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'تسجيل الدخول',
                        style:
                            Styles.textStyle24.copyWith(color: kPrimaryColor),
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
                        height: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          // Navigate back to the login page
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DefaultText(
                              text: 'هل نسيت كلمة المرور؟',
                              color: kPrimaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomMaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<LoginCubit>(context).loginUser(
                                email: emailController.text,
                                password: passwordController.text);
                          } else {}
                        },
                        text: 'تسجيل الدخول',
                        fontSize: 18,
                        radius: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          BlocProvider.of<LoginCubit>(context).loginWithGoogle();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade700,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.all(height * 0.011),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset(
                              Assets.imagesGoogle,
                              height: 30,
                            ),
                            Text(
                              'تسجيل الدخول بواسطة جوجل',
                              style: Styles.textStyle18.copyWith(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
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
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                            DefaultText(
                              text: 'ليس لديك حساب؟',
                              color: Colors.black,
                              fontSize: 15,
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
