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

class FilesView extends StatelessWidget {


  const FilesView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Column(
          children: [
            const CustomAppBar(appBarTitle: 'مللفاتك'),
            BlocProvider(
              create: (context) => FilesCubit(),
              child: BlocBuilder<FilesCubit, FilesState>(
                builder: (context, state) {
                  if (state is FilesInitial) {
                    context.read<FilesCubit>().fetchSelectedItems();
                    return  const Center(child: SpinKitFadingCircle(color: kPrimaryColor,));
                  } else if (state is FilesLoaded) {
                    return SizedBox(
                        height: context.height/2.25,
                        child: CustomSelectedItemsGridView(selectedItems: state.selectedItems));
                  } else if (state is FilesError) {
                    return  Text('لا يوجد ملفات حاليًا',style: Styles.textStyle20.copyWith(color: Colors.grey),);
                  }else if (state is FilesNoData) {
                    return  Center(child: Text('لا يوجد ملفات حاليًا',style: Styles.textStyle20.copyWith(color: Colors.grey),));
                  } else {
                    return const SizedBox(height: 1,);
                  }
                },
              ),
            ),
            const SizedBox(height: 10,),
            const RecordAndPlayVoice(),
          ],
        ),
    );
  }
}
