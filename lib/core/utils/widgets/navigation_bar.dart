import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:pteye/Features/home/presentation/view/files_views.dart';
import 'package:pteye/Features/home/presentation/view/widgets/home_view_body.dart';
import 'package:pteye/Features/profile/presentation/views/profile_view.dart';
import 'package:pteye/core/utils/constance.dart';

class CustomNavBar extends StatelessWidget {
   CustomNavBar({super.key});
  final PersistentTabController controller =
  PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,

      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 100),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 100),
      ),
      navBarStyle: NavBarStyle.style9,navBarHeight: 55,padding:const NavBarPadding.symmetric(horizontal: 0), // Choose the nav bar style with this property.
    );
  }

  List<Widget> _buildScreens() {
    return [
      const HomeViewBody(),
      const FilesView(),
      const ProfileView(),
    ];
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),
        title: ("الرئيسية"),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),

      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.folder),
        textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),
        title: ("ملفاتك"),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.settings),
        textStyle: const TextStyle(fontSize: 14,fontWeight: FontWeight.w600),
        title: ("الإعدادات"),
        activeColorPrimary: kPrimaryColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),


    ];
  }
}
