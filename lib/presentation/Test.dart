import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flash_card_flutter/Widgets/CardWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../business/data/DatabaseHelper.dart';
import '../business/data/DeckRepository.dart';
import '../business/data/FlashCardRepository.dart';
import '../business/model/Deck.dart';
import '../business/model/FlashCard.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {

    int cardDisplayed = 0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Spacer(flex: 1),
        TextButton(
          onPressed: () => { print("Go to dashboard")},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "DashBoard",
                style: GoogleFonts.roboto(
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                    fontSize: 20),
              ),
              Container(margin: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                  child: const Icon(
                    Icons.dashboard, color: Colors.pinkAccent,)
              )
            ],
          ),
        ),
        Expanded(
          flex: 8,
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                    child: IconButton(
                      onPressed: () => changeCard(),
                      icon: const Icon(Icons.keyboard_double_arrow_left,
                          color: Colors.white),
                    )),
              ),
              Expanded(
                  flex: 6, // 60%
                  child: CardWidget(cardDisplayed)
              ),
              Expanded(
                flex: 2,
                child: Container(
                    child: IconButton(
                      onPressed: () => changeCard(),
                      icon: const Icon(Icons.keyboard_double_arrow_right,
                          color: Colors.white),
                    )),
              )
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: IconButton(hoverColor: Colors.white,
              iconSize: 20.0,
              icon: Icon(Icons.file_download_rounded),
              onPressed: () {},
        ),
        )],
    );
  }
}



void changeCard() async {
  final random = Random();
  FlashCardRepository flashCardRepository = FlashCardRepository(DatabaseHelper());
  var rows = await  flashCardRepository.rowCount();
  if (rows != null && rows > 0) {
    //setState(() {cardDisplayed = random.nextInt(rows);});
  }
}


Future<void> importFile() async {
  FilePickerResult? result = await FilePicker.platform
      .pickFiles(type: FileType.custom, allowedExtensions: ['csv']);
  if (result != null && result.files.isNotEmpty) {
    for (PlatformFile file in result.files) {
      final input = File(file.path!).openRead();
      final fields = await input
          .transform(utf8.decoder)
          .transform(const CsvToListConverter())
          .toList();
      List<List<String>> finalList = [];

      for (var i = 0; i < fields.length; i++) {
        finalList.add((fields[i].toString()).split(";"));
      }

      Deck deck = Deck(name: 'First');
      DeckRepository deckRepository = DeckRepository(DatabaseHelper());
      int id = await deckRepository.create(deck);

      for (var i = 0; i < finalList.length; i++) {
        String content = finalList[i][0].trim();
        if(content.indexOf("(")>0){
          String a = content.substring(content.indexOf("."), content.indexOf('('))
              .replaceAll(".", "")
              .trim();
          int c = content.lastIndexOf("=");
          if (c < 0) c = content.lastIndexOf("/");
          if (c > 0) {
            String b = content.substring(c).replaceAll("=", "").replaceAll(
                "/", "").trim();
            if (a != b) {
              FlashCard flashCard = FlashCard(
                  originalContent: a, translatedContent: b, deckId: 0);
              flashCard.deckId = id;
              FlashCardRepository flashCardRepository =
              FlashCardRepository(DatabaseHelper());
              flashCardRepository.create(flashCard);
            }
          }
        }

      }
    }
  }
}
