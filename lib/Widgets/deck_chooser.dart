import 'package:ehkow/business/bloc/deck_list_bloc.dart';
import 'package:ehkow/business/constants/constants.dart';
import 'package:ehkow/business/model/deck.dart';
import 'package:ehkow/widgets/faded_listview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeckChooser extends StatelessWidget {
  final List<Deck> _list = [];

  DeckChooser();

  @override
  Widget build(BuildContext context) {
    final deckListBloc = BlocProvider.of<DeckListBloc>(context);
    deckListBloc.add(FetchDecksEvent());
        if (deckListBloc.state is DecksLoadingState) {
          return Center(
            child: Text('Loading...'),
          );
        }
        if (deckListBloc.state is DecksErrorState) {
          return Center(
            child: Text((deckListBloc.state as DecksErrorState).errorMessage.toString()),
          );
        }
        if (deckListBloc.state is DecksSuccessState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [FadedListView(_addAllDecks((deckListBloc.state as DecksSuccessState).deckList))],
          );
        }
        return Container();
  }

  List<Deck> _addAllDecks(List<Deck> deckList) {
    _list.add(Deck(name: Constants.create_deck));
    _list.addAll(deckList);
    return _list;
  }
}
