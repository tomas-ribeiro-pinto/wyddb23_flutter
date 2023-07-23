import 'package:flutter/material.dart';
import 'package:wyddb23_flutter/Stories/util/progress_bar.dart';

class MyStoryBars extends StatelessWidget {
  List<double> percentWatched = [];
  int topicLength;
  Color color;

  MyStoryBars({required this.percentWatched, required this.topicLength, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          for(var i = 0; i < topicLength; i++)...
          {
            Expanded(
              child: MyProgressBar(percentWatched: percentWatched[i], color: color,),
            ),
          }
        ],
      ),
    );
  }
}
