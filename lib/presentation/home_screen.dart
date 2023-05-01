import 'package:ehkow/widgets/deck_chooser.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 251, 245, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 5 * 3,
              child: DeckChooser(),
            ),
          )
        ],
      ),
    );
  }
}
