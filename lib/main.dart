import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flash_card_flutter/business/data/DatabaseHelper.dart';
import 'package:flash_card_flutter/business/data/DeckRepository.dart';
import 'package:flash_card_flutter/business/data/FlashCardRepository.dart';
import 'package:flash_card_flutter/business/model/Deck.dart';
import 'package:flash_card_flutter/business/model/FlashCard.dart';
import 'package:flash_card_flutter/presentation/CardWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Timer(const Duration(seconds: 1), ()=>FlutterNativeSplash.remove());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'WIZLET'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int cardDisplayed = 0;

  @override
  void initState() {
    changeCard();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
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
                  onPressed: () async => importFile()),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  void changeCard() async {
    final random = Random();
    FlashCardRepository flashCardRepository = FlashCardRepository(DatabaseHelper());
    var rows = await  flashCardRepository.rowCount();
      if (rows != null && rows > 0) {
        setState(() {cardDisplayed = random.nextInt(rows);});
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
}}
