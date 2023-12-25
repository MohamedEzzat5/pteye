import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pteye/Features/auth/data/repos/auth_repo.dart';
import 'package:pteye/Features/auth/data/repos/auth_repo_impl.dart';
import 'package:pteye/Features/auth/presentation/manger/login_cubit/login_cubit.dart';
import 'package:pteye/core/utils/app_router.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pteye/firebase_options.dart';

import 'Features/auth/presentation/manger/register_cubit/register_cubit.dart';

void main() async{
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,);
  } catch (e) {
    // TODO
  }

  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
   String email = 'mohamed10@email.com'; // Replace with your actual email
  String password = '123456789';
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterCubit(AuthRepoImplementation()),
        ),
        BlocProvider(
          create: (context) => LoginCubit(AuthRepoImplementation()..loginUser(email, password)),
        ),
      ],
      child: MaterialApp.router(
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(useMaterial3: true).copyWith(
            scaffoldBackgroundColor: const Color(0xffECF0F1),
            textTheme: GoogleFonts.tajawalTextTheme(ThemeData
                .light()
                .textTheme),
            colorScheme: ColorScheme.fromSeed(seedColor: kPrimaryColor),
          )),
    );
  }
}
