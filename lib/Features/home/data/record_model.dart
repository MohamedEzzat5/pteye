class AudioRecording {
  final int? id;
  final String path;

  AudioRecording({this.id, required this.path});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'path': path,
    };
  }

  factory AudioRecording.fromMap(Map<String, dynamic> map) {
    return AudioRecording(
      id: map['id'],
      path: map['path'],
    );
  }
}
