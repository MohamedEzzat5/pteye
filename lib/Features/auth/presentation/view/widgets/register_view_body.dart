import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pteye/core/utils/app_router.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/utils/style.dart';
import 'package:pteye/core/utils/widgets/widgets/default_button.dart';
import 'package:pteye/core/utils/widgets/widgets/default_form_field.dart';
import 'package:pteye/core/utils/widgets/widgets/default_text.dart';
import 'package:pteye/generated/assets.dart';

class RegisterViewBody extends StatelessWidget {
   RegisterViewBody({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return  Padding(
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
              hintText: 'الاسم',
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
              //focusNode: emailFocus,
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
              controller: passwordController,
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
              onPressed: () {
                GoRouter.of(context).push(AppRouter.kHomeView);
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
                    text: 'قم بتسجيل الدخول هنا.',
                    color: kPrimaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  DefaultText(
                    text: 'هل لديك حساب بالفعل؟ ',
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