import 'package:flutter/material.dart';
import 'package:flutter_piano_audio_detection/flutter_piano_audio_detection.dart';

/// A screen that allows users to practice audio recognition with a piano.
class PracticaScreen extends StatefulWidget {
  @override
  _PracticaScreenState createState() => _PracticaScreenState();
}

class _PracticaScreenState extends State<PracticaScreen> {
  final isRecording = ValueNotifier<bool>(false);
  FlutterPianoAudioDetection fpad = FlutterPianoAudioDetection();

  Stream<List<dynamic>>? result;
  List<String> notes = [];
  String printText = "";

  @override
  void initState() {
    super.initState();
    fpad.prepare();
  }

  /// Starts the audio recognition process.
  void start() {
    fpad.start();
    getResult();
  }

  /// Stops the audio recognition process.
  void stop() {
    fpad.stop();
  }

  /// Retrieves the audio recognition result and updates the notes list.
  void getResult() {
    result = fpad.startAudioRecognition();
    result!.listen((event) {
      printText = "";
      setState(() {
        notes = fpad.getNotes(event);
      });
      notes.map((e) => {printText += e});
      print(notes);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practica'),
      ),
      body: Center(
        child: Text(
          '${notes}',
          style: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
        ),
      ),
      floatingActionButton: Container(
        child: ValueListenableBuilder(
          valueListenable: isRecording,
          builder: (context, value, widget) {
            if (value == false) {
              return FloatingActionButton(
                onPressed: () {
                  isRecording.value = true;
                  start();
                },
                backgroundColor: Colors.blue,
                child: const Icon(Icons.mic),
              );
            } else {
              return FloatingActionButton(
                onPressed: () {
                  isRecording.value = false;
                  stop();
                },
                backgroundColor: Colors.red,
                child: const Icon(Icons.adjust),
              );
            }
          },
        ),
      ),
    );
  }
}
