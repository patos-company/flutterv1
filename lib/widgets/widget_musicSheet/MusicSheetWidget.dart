import 'package:flutter/material.dart';
import 'package:test2/widgets/widget_musicSheet/simple_sheet_music.dart';
import 'package:test2/widgets/widget_musicSheet/src/music_objects/note/note.dart';

class MusicSheetWidget extends StatefulWidget {
  final List<Note> notes;

  const MusicSheetWidget({Key? key, required this.notes}) : super(key: key);

  @override
  _MusicSheetWidgetState createState() => _MusicSheetWidgetState();
}

class _MusicSheetWidgetState extends State<MusicSheetWidget> {
  late List<MusicObjectStyle> musicObjects;
  late Measure measure;
  late Staff staff;
  late Clef initialClef;

  @override
  void initState() {
    super.initState();
    initializeMusicObjects();
  }

  @override
  void didUpdateWidget(MusicSheetWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.notes != widget.notes) {
      initializeMusicObjects();
    }
  }

  void initializeMusicObjects() {
    initialClef = const Clef(ClefType.treble);
    musicObjects = [initialClef, ...widget.notes];
    measure = Measure(musicObjects);
    staff = Staff([measure]);
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final height = screenSize.height / 2;
    final width = screenSize.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SimpleSheetMusic(
        initialClef: initialClef,
        margin: const EdgeInsets.all(75),
        height: height,
        width: width,
        staffs: [staff],
      ),
    );
  }
}
