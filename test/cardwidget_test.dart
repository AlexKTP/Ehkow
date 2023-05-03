import 'package:ehkow/business/bloc/flashcard_bloc.dart';
import 'package:ehkow/business/constants/constants.dart';
import 'package:ehkow/business/model/exceptions/flashcard_not_found.dart';
import 'package:ehkow/business/model/flashcard.dart';
import 'package:ehkow/business/services/flashcard_service.dart';
import 'package:ehkow/widgets/flash_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cardwidget_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FlashCardService>()])
void main() {

  final mockFlashCardService = MockFlashCardService();

  Widget _buildTestableWidget({required FlashCardBloc flashCardBloc}) {
    return MaterialApp(
      home: Scaffold(
        body: BlocProvider<FlashCardBloc>(
          create: (context) => flashCardBloc,
          child: FlashCardWidget(1, 300, 300),
        ),
      ),
    );
  }

  testWidgets('FlashCardWidget shows Loading when in LoadingState',
      (WidgetTester tester) async {
    final bloc = FlashCardBloc(1, mockFlashCardService);
    when(mockFlashCardService.getFlashCard(1))
        .thenAnswer((_) async => throw Exception());
    bloc.add(FetchFlashCardEvent());

    await tester.pumpWidget(_buildTestableWidget(flashCardBloc: bloc));
    await tester.pump();

    expect(find.text('Loading...'), findsOneWidget);
  });

  testWidgets('FlashCardWidget shows error message when in FlashCardErrorState', (WidgetTester tester) async {
    final bloc = FlashCardBloc(1, mockFlashCardService);
    final errorMessage = Constants.flashcard_not_found;
    when(mockFlashCardService.getFlashCard(1)).thenAnswer((_) async => throw FlashCardNotFound(1));
    bloc.emit(FlashCardErrorState(errorMessage: errorMessage)); // Manually emit the error state
    bloc.add(FetchFlashCardEvent());

    await tester.pumpWidget(_buildTestableWidget(flashCardBloc: bloc));
    await tester.pumpAndSettle();

    expect(find.text(errorMessage), findsOneWidget);
  });

  testWidgets('FlashCardWidget shows FlashCard content when in FlashCardSuccessState', (WidgetTester tester) async {
    final flashCard = FlashCard(
      originalContent: 'originalContent',
      translatedContent: 'translatedContent',
      deckId: 1,
    );
    final bloc = FlashCardBloc(1, mockFlashCardService);
    when(mockFlashCardService.getFlashCard(1)).thenAnswer((_) async => flashCard);
    bloc.add(FetchFlashCardEvent());
    bloc.emit(FlashCardSuccessState(flashCard: flashCard)); // Manually emit the success state

    await tester.pumpWidget(_buildTestableWidget(flashCardBloc: bloc));
    await tester.pumpAndSettle(); // Ensure widget rebuilds after emitting state

    expect(find.text(flashCard.originalContent), findsOneWidget);

    // Tap on the widget to toggle translation
    await tester.tap(find.byType(InkWell));
    await tester.pumpAndSettle(); // Ensure widget rebuilds after tapping

    expect(find.text(flashCard.translatedContent), findsOneWidget);
  });

}
