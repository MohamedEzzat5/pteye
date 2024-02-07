import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pteye/Features/home/presentation/view/widgets/custom_diseases_grid_view.dart';
import 'package:pteye/Features/home/presentation/view/widgets/custom_hello_container.dart';
import 'package:pteye/core/utils/style.dart';
import 'package:pteye/core/widgets/custom_app_bar.dart';

import '../../../../../core/utils/widgets/show_snackbar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key,});

  @override
  Widget build(BuildContext context) {
    DateTime? lastPressed;

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        if (lastPressed == null || now.difference(lastPressed!) > const Duration(seconds: 1)) {
          lastPressed = now;
          showSnackBar(context, message: 'اضغط مرة اخري للخروج من البرنامج',);

          return false; // Return false to indicate that the back press is not handled yet.
        } else {
          SystemNavigator.pop();
          return true;
        }
      },
      child: const Scaffold(
        body: Column(
          children: [
            CustomAppBar(appBarTitle: 'الرئيسية'),
            HelloContainer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('الامراض', style: Styles.textStyle20),
                ],
              ),
            ),
            CustomDiseasesGridView(),
          ],
        ),
      ),
    );
  }
}
