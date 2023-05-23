import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlatAppBar extends StatelessWidget {
  final bool showBackButton;
  final bool showTitle;
  final bool showSubtitle;

  const FlatAppBar({
    super.key,
    this.showBackButton = true,
    this.showTitle = true,
    this.showSubtitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(255, 251, 245, 1),
      leading: showBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                // Navigate to previous screen.
              },
            )
          : Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 2),
              child: IconButton(
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.transparent,
                    size: 40,
                  ),
                  onPressed: () {})),
      title: showTitle
          ? Text(
              'EHKOW',
              style: GoogleFonts.vollkorn(
                  fontWeight: FontWeight.bold, color: Colors.black54),
            )
          : null,
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.0, top: 8),
          child: Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black54,
                width: 3.0,
              ),
            ),
            child: const CircleAvatar(
              child: Text('JS', style: TextStyle(color: Colors.black54)),
              backgroundColor: Color.fromRGBO(255, 251, 245, 1),
            ),
          ),
        ),
      ],
    );
  }
}
