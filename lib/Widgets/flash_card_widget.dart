import 'package:ehkow/business/constants/constants.dart';
import 'package:ehkow/business/model/flashcard.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../business/data/flashcard_repository.dart';

class FlashCardWidget extends StatefulWidget {
  late final int flashCardId;
  late final FlashCardRepository flashCardRepository;
  late final double height;
  late final double width;

  FlashCardWidget(
      this.flashCardId, this.flashCardRepository, this.height, this.width,
      {super.key}) {}

  @override
  State<FlashCardWidget> createState() => _FlashCardWidgetState();
}

class _FlashCardWidgetState extends State<FlashCardWidget> {
  bool _isTranslated = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FlashCard>(
      future: getFlashCard(widget.flashCardId),
      // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<FlashCard> snapshot) {
        // AsyncSnapshot<Your object type>
        return GestureDetector(
            onTap: _toggleTranslation,
            child: Column(
              children: [
                SizedBox(
                  height: widget.height,
                  width: widget.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80),
                        side: const BorderSide(
                            color: Colors.black87, width: 5.0)),
                    color: Colors.transparent,
                    elevation: 0,
                    child: Container(
                        alignment: Alignment.center,
                        child: snapshot.hasData
                            ? Text(_isTranslated
                                ? snapshot.data!.translatedContent.toString()
                                : snapshot.data!.originalContent.toString())
                            : Text(
                                Constants.basic_error,
                                style: GoogleFonts.vollkorn(fontSize: 30),
                              )),
                  ),
                )
              ],
            ));
      },
    );
  }

  void _toggleTranslation() {
    setState(() {
      if (_isTranslated) {
        _isTranslated = false;
      } else {
        _isTranslated = true;
      }
    });
  }

  Future<FlashCard> getFlashCard(int flashCardId) async {
    return await widget.flashCardRepository.findById(flashCardId);
  }
}
