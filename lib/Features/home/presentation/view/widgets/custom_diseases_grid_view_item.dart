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
    //var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
            // const Spacer(
            //   flex: 1,
            // ),
            AspectRatio(
              aspectRatio: width/14.5 / 20,
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
                  errorWidget: (context, url, error) {
                    print('================' + error.toString() + '================' + imageUrl);
                    return Icon(Icons.error_rounded,color: kPrimaryColor,);
                  },
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        //scale: 6
                          ),
                    ),
                  ),
                ),
              ),
            ),
                SizedBox(height: 4,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                textAlign: TextAlign.center,
                diseaseName,
                maxLines: 2,
                style: Styles.textStyle14.copyWith(fontWeight: FontWeight.w600,overflow:TextOverflow.ellipsis,height: 1.2),
              ),
            ),
            // const Spacer(
            //   flex: 1,
            // ),
          ],
        ),
      ),
    );
  }
}
