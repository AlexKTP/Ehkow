import 'dart:async';
import 'package:ehkow/Widgets/RoundedCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import '../Widgets/FlatAppBar.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Timer(const Duration(seconds: 1), ()=>FlutterNativeSplash.remove());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ehkow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true).copyWith(
          primaryColor: const Color.fromRGBO(74, 78, 105, 1)
      ),
      home: const MyHomePage(title: 'EHKOW'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //int cardDisplayed = 0;

  @override
  void initState() {
   // changeCard();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromRGBO(74, 78, 105, 1),
      appBar:const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: FlatAppBar(showTitle: true, showBackButton: false, showSubtitle: true,),
      ),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Padding(
            padding: EdgeInsets.all(16),
            child: RoundedCard(),
          )
        ],
      )
    );
  }
}
