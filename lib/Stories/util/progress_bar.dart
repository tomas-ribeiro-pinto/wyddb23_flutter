import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MyProgressBar extends StatelessWidget {
  double percentWatched = 0;
  Color color;

  MyProgressBar({required this.percentWatched, required this.color});

  @override
  Widget build(BuildContext context) {
    return LinearPercentIndicator(
      lineHeight: 8,
      percent: percentWatched,
      progressColor: color,
      backgroundColor: Colors.grey[600],
    );
  }
}
