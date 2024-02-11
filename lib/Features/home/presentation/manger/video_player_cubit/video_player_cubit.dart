// // import 'package:bloc/bloc.dart';
// // import 'package:chewie/chewie.dart';
// // import 'package:flutter/material.dart';
// // import 'package:pteye/Features/home/presentation/manger/video_player_cubit/video_player_state.dart';
// // import 'package:video_player/video_player.dart';
// //
// // class VideoPlayerCubit extends Cubit<VideoPlayerState> {
// //   VideoPlayerCubit() : super(VideoPlayerInitial());
// //
// //   void initializeVideoPlayer(String videoUrl) async {
// //     final VideoPlayerController videoPlayerController =
// //     VideoPlayerController.networkUrl(Uri.parse(videoUrl));
// //
// //     // Set autoInitialize to false
// //     final ChewieController chewieController = ChewieController(
// //       videoPlayerController: videoPlayerController,
// //       autoPlay: false,
// //       zoomAndPan: true,
// //       allowFullScreen: true,
// //       looping: false,
// //       showControls: true,
// //       autoInitialize: false, // Set autoInitialize to false
// //       errorBuilder: (context, errorMessage) =>
// //       const Text('برجاء التأكد من الاتصال بالانترنت'),
// //     );
// //
// //     emit(VideoPlayerLoading());
// //
// //     try {
// //       await videoPlayerController.initialize();
// //       chewieController.enterFullScreen();
// //       chewieController.play();
// //       emit(VideoPlayerLoaded(
// //         videoPlayerController: videoPlayerController,
// //         chewieController: chewieController,
// //       ));
// //     } catch (error) {
// //       emit(const VideoPlayerError(errorMessage: 'برجاء التأكد من الاتصال بالانترنت'));
// //     }
// //   }
// //
// //   void disposeVideoPlayer() {
// //     final currentState = state;
// //     if (currentState is VideoPlayerLoaded) {
// //       currentState.videoPlayerController.dispose();
// //       currentState.chewieController.dispose();
// //       emit(VideoPlayerInitial());
// //     }
// //   }
// // }
//
//
//
//
//
// import 'package:bloc/bloc.dart';
// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:pteye/Features/home/presentation/manger/video_player_cubit/video_player_state.dart';
// import 'package:video_player/video_player.dart';
//
//
// class VideoPlayerCubit extends Cubit<VideoPlayerState> {
//   VideoPlayerCubit() : super(VideoPlayerInitial());
//
//   void initializeVideoPlayer(String videoUrl,) async {
//     final VideoPlayerController videoPlayerController =
//     VideoPlayerController.networkUrl(Uri.parse(videoUrl));
//
//     // Set autoInitialize to false
//     final ChewieController chewieController = ChewieController(
//       videoPlayerController: videoPlayerController,
//       autoPlay: false,
//       zoomAndPan: true,
//       allowFullScreen: true,
//       looping: false,
//       showControls: true,
//       autoInitialize: true,
//       errorBuilder: (context, errorMessage) =>
//       const Text('برجاء التأكد من الاتصال بالانترنت'),
//     );
//
//     emit(VideoPlayerLoading());
//
//     try {
//       await videoPlayerController.initialize();
//
//       chewieController.enterFullScreen();
//       emit(VideoPlayerLoaded(
//         videoPlayerController: videoPlayerController,
//         chewieController: chewieController,
//       ));
//
//     } catch (error) {
//       emit(const VideoPlayerError(
//           errorMessage: 'برجاء التأكد من الاتصال بالانترنت'));
//     }
//   }
//
//
//   void playVideo() {
//     if (state is VideoPlayerLoaded) {
//       final loadedState = state as VideoPlayerLoaded;
//       loadedState.chewieController.play();
//     }
//   }
//
//   void disposeVideoPlayer() {
//     final currentState = state;
//     if (currentState is VideoPlayerLoaded) {
//       currentState.videoPlayerController.dispose();
//       currentState.chewieController.dispose();
//       emit(VideoPlayerInitial());
//     }
//      // Move emit outside the if block
//
//   }
// }
//
