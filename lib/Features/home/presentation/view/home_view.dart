import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pteye/Features/home/presentation/view/widgets/home_view_body.dart';
// ignore: depend_on_referenced_packages
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:pteye/core/utils/app_router.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/utils/widgets/navigation_bar.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final PersistentTabController controller =
      PersistentTabController(initialIndex: 0);


  @override
  Widget build(BuildContext context) {
     DateTime? lastPressed;
    return  PopScope(
      onPopInvoked: (t) {
        final now = DateTime.now();
        if (lastPressed == null || now.difference(lastPressed!) > const Duration(seconds: 1)) {
          lastPressed = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Press again to exit'),
              duration: Duration(seconds: 1),
            ),
          );
        } else {
          SystemNavigator.pop();
        }
      },
      child: RefreshIndicator(
        backgroundColor: kPrimaryColor,
        color: Colors.white,
        onRefresh: (){
          return GoRouter.of(context).pushReplacement(AppRouter.kHomeView);
        },
        child: Scaffold(
            body: const HomeViewBody(),
          bottomNavigationBar:CustomNavBar(),
        ),
      ),
    );
  }

}









