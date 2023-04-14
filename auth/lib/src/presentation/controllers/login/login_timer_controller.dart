import 'dart:async';

import 'package:core/core.dart';


class LoginTimerController extends GenController<Exception, int> {
  LoginTimerController() : super(60);

  Timer? timer;
  late int counter;
  late bool showTimer;

  void startTimer() {
    counter = 60;
    showTimer = true;
    const oneSec = Duration(seconds: 1);
    if (timer != null) timer!.cancel();
    timer = Timer.periodic(oneSec, (t) {
      if (counter == 1) {
        timer?.cancel();
        showTimer = false;
      } else {
        counter -= 1;
      }
      update(state, force: true);
    });
    update(state, force: true);
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
