import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pteye/Features/auth/presentation/manger/register_cubit/register_cubit.dart';
import 'package:pteye/Features/auth/presentation/manger/register_cubit/register_state.dart';
import 'package:pteye/core/utils/app_router.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/utils/style.dart';
import 'package:pteye/core/utils/widgets/show_snackbar.dart';
import 'package:pteye/core/widgets/default_button.dart';
import 'package:pteye/core/widgets/default_form_field.dart';
import 'package:pteye/core/widgets/default_text.dart';
import 'package:pteye/generated/assets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterViewBody extends StatelessWidget {
  RegisterViewBody({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();
  bool isLoaded = false;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          isLoaded = true;
        } else if (state is RegisterSuccess) {
          GoRouter.of(context).push(AppRouter.kHomeView);
          isLoaded = false;
          return showSnackBar(
            (context),
            message: 'تم تسجل حساب جديد بنجاح',
          );
        } else if (state is RegisterFailure) {
          isLoaded = false;
          return showSnackBar(
            (context),
            message: state.error,
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoaded,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
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
                        height: 5,
                      ),
                      Text(
                        'تسجيل حساب جديد',
                        style: Styles.textStyle24.copyWith(color: kPrimaryColor),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      CustomFormField(
                        controller: nameController,
                        //focusNode: emailFocus,
                        keyboardType: TextInputType.text,
                        hintText: 'اسم المستخدم',
                        textAlign: TextAlign.right,
                        suffixIcon: const Icon(
                          Icons.person,
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
                        controller: emailController,
                        onChanged: (data) {
                          emailController.text = data;
                        },
                        keyboardType: TextInputType.emailAddress,
                        hintText: 'البريد الالكتروني',
                        textAlign: TextAlign.right,
                        suffixIcon: const Icon(
                          Icons.email,
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
                        controller: phoneController,
                        onChanged: (data) {
                        },
                        keyboardType: TextInputType.number,
                        hintText: 'رقم الهاتف',
                        textAlign: TextAlign.right,
                        suffixIcon: const Icon(
                          Icons.phone_iphone,
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
                        onChanged: (data) {
                          passwordController.text = data;
                        },
                        keyboardType: TextInputType.text,
                        obscureText: true,
                        maxLines: 1,
                        hintText: 'كلمة المرور',
                        textAlign: TextAlign.right,
                        suffixIcon: const Icon(
                          Icons.lock,
                          size: 21,
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
                        onPressed: ()async
                        {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<RegisterCubit>(context).registerUser(
                                email: emailController.text,
                                password: passwordController.text);
                          } else {}
                        },
                        text: 'تسجيل حساب جديد',
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
                          GoRouter.of(context).pop();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            DefaultText(
                              text: 'قم بتسجيل الدخول هنا ',
                              color: kPrimaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            DefaultText(
                              text: 'هل لديك حساب بالفعل؟',
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
