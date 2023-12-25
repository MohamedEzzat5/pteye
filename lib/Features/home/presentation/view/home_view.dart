import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pteye/Features/home/presentation/view/widgets/home_view_body.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:pteye/core/utils/widgets/navigation_bar.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final PersistentTabController controller =
      PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

        body: const HomeViewBody(),
      bottomNavigationBar:CustomNavBar(),
    );
  }

}









