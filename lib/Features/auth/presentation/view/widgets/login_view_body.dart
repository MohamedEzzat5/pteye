import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pteye/core/utils/app_router.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/utils/style.dart';
import 'package:pteye/core/utils/widgets/widgets/default_button.dart';
import 'package:pteye/core/utils/widgets/widgets/default_form_field.dart';
import 'package:pteye/core/utils/widgets/widgets/default_text.dart';
import 'package:pteye/generated/assets.dart';

class LoginViewBody extends StatelessWidget {
  LoginViewBody({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    //var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * .08,
            ),
            Image.asset(
              Assets.logoImage,
              height: height * .2,
            ),
            const SizedBox(
              height: 5,
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
              onPressed: () {
                GoRouter.of(context).push(AppRouter.kHomeView);
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
    );
  }
}
