import 'package:ehkow/business/bloc/deck_list_bloc.dart';
import 'package:ehkow/business/services/deck_service.dart';
import 'package:ehkow/widgets/deck_chooser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              child: BlocProvider<DeckListBloc>(
                create: (BuildContext context) => DeckListBloc(DeckService()),
                child: DeckChooser(),
              )
            ),
          )
        ],
      ),
    );
  }
}
