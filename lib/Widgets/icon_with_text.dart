import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IconWithText extends StatelessWidget {
  late final String textToDisplay;
  late final Icon icon;

  IconWithText({Key? key, required this.textToDisplay, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(textToDisplay,
                  style: GoogleFonts.robotoCondensed(
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                      fontSize: 15)),
            )
          ],
        ));
  }
}
