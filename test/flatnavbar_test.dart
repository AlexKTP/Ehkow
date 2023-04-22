import 'package:ehkow/Widgets/flat_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('flatnavbar_hasToShowTitleAndMenuIcon', (WidgetTester tester) async {
    await tester.pumpWidget(MediaQuery(data: MediaQueryData(), child: MaterialApp(home: FlatAppBar(showBackButton: false, showTitle: true, showSubtitle: true,))));
    expect(find.text('EHKOW'), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.menu), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.arrow_back), findsNothing);
  });

  testWidgets('flatnavbar_hasToShowTitleAndArrowBackIcon', (WidgetTester tester) async {
    await tester.pumpWidget(MediaQuery(data: MediaQueryData(), child: MaterialApp(home: FlatAppBar(showBackButton: true, showTitle: true, showSubtitle: true,))));
    expect(find.text('EHKOW'), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.arrow_back), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.menu), findsNothing);
  });

  testWidgets('flatnavbar_hasToNotShowingTitleAndArrowBackIcon', (WidgetTester tester) async {
    await tester.pumpWidget(MediaQuery(data: MediaQueryData(), child: MaterialApp(home: FlatAppBar(showBackButton: true, showTitle: false, showSubtitle: true,))));
    expect(find.text('EHKOW'), findsNothing);
    expect(find.widgetWithIcon(IconButton, Icons.arrow_back), findsOneWidget);
    expect(find.widgetWithIcon(IconButton, Icons.menu), findsNothing);
  });

  testWidgets('flatnavbar_hasToShowCircleAvatar', (WidgetTester tester) async {
    await tester.pumpWidget(MediaQuery(data: MediaQueryData(), child: MaterialApp(home: FlatAppBar(showBackButton: true, showTitle: false, showSubtitle: true,))));
    expect(find.byType(CircleAvatar), findsOneWidget);
  });
}
