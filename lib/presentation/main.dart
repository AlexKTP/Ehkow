import 'dart:async';

import 'package:ehkow/Widgets/rounded_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:scroll_indicator/scroll_indicator.dart';

import '../Widgets/flat_app_bar.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Timer(const Duration(seconds: 1), () => FlutterNativeSplash.remove());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ehkow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true)
          .copyWith(primaryColor: const Color.fromRGBO(74, 78, 105, 1)),
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
  ScrollController scrollController = ScrollController();
  ScrollController scrollController2 = ScrollController();

  @override
  void initState() {
    // changeCard();
    scrollController = ScrollController();
    scrollController2 = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    scrollController2.dispose();
    super.dispose();
  }

  var _currentIndex = 0;

  int _selectedIndex = 0;

  final _listOfRoundedCard = [];

  final DateTime now = DateTime.now();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 10; i++) {
      _listOfRoundedCard.add(const RoundedCard());
    }
    Widget _listView = ListView.builder(
      itemCount: _listOfRoundedCard.length,
      itemBuilder: (context, index) {
        return Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width,
            child: RoundedCard());
      },
      scrollDirection: Axis.horizontal,
      controller: scrollController,
    );
    return Scaffold(
      backgroundColor: const Color.fromRGBO(74, 78, 105, 1),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(100),
        child: FlatAppBar(
          showTitle: true,
          showBackButton: false,
          showSubtitle: true,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _listView,
              )),
          ScrollIndicator(
            scrollController: scrollController,
            width: 50,
            height: 10,
            indicatorWidth: 20,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300]),
            indicatorDecoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(10)),
          ),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                  padding: const EdgeInsets.all(20),
                  child: HeatMap(
                    defaultColor: const Color.fromRGBO(209, 249, 255, 1),
                    textColor: Colors.white,
                    showColorTip: false,
                    datasets: {
                      DateTime(
                          now.month - 4 > 0 ? now.year : 12 + (now.month - 4),
                          1,
                          now.month - 4 > 0 ? now.month - 4 : 1): 3,
                      DateTime(
                          now.month - 3 > 0 ? now.year : 12 + (now.month - 3),
                          1,
                          now.month - 3 > 0 ? now.month - 3 : 1): 7,
                      DateTime(
                          now.month - 2 > 0 ? now.year : 12 + (now.month - 2),
                          1,
                          now.month - 2 > 0 ? now.month - 2 : 1): 10,
                      DateTime(
                          now.month - 1 > 0 ? now.year : 12 + (now.month - 1),
                          1,
                          now.month - 1 > 0 ? now.month - 1 : 1): 13,
                      DateTime(now.year, 1,
                          now.month - 0 > 0 ? now.month - 0 : 1): 6,
                    },
                    colorMode: ColorMode.opacity,
                    showText: false,
                    scrollable: true,
                    colorsets: const {
                      1: Colors.red,
                      3: Colors.orange,
                      5: Colors.yellow,
                      7: Colors.green,
                      9: Colors.blue,
                      11: Colors.indigo,
                      13: Colors.purple,
                    },
                    onClick: (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(value.toString())));
                    },
                  )),
            ],
          )),
          Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.local_fire_department_rounded,
                    size: 30,
                    color: Colors.redAccent,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(" 3 Week(s) in a row", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(209, 249, 255, 1), fontSize: 15),),
                  )
                ],
              ))
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [Color.fromRGBO(151, 222, 255, 1), Colors.white],
          ),
        ),
        child: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          items: [
            SalomonBottomBarItem(
                selectedColor: Colors.blueAccent,
                icon: const Icon(
                  Icons.search,
                  color: Colors.black54,
                ),
                title: const Text(
                  'search',
                  style: TextStyle(color: Colors.black54),
                )),
            SalomonBottomBarItem(
                selectedColor: Colors.greenAccent,
                icon: const Icon(
                  Icons.add,
                  color: Colors.black54,
                ),
                title: const Text(
                  'add',
                  style: TextStyle(color: Colors.black54),
                )),
            SalomonBottomBarItem(
                selectedColor: Colors.pinkAccent,
                icon: const Icon(
                  Icons.favorite,
                  color: Colors.black54,
                ),
                title: const Text(
                  'favorites',
                  style: TextStyle(color: Colors.black54),
                ))
          ],
        ),
      ),
    );
  }
}
