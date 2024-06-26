import 'package:flutter/material.dart';
import 'package:test2/chatbot/opciones.dart';
import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:test2/chatbot/emociones.dart';

class Chatbot_Tutorial extends StatefulWidget {
  final Function(int) cambiarIndex;

  Chatbot_Tutorial({required this.cambiarIndex});

  @override
  _Chatbot_Tutorial createState() => _Chatbot_Tutorial();
}

class _Chatbot_Tutorial extends State<Chatbot_Tutorial> {
  bool isVisibleMenu = false;
  bool isVisibleChat = false;
  bool isVisibleChatPregunta = false;
  int _IndexTalk = 0;
  // TextEditingController _textController = TextEditingController();

  final IconData guia_icono = Icons.help;
  IconData guia_pausa = Icons.pause;

  String accion_pausa_continuar = "Pausa      ";

  final FlutterTts _flutterTts = FlutterTts();

  Map? _currentVoice;

  void initTTS() {
    _flutterTts.getVoices.then((data) {
      try {
        List<Map> voices = List<Map>.from(data);
        try {
          _flutterTts.setSpeechRate(2.0);
        } catch (e) {
          print(e);
        }
        print(voices);
        voices = voices.where((voice) => voice["name"].contains("es")).toList();
        setState(() {
          _currentVoice = voices.first;
          setVoice(_currentVoice!);
        });
      } catch (e) {
        print(e);
      }
    });
  }

  Completer<void> completer = Completer<void>();

  int indice = 0;

  void presiono_guia() {
    setState(() {
      shouldContinue = false;
      if (timer != null) {
        timer?.cancel();
      }
      shouldContinue = true;
    });
    MostrarTexto(Guia[1]);
    indice = 1;
    accion_pausa_continuar = "Pausa      ";
    guia_pausa = Icons.pause;
  }

  void presiono_pausa() {
    if (indice >= Guia.length) {
      setState(() {
        widget.cambiarIndex(1);
        shouldContinue = false;
      });
    } else if (accion_pausa_continuar != 'Continuar' &&
        accion_pausa_continuar != 'Siguiente') {
      setState(() {
        shouldContinue = false;
        if (timer != null) {
          timer?.cancel();
        }
        accion_pausa_continuar = 'Continuar';
        guia_pausa = Icons.play_arrow;
      });
    } else if (accion_pausa_continuar == 'Continuar') {
      shouldContinue = true;
      // Reiniciar el timer si no se ha completado
      MostrarTexto(Guia[indice]);
      setState(() {
        accion_pausa_continuar = 'Pausa      ';
        guia_pausa = Icons.pause;
      });
    } else if (accion_pausa_continuar == 'Siguiente') {
      MostrarTexto(Guia[indice]);
      accion_pausa_continuar = "Pausa      ";
      guia_pausa = Icons.pause;
    }
  }

  void setVoice(Map voice) {
    _flutterTts.setVoice({"name": voice["name"], "locale": voice["locale"]});
  }

  List<String> Guia = [
    'Bienvenido a Piano Color!\n Con nosotros podras aprender conceptos de musica y tocar divertidas canciones',
    'El modo practica permite escoger una cancion con distintas dificultases, para que puedas ensayar',
    'El modo Generar Melodia permite generar fragmentos musicales para que tengas mas para practicar',
    'El modo Leccion tiene distintos enseñansas y ejercicios asociados',
    'El modo Minijuego tiene distintos juegos para que puedas divertirte',
    'Espero que disfrute y aprendas con Piano Colors'
  ];

  final int delayMilliseconds = 60; // Milisegundos entre cada caracter
  String textoMostrado = "";

  int currentIndex = 0;
  bool shouldContinue = true;
  Timer? timer;

  Future<void> MostrarTexto(String texto) async {
    _flutterTts.setSpeechRate(0.1);
    _flutterTts.speak(texto);

    int localIndex = 0;

    timer = Timer.periodic(Duration(milliseconds: delayMilliseconds), (timer) {
      if (shouldContinue && localIndex < texto.length) {
        setState(() {
          textoMostrado = texto.substring(0, localIndex + 1);
          print(textoMostrado);
          if (texto.substring(localIndex, localIndex + 1) == " ") {
            _IndexTalk = 0;
          } else {
            _IndexTalk = 1;
          }
          localIndex++;
        });
      } else {
        timer.cancel();
        setState(() {
          _IndexTalk = 0;
        });
        completer.complete();
      }
      if (shouldContinue && localIndex == texto.length) {
        indice = indice + 1;
        accion_pausa_continuar = "Siguiente";
        guia_pausa = Icons.arrow_right_alt_outlined;
      }
    });

    return completer.future;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await MostrarTexto(Guia.first);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 50.0
                      : 50.0,
              vertical:
                  MediaQuery.of(context).orientation == Orientation.portrait
                      ? 0.0
                      : 0.0,
            ),
            child: Container(
              width: MediaQuery.of(context).orientation == Orientation.portrait
                  ? 250.0
                  : 350.0,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Column(
                children: [
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Text(
                      textoMostrado,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedCard(
                        isVisible: true,
                        text: 'Guia         ',
                        icon: guia_icono,
                        onTap: () => presiono_guia(),
                      ),
                      AnimatedCard(
                        isVisible: true,
                        text: accion_pausa_continuar,
                        icon: guia_pausa,
                        onTap: () => presiono_pausa(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 10.0,
              bottom: MediaQuery.of(context).orientation == Orientation.portrait
                  ? 0.0
                  : 10.0,
            ),
            child: GestureDetector(
              onTap: isVisibleChat ? null : null,
              child: Container(
                child: IndexedStack(
                  index: _IndexTalk,
                  children: [
                    Image.asset(
                      'assets/chatbot_camaleon_color_final.png',
                    ),
                    Image.asset(
                      'assets/chatbot_camaleon_color_habla_final.png',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
