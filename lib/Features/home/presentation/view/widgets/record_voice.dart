import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pteye/core/utils/constance.dart';
import 'package:pteye/core/utils/media_query_values.dart';
import 'package:pteye/core/widgets/default_text.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class RecordAndPlayVoice extends StatefulWidget {
  const RecordAndPlayVoice({Key? key}) : super(key: key);

  @override
  State<RecordAndPlayVoice> createState() => _RecordAndPlayVoiceState();
}

class _RecordAndPlayVoiceState extends State<RecordAndPlayVoice> {
  late Record audioRecord;
  late AudioPlayer audioPlayer;
  bool isRecording = false;
  String? currentAudioPath;
  late Database db;

  @override
  void initState() {
    audioPlayer = AudioPlayer();
    audioRecord = Record();
    // Open or create the database when the widget initializes
    _openDatabase();
    super.initState();
  }

  // Method to open or create the SQLite database
  void _openDatabase() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'audio_paths.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE audio_paths(id INTEGER PRIMARY KEY, path TEXT)',
        );
      },
      version: 1,
    );
    // Retrieve the last recorded audio path from the database
    _retrieveLastAudioPath();
  }

  // Method to retrieve the last recorded audio path from the database
  void _retrieveLastAudioPath() async {
    final List<Map<String, dynamic>> rows = await db.query('audio_paths');
    if (rows.isNotEmpty) {
      setState(() {
        currentAudioPath = rows.first['path'];
      });
    }
  }

  // Method to retrieve all recorded audio paths from the database
  Future<List<String>> _retrieveAllAudioPaths() async {
    final List<Map<String, dynamic>> rows = await db.query('audio_paths');
    return rows.map<String>((row) => row['path'] as String).toList();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    audioRecord.dispose();
    db.close();
    super.dispose();
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecord.hasPermission()) {
        await audioRecord.start();
        setState(() {
          isRecording = true;
        });
      }
    } catch (e) {
      debugPrint('Error Start Recording=========$e');
    }
  }

  Future<void> stopRecording() async {
    try {
      String? path = await audioRecord.stop();
      setState(() {
        isRecording = false;
        currentAudioPath = path;
      });
      // Save the audio path to the database
      await db.insert(
        'audio_paths',
        {'path': path},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      debugPrint('Error Stop Recording=========$e');
    }
  }

  Future<void> playRecording(String audioPath) async {
    try {
      Source urlSource = UrlSource(audioPath);
      await audioPlayer.play(urlSource);
    } catch (e) {
      debugPrint('Error play Recording=========$e');
    }
  }

  Future<void> deleteRecording(int id) async {
    await db.delete(
      'audio_paths',
      where: 'id = ?',
      whereArgs: [id],
    );
    final List<String> paths = await _retrieveAllAudioPaths();
    setState(() {
      currentAudioPath = paths.isNotEmpty ? paths.first : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(
                    side: BorderSide(style: BorderStyle.solid, color: kPrimaryColor)),
                padding: EdgeInsets.zero,
              ),
              onPressed: isRecording ? stopRecording : startRecording,
              child: isRecording
                  ? const Icon(Icons.pause_circle_filled_rounded, size: 32,)
                  : const Icon(Icons.keyboard_voice_rounded, size: 32,),
            ),
            if (isRecording)
              const DefaultText(text: 'Recording is Progress', fontSize: 15,),
            const SizedBox(width: 0,),
            if (!isRecording && currentAudioPath != null)
              ElevatedButton(
                onPressed: () => playRecording(currentAudioPath!),
                child: const DefaultText(text: 'Play Recording', fontSize: 15,),
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 8),
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        side: BorderSide(
                            style: BorderStyle.solid, color: kPrimaryColor))),
              )
          ],
        ),
        const SizedBox(height: 10),
        const Divider(endIndent: 30,indent: 30,color: Colors.black),
        const SizedBox(height: 10),
        const DefaultText(
          text: 'كل التسجيلات',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        FutureBuilder<List<String>>(
          future: _retrieveAllAudioPaths(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SpinKitFadingCircle(color: kPrimaryColor,);
            } else if (snapshot.hasError) {
              return const DefaultText(
                text: 'لا يوجد تسجيلات',
                fontSize: 14,
              );
            } else {
              final List<String> audioPaths = snapshot.data!;
              return Column(
                children: audioPaths.map((path) {
                  final index = audioPaths.indexOf(path) + 1;
                  return Container(
                    width: context.width/2,
                    color: kPrimaryColor,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Center(child: Text('تسجيل $index',textAlign: TextAlign.right,style: const TextStyle(color: Colors.white,),)),
                      onTap: () => playRecording(path),
                      selectedColor: kPrimaryColor,
                      visualDensity: VisualDensity.comfortable,
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('حذف التسجيل؟', textAlign: TextAlign.right,),
                            content: const Text('هل انت متأكد من حذف التسجيل؟', textAlign: TextAlign.right,),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('لا'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  deleteRecording(index);
                                },
                                child: const Text('نعم'),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              );
            }
          },
        ),

      ],
    );
  }
}
