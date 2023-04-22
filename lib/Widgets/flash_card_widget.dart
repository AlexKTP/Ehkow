import 'package:ehkow/business/model/flashcard.dart';
import 'package:flutter/material.dart';

import '../business/data/flashcard_repository.dart';

class FlashCardWidget extends StatefulWidget {

  late final int flashCardId;
  late final FlashCardRepository flashCardRepository;

  FlashCardWidget(this.flashCardId, this.flashCardRepository, {super.key}) {}

  @override
  State<FlashCardWidget> createState() => _FlashCardWidgetState();
}


class _FlashCardWidgetState extends State<FlashCardWidget> {

  bool _isTranslated = false;

  @override
  Widget build(BuildContext context) {
    return   FutureBuilder<FlashCard>(
      future: getFlashCard(widget.flashCardId), // function where you call your api
      builder: (BuildContext context, AsyncSnapshot<FlashCard> snapshot) {  // AsyncSnapshot<Your object type>
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
                child: snapshot.hasData ?
                Text(_isTranslated ? snapshot.data!.translatedContent.toString() : snapshot.data!.originalContent.toString()) :
                Text('Une erreur a eu lieu')
              ),
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


