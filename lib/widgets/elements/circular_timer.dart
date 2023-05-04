import 'dart:async';

import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class CircularTimer extends StatelessWidget {
  final int remainingTime;
  CircularTimer(this.remainingTime);

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      duration: remainingTime,
      width: 60,
      height: 60,
      ringColor: Colors.blue,
      fillColor: Colors.grey.shade200,
      strokeWidth: 8.0,
      strokeCap: StrokeCap.round,
      isReverse: true,
      onComplete: () {
        //TODO: add code to perform actions when the time is up
      },
      textStyle: const TextStyle(fontSize: 15.0, color: Colors.black),
    );
  }
}
