import 'package:flutter/material.dart';
import 'package:test2/chatbot/opciones.dart';

/// A card widget that displays emotions and allows the user to select a sentiment.
class EmocionesCard extends StatefulWidget {
  final String TipoActividad;
  final Function(String) onSentimientoSelected;

  /// Creates a new instance of [EmocionesCard].
  ///
  /// The [TipoActividad] parameter is the type of activity associated with the card.
  /// The [onSentimientoSelected] parameter is a callback function that is called when a sentiment is selected.
  EmocionesCard({
    required this.TipoActividad,
    required this.onSentimientoSelected,
  });

  @override
  _EmocionesCard createState() => _EmocionesCard();
}

class _EmocionesCard extends State<EmocionesCard> {
  bool isVisible = true;
  final IconData frustracion = Icons.sentiment_very_dissatisfied;
  final IconData tristeza = Icons.sentiment_dissatisfied_outlined;
  final IconData neutro = Icons.sentiment_neutral;
  final IconData contento = Icons.sentiment_satisfied_outlined;
  final IconData emocionado = Icons.sentiment_very_satisfied_rounded;

  /// Handles the selection of an emoji.
  ///
  /// The [valor] parameter is the value associated with the selected emoji.
  void presiono_emoji(String valor) {
    print(widget.TipoActividad);
    widget.onSentimientoSelected(valor);
    setState(() {
      isVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).orientation == Orientation.portrait
                    ? 0.0
                    : 0.0,
                top: MediaQuery.of(context).orientation == Orientation.portrait
                    ? 0.0
                    : 0.0,
                right: 0.0,
                bottom:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? 300.0
                        : 10.0),
            child: GestureDetector(
              // onTap: isVisible ? presiono_info : null,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 500),
                opacity: isVisible ? 1.0 : 0.0,
                child: Container(
                  width:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 250.0
                          : 350.0,
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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 10.0),
                          physics: BouncingScrollPhysics(),
                          child: Text(
                            "¿Como te sentiste con esta " +
                                widget.TipoActividad,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? 0.0
                                      : 15.0,
                                  top: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? 0.0
                                      : 0.0,
                                  right: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? 0.0
                                      : 15.0,
                                  bottom: MediaQuery.of(context).orientation ==
                                          Orientation.portrait
                                      ? 0.0
                                      : 10.0),
                              child: Row(children: <Widget>[
                                AnimatedCard(
                                  isVisible: isVisible,
                                  text: '',
                                  icon: frustracion,
                                  onTap: () => presiono_emoji('frustración'),
                                ),
                                AnimatedCard(
                                  isVisible: isVisible,
                                  text: '',
                                  icon: tristeza,
                                  onTap: () => presiono_emoji('tristeza'),
                                ),
                                AnimatedCard(
                                  isVisible: isVisible,
                                  text: '',
                                  icon: neutro,
                                  onTap: () => presiono_emoji('neutro'),
                                ),
                                AnimatedCard(
                                  isVisible: isVisible,
                                  text: '',
                                  icon: contento,
                                  onTap: () => presiono_emoji('contento'),
                                ),
                                AnimatedCard(
                                  isVisible: isVisible,
                                  text: '',
                                  icon: emocionado,
                                  onTap: () => presiono_emoji('emocionado'),
                                ),
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
