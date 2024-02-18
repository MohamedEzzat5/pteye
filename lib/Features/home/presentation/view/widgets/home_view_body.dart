// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pteye/Features/home/presentation/view/widgets/custom_diseases_grid_view.dart';
import 'package:pteye/Features/home/presentation/view/widgets/custom_hello_container.dart';
import 'package:pteye/core/utils/style.dart';
import 'package:pteye/core/widgets/custom_app_bar.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Future<bool> _onWillPop() async {
      bool type = false;
      await Future.delayed(
        Duration.zero,
        () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                title: Text(
                  'هل تريد الخروج من البرنامج؟',
                  style:
                      Styles.textStyle22.copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.end,
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        type = false;
                        Navigator.pop(context);
                      },
                      child: const Text('لا', style: Styles.textStyle16)),
                  TextButton(
                      onPressed: () {
                        type = true;
                        SystemNavigator.pop();
                      },
                      child: const Text(
                        'نعم',
                        style: Styles.textStyle16,
                      )),
                ],
              );
            },
          );
        },
      );
      return type;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
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
