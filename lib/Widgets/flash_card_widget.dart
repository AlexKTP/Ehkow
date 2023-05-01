import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business/bloc/flashcard_bloc.dart';

class FlashCardWidget extends StatefulWidget {
  final int flashCardId;
  final double? height;
  final double? width;

  FlashCardWidget(this.flashCardId, this.height, this.width);

  @override
  _FlashCardWidgetState createState() => _FlashCardWidgetState();
}

class _FlashCardWidgetState extends State<FlashCardWidget> {
  bool _isTranslated = false;

  @override
  Widget build(BuildContext context) {
    final flashCardBloc = BlocProvider.of<FlashCardBloc>(context);
    return BlocBuilder<FlashCardBloc, FlashCardState>(
      bloc: flashCardBloc,
      builder: (context, state) {
        if (state is FlashCardLoadingState) {
          return Center(
            child: Text('Loading...'),
          );
        }
        if (state is FlashCardErrorState) {
          return Center(
            child: Text(state.errorMessage.toString()),
          );
        }

        if (state is FlashCardSuccessState) {
          return Container(
              height: widget.height,
              width: widget.width,
              child: InkWell(
                onTap: _toggleTranslation,
                child: Column(
                  children: [
                    SizedBox(
                      height: widget.height,
                      width: widget.width,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                          side: const BorderSide(
                            color: Colors.black87,
                            width: 5.0,
                          ),
                        ),
                        color: Colors.transparent,
                        elevation: 0,
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            _isTranslated
                                ? state.flashCard.translatedContent.toString()
                                : state.flashCard.originalContent.toString(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ));
        }
        return Container();
      },
    );
  }

  void _toggleTranslation() {
    setState(() {
      _isTranslated = !_isTranslated;
    });
  }
}
