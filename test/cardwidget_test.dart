import 'package:ehkow/Widgets/flash_card_widget.dart';
import 'package:ehkow/business/data/flashcard_repository.dart';
import 'package:ehkow/business/model/flashcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cardwidget_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlashCardRepository>()])
void main() {

  late FlashCardRepository mockRepo;
  late FlashCardWidget widget;

  testWidgets('flashcardwidget_textChangeWhenUserTap',
      (WidgetTester tester) async {
    mockRepo = MockFlashCardRepository();
    FlashCard flashCard = FlashCard(
        originalContent: 'originalContent',
        translatedContent: 'translatedContent',
        deckId: 1);
    when(mockRepo.findById(1))
        .thenAnswer((Invocation) => Future(() => flashCard));
    widget = FlashCardWidget(1, mockRepo);

    // instanciate the widget
    await tester.pumpWidget(
        Directionality(textDirection: TextDirection.ltr, child: widget));

    //This will ensure that all asynchronous operations,
    // including any active timers,
    // have completed before the test finishes.
    await tester.pumpAndSettle();
    expect(find.byType(Text), findsOneWidget);
    expect(find.text('originalContent'), findsOneWidget);
    expect(find.text('translatedContent'), findsNothing);

    // Find the card and simulate a tap
    final buttonFinder = find.byType(GestureDetector);
    expect(buttonFinder, findsOneWidget);
    await tester.tap(buttonFinder);

    // again we have to call this method to ensure that
    // all async functions have completed
    await tester.pumpAndSettle();

    // Test if the card has really flop
    expect(find.byType(Text), findsOneWidget);
    expect(find.text('originalContent'), findsNothing);
    expect(find.text('translatedContent'), findsOneWidget);
    await tester.pumpAndSettle();
  });

  testWidgets('flashcardwidget_noFlashCardFound',  (WidgetTester tester) async {
    // instanciate the widget
    await tester.pumpWidget(
        Directionality(textDirection: TextDirection.ltr, child: FlashCardWidget(-1, FlashCardRepository())));

    await tester.pumpAndSettle();

    expect(find.byType(Text), findsOneWidget);
    expect(find.text('Une erreur a eu lieu'), findsOneWidget);
  });
}
