import 'package:flutter/material.dart';
import 'package:pteye/Features/home/presentation/view/widgets/home_view_body.dart';
import 'package:pteye/core/utils/widgets/navigation_bar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomeViewBody(),
      bottomNavigationBar: CustomNavBar(),
    );
  }
}
