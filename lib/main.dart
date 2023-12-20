import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pteye/core/utils/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
   return MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(useMaterial3: true).copyWith(
      scaffoldBackgroundColor: Colors.red,
      textTheme:
      GoogleFonts.montserratTextTheme(ThemeData.light().textTheme),
    ));
  }
}