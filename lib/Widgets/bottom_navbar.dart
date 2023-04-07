import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemTapped;

  const BottomNavBar(
      {super.key, required this.currentIndex, required this.onItemTapped});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30.0)),
      ),
      child: BottomNavigationBar(
          enableFeedback: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(Icons.search),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(Icons.add),
                ],
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Icon(Icons.favorite),
                ],
              ),
              label: '',
            ),
          ],
          selectedItemColor: Colors.lightBlue,
        ),
    );
  }
}