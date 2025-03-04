import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kobo_kobo/functional_util/functional_utils.dart';

mixin OtpTimeoutMixin<T extends StatefulWidget> on State<T> {
  int timeoutMinutes = 1;
  int timeoutSeconds = 60;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    startTimer();
    Log().debug('the timer initState on $timeoutMinutes');
  }

  void startTimer() {
    timer?.cancel();
    Log().debug('the timer startTimer on ${timer?.isActive}');

    timeoutMinutes--;
    timer = Timer.periodic(1.seconds, (timer) {
      if (timeoutMinutes == 0 && timeoutSeconds == 0) {
        Log().debug('the timer started on $timeoutMinutes');
        timer.cancel();
      } else {
        setState(() {
          timeoutSeconds--;
          if (timeoutSeconds == 0 && timeoutMinutes > 0) {
            timeoutSeconds = 60;
            timeoutMinutes--;
            Log().debug(
              'the timer is reading on $timeoutMinutes',
              timeoutSeconds,
            );
          }
        });
      }
    });
  }

  void resetTimer(int resendInMin) {
    setState(() {
      timeoutSeconds = 60;
      timeoutMinutes = resendInMin;
    });
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    Log().debug('the timer dispose on ${timer?.isActive}');
    super.dispose();
  }

  bool get isTimerRunning => timeoutMinutes > 0 && timeoutSeconds > 0;

  bool get isTimerExpired => timeoutMinutes == 0 && timeoutSeconds == 0;

  String getCurrentOtpTimeoutCount({required bool isTimerExpired}) =>
      "${isTimerExpired ? '0:0' : '${timeoutMinutes.toString().padLeft(2, "0")}:${timeoutSeconds.toString().padLeft(2, "0")}'} ";
}
