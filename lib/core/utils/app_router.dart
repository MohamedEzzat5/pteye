
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:pteye/Features/splash/presentation/views/splash_view.dart';


abstract class AppRouter {
  static const kHomeView = '/homeView';
  static const kBookDetailsView = '/bookDetailsView';
  static const kSearchView = '/searchView';
  static final router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return const SplashView();
        },
      ),

    ],
  );
}
