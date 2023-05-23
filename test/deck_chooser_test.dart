
import 'package:ehkow/business/bloc/deck_list_bloc.dart';
import 'package:ehkow/business/constants/constants.dart';
import 'package:ehkow/business/model/deck.dart';
import 'package:ehkow/business/model/status.dart';
import 'package:ehkow/business/services/deck_service.dart';
import 'package:ehkow/widgets/deck_chooser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'deck_chooser_test.mocks.dart';

@GenerateNiceMocks([MockSpec<DeckService>()])
void main(){

  final mockDeckService = MockDeckService();

  Widget _buildTestableWidget({required DeckListBloc deckListBloc}) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<DeckListBloc>(
          create: (context) => deckListBloc,
          child: DeckChooser(),
        ),
      ),
    );
  }

  testWidgets('DeckChooser shows Loading when in LoadingState',
          (WidgetTester tester) async {
        final bloc = DeckListBloc(mockDeckService);
        when(mockDeckService.getDeckList())
            .thenAnswer((_) async => Future(() => []));
        bloc.add(FetchDecksEvent());

        await tester.pumpWidget(_buildTestableWidget(deckListBloc: bloc));
        await tester.pump();

        expect(find.text('Loading...'), findsOneWidget);
        await tester.pumpAndSettle();
      });

  testWidgets('DeckChooser shows error message when in DecksErrorState', (WidgetTester tester) async {
    final bloc = DeckListBloc(mockDeckService);
    final errorMessage = Constants.basic_error;
    when(mockDeckService.getDeckList()).thenAnswer((_) async => throw Exception(errorMessage));
    bloc.add(FetchDecksEvent());
    bloc.emit(DecksErrorState(errorMessage: errorMessage)); // Manually emit the error state

    await tester.pumpWidget(_buildTestableWidget(deckListBloc: bloc));
    await tester.pumpAndSettle(); // Add this line

    expect(find.byType(Text), findsOneWidget);
    expect(find.textContaining(errorMessage), findsOneWidget);
  });

  testWidgets('DeckChooser shows DeckList when in DecksSuccessState', (WidgetTester tester) async {
    final deck = Deck(id: 1, name: 'DeckTest', toSynchronize: Status.NONE);
    final bloc = DeckListBloc(mockDeckService);
    List<Deck> deckList = [];
    deckList.add(deck);
    when(mockDeckService.getDeckList()).thenAnswer((_) async => deckList);
    bloc.add(FetchDecksEvent());
    bloc.emit(DecksSuccessState(deckList: deckList));

    await tester.pumpWidget(_buildTestableWidget(deckListBloc: bloc));
    await tester.pumpAndSettle();

    expect(find.text(deck.name), findsOneWidget);
  });


}