import 'package:flutter/material.dart';
import 'package:pteye/core/utils/style.dart';
import 'package:pteye/core/widgets/custom_app_bar.dart';

class FilesView extends StatelessWidget {
  const FilesView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const CustomAppBar(appBarTitle: 'ملفاتك'),

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text('لا يوجد ملفات حاليا',style: Styles.textStyle20.copyWith(fontWeight: FontWeight.w600,color: Colors.grey.shade500),)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
