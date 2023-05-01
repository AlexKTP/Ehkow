import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(255, 251, 245, 1),
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
    );
  }
}
