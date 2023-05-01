import 'package:ehkow/business/constants/constants.dart';
import 'package:ehkow/business/data/deck_repository.dart';
import 'package:ehkow/business/model/deck.dart';
import 'package:ehkow/widgets/faded_listview.dart';
import 'package:flutter/material.dart';

class DeckChooser extends StatelessWidget {
  late final List<dynamic> _list;

  DeckChooser();

  @override
  Widget build(BuildContext context) {
    initList();
    fetchDecks();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [FadedListView(_list)],
    );
  }

  void initList() {
    _list = [];
    _list.add(Constants.create_deck.toUpperCase());
  }

  Future<List<Deck>> fetchDecks() async {
    DeckRepository deckRepository = DeckRepository();
    List<Deck> result = await deckRepository.getAll();
    if(result.isNotEmpty) _list.addAll(result);
    return result;
  }
}
