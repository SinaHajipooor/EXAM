import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key});
  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  // ---------------- state ------------------
  Timer? _timer;
  int _startSeconds = 90;
  int _elapsedSeconds = 0;
  // ---------------- lifecycle ------------------
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  // ---------------- methods ------------------
  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_startSeconds <= 0) {
          _timer!.cancel();
        } else {
          _startSeconds = _startSeconds - 1;
          _elapsedSeconds = _elapsedSeconds + 1;
        }
      });
    });
  }

  // ---------------- UI ------------------
  @override
  Widget build(BuildContext context) {
    final remainingDuration = Duration(seconds: _startSeconds);
    final remaining = '${remainingDuration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${remainingDuration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 16.0),
        Text('زمان باقی مانده : $remaining', style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600)),
      ],
    );
  }
}
