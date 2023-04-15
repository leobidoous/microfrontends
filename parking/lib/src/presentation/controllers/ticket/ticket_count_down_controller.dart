import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/foundation.dart';

class TimerData {
  const TimerData({required this.timer, required this.percent});
  final DateTime timer;
  final double percent;
}

class TicketCountDownController extends GenController<Exception, TimerData> {
  TicketCountDownController()
      : super(TimerData(timer: DateTime(0), percent: 0.0));

  Timer? listenerTimer;
  final countValue = const Duration(seconds: 1);

  Future<void> showTolerenceProgress({required DateTime entryTime}) async {
    var lastTime = entryTime.add(const Duration(minutes: 15));
    var currentTime = lastTime.difference(DateTime.now());

    var time = changeTimer(currentTime);
    int currentSeconds = 0;

    listenerTimer = Timer.periodic(
      countValue,
      (value) {
        if (time.minute == 0 && time.second == 0) {
          value.cancel();
          return;
        }
        time = time.subtract(countValue);
        currentSeconds++;

        update(
          TimerData(
            timer: time,
            percent: changePercent(
              currentSecond: currentTime.inSeconds - currentSeconds,
              fullSeconds: 900,
            ),
          ),
          force: true,
        );
      },
    );
  }

  Future<void> showOpenProgress({required DateTime entryTime}) async {
    var currentTime = DateTime.now().difference(entryTime);
    var time = changeTimer(currentTime);

    listenerTimer = Timer.periodic(
      countValue,
      (_) {
        currentTime = DateTime.now().difference(entryTime);
        time = changeTimer(currentTime);

        update(
          TimerData(
            timer: time,
            percent: 0.0,
          ),
          force: true,
        );
      },
    );
  }

  Future<void> showPaidProgress({
    required DateTime stayLimit,
    required DateTime paymentDate,
  }) async {
    final fullSeconds = stayLimit.difference(paymentDate).inSeconds;
    var timeLeft = stayLimit.difference(DateTime.now());

    var time = changeTimer(timeLeft);

    listenerTimer = Timer.periodic(
      countValue,
      (_) {
        if (time.hour == 0 && time.minute == 0 && time.second == 0) {
          listenerTimer!.cancel();
          return;
        }
        time = time.subtract(countValue);
        update(
          TimerData(
            timer: time,
            percent: changePercent(
              fullSeconds: fullSeconds,
              currentSecond: stayLimit.difference(DateTime.now()).inSeconds,
            ),
          ),
          force: true,
        );
      },
    );
  }

  Future<void> showExpiredProgress({required DateTime stayLimit}) async {
    debugPrint(
      DateFormat.toDateTime(
        stayLimit,
        pattern: 'HH:mm:ss',
      ),
    );
    var currentTime = DateTime.now().difference(stayLimit);
    var time = changeTimer(currentTime);

    listenerTimer = Timer.periodic(
      countValue,
      (_) {
        currentTime = DateTime.now().difference(stayLimit);
        time = changeTimer(currentTime);

        update(
          TimerData(
            timer: time,
            percent: 1.0,
          ),
          force: true,
        );
      },
    );
  }
}

DateTime changeTimer(Duration duration) {
  return DateTime(
    0,
    0,
    0,
    duration.inSeconds ~/ 3600,
    (duration.inSeconds % 3600) ~/ 60,
    duration.inSeconds % 60,
  );
}

double changePercent({
  required int fullSeconds,
  required int currentSecond,
}) {
  return (((currentSecond * 100) / fullSeconds) / 100).toPrecision(2);
}
