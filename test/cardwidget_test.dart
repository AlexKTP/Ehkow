
import 'package:ehkow/Widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets('cardwidget_hasToShowCardAndTextWrappedByGestureDetector', (WidgetTester tester) async {
    await tester.pumpWidget(Directionality(textDirection: TextDirection.ltr, child: CardWidget(1)));
    expect(find.byType(Card), findsOneWidget);
    expect(find.byType(Text), findsOneWidget);
    expect(find.byType(GestureDetector), findsOneWidget);
    expect(find.byType(Column), findsNothing);
  });
}