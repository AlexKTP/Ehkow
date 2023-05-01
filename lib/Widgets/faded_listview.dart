import 'package:ehkow/utils/ToastMessage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FadedListView extends StatelessWidget {
  final List<dynamic> _list;

  FadedListView(this._list);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Stack(
      children: [
        Center(
            child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.white, Colors.white.withOpacity(0.05)],
                    stops: [0.55, 1],
                    tileMode: TileMode.mirror,
                  ).createShader(bounds);
                },
                blendMode: BlendMode.dstIn,
                child: Center(
                  child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            Colors.white.withOpacity(0.05)
                          ],
                          stops: [0.55, 1],
                          tileMode: TileMode.mirror,
                        ).createShader(bounds);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            itemCount: _list.length,
                            itemBuilder: (context, index) => ListTile(
                              title: Text(
                                _list[index] as String,
                                style: GoogleFonts.bebasNeue(
                                    fontSize: 50.0, color: Colors.black87),
                              ),
                              onTap: () => goToFlashCards(index),
                            ),
                            scrollDirection: Axis.vertical,
                          ))),
                ))),
      ],
    ));
  }

  goToFlashCards(int index) {
    ToastMessage.success(_list[index] as String);
  }
}
