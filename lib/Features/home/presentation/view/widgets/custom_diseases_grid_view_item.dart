import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:pteye/core/utils/app_router.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/utils/media_query_values.dart';
import 'package:pteye/core/utils/style.dart';
import 'package:pteye/generated/assets.dart';

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
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(AppRouter.kExerciseView, extra: diseaseName);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: width / 14.5 / 20,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) => const SpinKitFadingGrid(color: kPrimaryColor),
                    errorWidget: (context, url, error) {
                      debugPrint('================$error================$imageUrl');
                      return Image.asset(Assets.imagesVideoPlay,height: context.height*0.085,);
                    },
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  diseaseName,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: Styles.textStyle14.copyWith(fontWeight: FontWeight.w600, overflow: TextOverflow.ellipsis, height: 1.2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// class CustomGridViewItem extends StatelessWidget {
//   final String diseaseName;
//   final String imageUrl;
//
//   const CustomGridViewItem({
//     Key? key,
//     required this.diseaseName,
//     required this.imageUrl,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     //var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return GestureDetector(
//       onTap: () {
//         //{'diseaseName': diseaseName}
//         GoRouter.of(context).push(AppRouter.kExerciseView,extra: diseaseName);
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         child: Column(
//           children: [
//             // const Spacer(
//             //   flex: 1,
//             // ),
//             AspectRatio(
//               aspectRatio: width/14.5 / 20,
//               child: Container(
//                 margin: const EdgeInsets.all(10),
//                 // decoration: BoxDecoration(
//                 //   borderRadius: BorderRadius.circular(10),
//                 //   image: DecorationImage(
//                 //       image: CachedNetworkImageProvider(
//                 //     imageUrl,
//                 //   )),
//                 // ),
//                 child: CachedNetworkImage(
//                   imageUrl: '$imageUrl',
//                   placeholder: (context, url) => const SpinKitFadingGrid(color: kPrimaryColor),
//                   errorWidget: (context, url, error) {
//                     debugPrint('================' + error.toString() + '================' + imageUrl);
//                     return Icon(Icons.error_rounded,color: kPrimaryColor,);
//                   },
//                   imageBuilder: (context, imageProvider) => Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       image: DecorationImage(
//                           image: imageProvider,
//                           fit: BoxFit.fill,
//                         //scale: 6
//                           ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//                 SizedBox(height: 2,),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10.0),
//               child: Text(
//                 textAlign: TextAlign.center,
//                 diseaseName,
//                 maxLines: 2,
//                 style: Styles.textStyle14.copyWith(fontWeight: FontWeight.w600,overflow:TextOverflow.ellipsis,height: 1.2),
//               ),
//             ),
//             // const Spacer(
//             //   flex: 1,
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }
