import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:pteye/Features/auth/presentation/view/login_view.dart';
import 'package:pteye/Features/auth/presentation/view/register_view.dart';
import 'package:pteye/Features/doctor/presentation/screens/admin_video_screen.dart';
import 'package:pteye/Features/doctor/presentation/screens/admin_panel.dart';
import 'package:pteye/Features/home/presentation/view/exercise_view.dart';
import 'package:pteye/Features/home/presentation/view/home_view.dart';
import 'package:pteye/Features/home/presentation/view/video_view.dart';
import 'package:pteye/Features/splash/presentation/views/splash_view.dart';

abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kLoginView = '/loginView';
  static const kRegisterView = '/registerView';
  static const kExerciseView = '/exerciseView';
  static const kVideoPlayerView = '/videoPlayerView';
  static const kDoctorView = '/doctorView';
  static const kDoctorVideoView = '/doctorVideoView';

  static final router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashView();
        },
      ),
      GoRoute(
        path: kHomeView,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeView();
        },
      ),
      GoRoute(
        path: kLoginView,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginView();
        },
      ),
      GoRoute(
        path: kRegisterView,
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterView();
        },
      ),
      GoRoute(
        path: kExerciseView,
        builder: (BuildContext context, GoRouterState state) {
          return  ExerciseView(
            diseaseName: state.extra as String,
          );
        },
      ),
      GoRoute(
        path: kVideoPlayerView,
        builder: (BuildContext context, GoRouterState state) {
          return  VideoPlayerView(
            videoUrl: state.extra as String,
          );
        },
      ),
      GoRoute(
        path: kDoctorView,
        builder: (BuildContext context, GoRouterState state) {
          return  const DoctorView();
        },
      ),
      GoRoute(
        path: kDoctorVideoView,
        builder: (BuildContext context, GoRouterState state) {
          return   const AdminVideoScreen();
        },
      ),

    ],
  );
}
