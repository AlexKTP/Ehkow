import 'package:flash_card_flutter/Widgets/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DeckScreen extends StatefulWidget {
  const DeckScreen({Key? key}) : super(key: key);

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: CustomAppBar(title: "DeckScreen", context: context, onBackEnable: true,),
      body: Text("DeckScreen"),
    );
  }
}
