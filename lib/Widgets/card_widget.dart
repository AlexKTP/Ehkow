import 'dart:developer';

import 'package:ehkow/business/model/flashcard.dart';
import 'package:flutter/material.dart';

import '../business/data/database_helper.dart';
import '../business/data/flashcard_repository.dart';

class CardWidget extends StatefulWidget {

  late final int flashCard;
  late final FlashCardRepository flashCardRepository;
  late final FlashCard card;

  CardWidget(this.flashCard, {super.key}) {
    flashCardRepository = FlashCardRepository(DatabaseHelper());
  }

  @override
  State<CardWidget> createState() => _CardWidgetState();
}


class _CardWidgetState extends State<CardWidget> {
  bool _isTranslated = false;

  String? text;
  FlashCard? flashCard;


  @override
  Widget build(BuildContext context) {

    getFlashCard(widget);

    return GestureDetector(
      onTap: _toggleTranslation,
        child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(80),
            side: const BorderSide(
              color: Colors.black,
            )
        ),
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          height: 200,
          alignment: Alignment.center,
          child:Text(text != null ? text! : 'Cliquez pour commencer', style: const TextStyle(color: Colors.white, fontSize: 30),),
        ),
    ));



  }



  void _toggleTranslation() {
    setState(() {
      if (_isTranslated) {
        _isTranslated = false;
        text = flashCard?.originalContent;
      } else {
        _isTranslated = true;
        text = flashCard?.translatedContent;
      }
    });
  }


  void getFlashCard(CardWidget widget) async {
    if(widget.flashCard > 0){
      setState(() {
        widget.flashCardRepository.findById(widget.flashCard).then((value) => flashCard = value);
        text = _isTranslated ? flashCard?.translatedContent : flashCard?.originalContent;
        log(text != null ? text! : 'text null');
      });
    }
  }

}


