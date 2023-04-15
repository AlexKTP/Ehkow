import 'package:flutter/material.dart';

class RoundedCard extends StatelessWidget {
  const RoundedCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Call the function you want to execute here
        print('Card tapped');
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Container(
          height: MediaQuery.of(context).size.height/3,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
              colors: [Color.fromRGBO(151, 222, 255, 1), Colors.white],
            ),
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text('Deck Title', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 30),),
              Text('Description', style: TextStyle(color: Colors.black54),),
              Padding(padding: EdgeInsets.only(top: 30), child:
              Text('Last Update: 10 Feb. 2023', style: TextStyle(color: Colors.black87),),)
            ],
          ),
        ),
      ),
    );
  }
}


