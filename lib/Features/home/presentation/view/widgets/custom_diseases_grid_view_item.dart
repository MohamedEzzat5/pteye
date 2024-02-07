import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:pteye/core/utils/app_router.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/utils/style.dart';


class CustomGridViewItem extends StatelessWidget {
  final String diseaseName;
  final String imageUrl;

  const CustomGridViewItem({
    Key? key,
    required this.diseaseName,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //{'diseaseName': diseaseName}
        GoRouter.of(context).push(AppRouter.kExerciseView,extra: diseaseName);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            AspectRatio(
              aspectRatio: 2 / 1.5,
              child: Container(
                margin: const EdgeInsets.all(10),
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(10),
                //   image: DecorationImage(
                //       image: CachedNetworkImageProvider(
                //     imageUrl,
                //   )),
                // ),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  placeholder: (context, url) => const SpinKitFadingGrid(color: kPrimaryColor),
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 2,
            ),
            Text(
              textAlign: TextAlign.center,
              diseaseName,
              maxLines: 2,
              style: Styles.textStyle16.copyWith(fontWeight: FontWeight.w600,overflow:TextOverflow.ellipsis,),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
