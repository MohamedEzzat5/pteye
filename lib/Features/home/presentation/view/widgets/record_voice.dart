import 'package:flutter/material.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/widgets/default_text.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';

class RecordAndPlayVoice extends StatefulWidget {
  const RecordAndPlayVoice({super.key});

  @override
  State<RecordAndPlayVoice> createState() => _RecordAndPlayVoiceState();
}

class _RecordAndPlayVoiceState extends State<RecordAndPlayVoice> {
  late Record audioRecord;
  late AudioPlayer audioPlayer;
  bool isRecording=false;
  String? audioPath='';

  @override
  void initState() {
    audioPlayer = AudioPlayer();
    audioRecord = Record();
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    audioRecord.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    try {
      if(await audioRecord.hasPermission()){
        await audioRecord.start();
        setState(() {
          isRecording =true;
        });
      }
    } catch (e) {
      debugPrint('Error Start Recording=========$e');
    }
  }
  Future<void> stopRecording() async {
    try {
      String? path=  await audioRecord.stop();
        setState(() {
          isRecording =false;
          audioPath = path!;
        });

    } catch (e) {
      debugPrint('Error Stop Recording=========$e');
    }
  }
  Future<void> playRecording() async {
    try {
     Source urlSource =UrlSource(audioPath!);
      await audioPlayer.play(urlSource);

    } catch (e) {
      debugPrint('Error play Recording=========$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(shape: const CircleBorder(side: BorderSide(style: BorderStyle.solid,color: kPrimaryColor)),
            padding: EdgeInsets.zero,

          ),
            onPressed:isRecording? stopRecording: startRecording, child: isRecording? const Icon(Icons.pause_circle_filled_rounded,size: 32,):const Icon(Icons.keyboard_voice_rounded,size: 32,)),
        if(isRecording)
          const DefaultText(text: 'Recording is Progress',fontSize: 15,),
        const SizedBox(width: 0,),
          if(!isRecording && audioPath!= null)
        ElevatedButton(onPressed: playRecording, child: const DefaultText(text: 'Play Recording',fontSize: 15,),
        style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 60,vertical: 8),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8)),side: BorderSide(style: BorderStyle.solid,color: kPrimaryColor))
        )
        )

      ],
    );
  }
}
