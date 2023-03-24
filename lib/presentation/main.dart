import 'dart:async';
import 'package:flash_card_flutter/Widgets/AppDrawer.dart';
import 'package:flash_card_flutter/Widgets/CustomAppBar.dart';
import 'package:flash_card_flutter/presentation/DeckScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

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
      title: 'Wizlet',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true).copyWith(
          primaryColor: const Color.fromRGBO(51, 102, 255,1)
      ),
      home: const MyHomePage(title: 'WIZLET'),
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
      appBar: CustomAppBar(title: "WIZLET", context: context, onBackEnable: false,),
      drawer: const AppDrawer(),
      body: Center(
        child: TextButton( child: const Text("Navigate"),onPressed: () {
      Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const DeckScreen()),
      );
      },
      ), // This trailing comma makes auto-formatting nicer for build methods.
    ));
  }
}
