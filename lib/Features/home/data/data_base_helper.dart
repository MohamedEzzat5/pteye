import 'package:pteye/Features/home/data/record_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = 'audio_database.db';
  static const _databaseVersion = 1;

  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getDatabasesPath();
    final path = join(documentsDirectory, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE audio_recordings (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        path TEXT
      )
      ''');
  }

  Future<int> insertAudioRecording(AudioRecording audioRecording) async {
    final db = await database;
    return await db.insert('audio_recordings', audioRecording.toMap());
  }

  Future<List<AudioRecording>> getAudioRecordings() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('audio_recordings');
    return List.generate(maps.length, (i) {
      return AudioRecording.fromMap(maps[i]);
    });
  }
}
