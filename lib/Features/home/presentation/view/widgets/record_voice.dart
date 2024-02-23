// import 'package:flutter/material.dart';
// import 'package:record/record.dart';
// import 'package:audioplayers/audioplayers.dart';
//
// class RecordAndPlayVoice extends StatefulWidget {
//   const RecordAndPlayVoice({super.key});
//
//   @override
//   State<RecordAndPlayVoice> createState() => _RecordAndPlayVoiceState();
// }
//
// class _RecordAndPlayVoiceState extends State<RecordAndPlayVoice> {
//   late Record audioRecord;
//   late AudioPlayer audioPlayer;
//   bool isRecording=false;
//   String? audioPath='';
//
//   @override
//   void initState() {
//     audioPlayer = AudioPlayer();
//     audioRecord = Record();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     audioPlayer.dispose();
//     audioRecord.dispose();
//     super.dispose();
//   }
//
//   Future<void> startRecording() async {
//     try {
//       if(await audioRecord.hasPermission()){
//         await audioRecord.start();
//         setState(() {
//           isRecording =true;
//         });
//       }
//     } catch (e) {
//       debugPrint('Error Start Recording=========$e');
//     }
//   }
//   Future<void> stopRecording() async {
//     try {
//       String? path=  await audioRecord.stop();
//         setState(() {
//           isRecording =false;
//           audioPath = path!;
//         });
//
//     } catch (e) {
//       debugPrint('Error Stop Recording=========$e');
//     }
//   }
//   Future<void> playRecording() async {
//     try {
//      Source urlSource =UrlSource(audioPath!);
//       await audioPlayer.play(urlSource);
//
//     } catch (e) {
//       debugPrint('Error play Recording=========$e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Column(
//       children: [
//         if(isRecording)
//           const Text('Recording is Progress'),
//         ElevatedButton(
//             onPressed:isRecording? stopRecording: startRecording, child: isRecording? const Text('Stop Recording'):const Text('Start Recording')),
//         const SizedBox(height: 25,),
//           if(!isRecording && audioPath!= null)
//         ElevatedButton(onPressed: playRecording, child: const Text('Play Recording'))
//
//       ],
//     );
//   }
// }
