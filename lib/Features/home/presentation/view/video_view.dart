// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:pteye/Features/home/presentation/manger/video_player_cubit/video_player_cubit.dart';
// import 'package:pteye/Features/home/presentation/manger/video_player_cubit/video_player_state.dart';
// import 'package:pteye/core/utils/constance.dart';
// import 'package:pteye/core/utils/style.dart';
//
// class VideoPlayerView extends StatelessWidget {
//   final String videoUrl;
//
//   const VideoPlayerView({Key? key, required this.videoUrl}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => VideoPlayerCubit(),
//       child: Builder(
//         builder: (context) {
//           context.read<VideoPlayerCubit>().initializeVideoPlayer(videoUrl);
//           return BlocConsumer<VideoPlayerCubit, VideoPlayerState>(
//             listener: (context, state) {
//               if (state is VideoPlayerError) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                     content: Text(state.errorMessage),
//                   ),
//                 );
//               }
//             },
//             builder: (context, state) {
//               return _buildVideoPlayer(context, state);
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildVideoPlayer(BuildContext context, VideoPlayerState state) {
//     if (state is VideoPlayerLoading) {
//       return Scaffold(
//         backgroundColor: Colors.black54,
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: kPrimaryColor),
//           centerTitle: true,
//         ),
//         body: const Center(
//           child: SpinKitFadingCircle(color: kPrimaryColor,),
//         ),
//       );
//     } else if (state is VideoPlayerLoaded) {
//       return Scaffold(
//         backgroundColor: Colors.black54,
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: kPrimaryColor),
//           centerTitle: true,
//         ),
//         body: Center(
//           child: Chewie(controller: state.chewieController),
//         ),
//       );
//     } else {
//       // Handle other states or fallback to a default UI
//       return Scaffold(
//         backgroundColor: Colors.black54,
//         appBar: AppBar(
//           iconTheme: const IconThemeData(color: kPrimaryColor),
//         ),
//         body: Center(
//           child:
//           Padding(
//             padding: const EdgeInsets.all(20.0),
//             child: Text(textAlign: TextAlign.center,'فشل تحميل الفيديو برجاء التأكد من الاتصال بالانترنت واعادة المحاولة لاحقا',style: Styles.textStyle18.copyWith(color: Colors.white),),
//           ),
//
//         ),
//       );
//     }
//   }
// }
//








import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/utils/style.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerView extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerView({Key? key, required this.videoUrl}) : super(key: key);

  @override
  VideoPlayerViewState createState() => VideoPlayerViewState();
}

class VideoPlayerViewState extends State<VideoPlayerView> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      zoomAndPan: true,
      allowFullScreen: true,
      placeholder: SpinKitFadingCircle(color: kPrimaryColor,),
      looping: false,
      autoInitialize: true,
      showControlsOnInitialize: false,
      showControls: true,
      errorBuilder: (context, errorMessage) {
        print('=================' + errorMessage.toString());
        return Center(child: Text('برجاء التأكد من الاتصال بالانترنت',style: Styles.textStyle20.copyWith(color: Colors.white),));

        },
    );

  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: kPrimaryColor),
        centerTitle: true,
        title: Text(''),

      ),
      body: Center(
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }
}
