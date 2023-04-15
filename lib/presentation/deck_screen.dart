import 'package:ehkow/Widgets/flat_app_bar.dart';
import 'package:flutter/material.dart';

class DeckScreen extends StatefulWidget {
  const DeckScreen({Key? key}) : super(key: key);

  @override
  State<DeckScreen> createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: FlatAppBar(showBackButton: true, showSubtitle: true, showTitle: true,),
      ),
      body: Text('DeckScreen'),
    );
  }
}
