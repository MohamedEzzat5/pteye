import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pteye/Features/home/presentation/manger/files_cubit/files_cubit.dart';
import 'package:pteye/Features/home/presentation/manger/files_cubit/files_state.dart';
import 'package:pteye/Features/home/presentation/view/widgets/record_voice.dart';
import 'package:pteye/Features/home/presentation/view/widgets/selected_item_grid_view.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/utils/media_query_values.dart';
import 'package:pteye/core/utils/style.dart';
import 'package:pteye/core/widgets/custom_app_bar.dart';
import 'package:pteye/core/widgets/default_button.dart';
import 'package:pteye/core/widgets/default_text.dart';

class FilesView extends StatelessWidget {
  const FilesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(appBarTitle: 'مللفاتك'),
          BlocProvider(
            create: (context) => FilesCubit(),
            child: BlocBuilder<FilesCubit, FilesState>(
              builder: (context, state) {
                if (state is FilesInitial) {
                  context.read<FilesCubit>().fetchSelectedItems();
                  return const Center(
                      child: SpinKitFadingCircle(color: kPrimaryColor));
                } else if (state is FilesLoaded ) {
                  return Column(
                    children: [
                      SizedBox(
                          height: context.height / 2.25,
                          child: CustomSelectedItemsGridView(
                              selectedItems: state.selectedItems)),
                      !state.isDone ?
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CustomMaterialButton(
                            onPressed: () {
                              context.read<FilesCubit>().markItemAsDone();
                            },
                            text: 'قمت بالتمارين',
                            fontSize: 16,
                            radius: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ) : const Column(
                          children: [
                            SizedBox(height: 10,),
                             DefaultText(text: 'نتمني لك الشفاء العاجل',fontSize: 18,fontWeight: FontWeight.w500),
                          ],
                        ),
                    ],
                  );
                } else if (state is FilesError) {
                  return Text('لا يوجد ملفات حاليًا',
                      style: Styles.textStyle20.copyWith(color: Colors.grey));
                } else if (state is FilesNoData) {
                  return Center(
                      child: Text('لا يوجد ملفات حاليًا',
                          style: Styles.textStyle20.copyWith(color: Colors.grey)));
                } else {
                  return const SizedBox(height: 1);
                }
              },
            ),
          ),
          const RecordAndPlayVoice(),
        ],
      ),
    );
  }
}
