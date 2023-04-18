part of '../../ticket_tracking/ticket_tracking_page.dart';

class _CircularIndicatorTimer extends StatefulWidget {
  const _CircularIndicatorTimer({
    required this.entity,
  });

  final TicketEntity entity;

  @override
  _CircularIndicatorTimerState createState() => _CircularIndicatorTimerState();
}

class _CircularIndicatorTimerState extends State<_CircularIndicatorTimer> {
  final countDownController = DM.i.get<TicketCountDownController>();
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startCount();
  }

  @override
  void dispose() {
    countDownController.listenerTimer!.cancel();
    countDownController.dispose();
    super.dispose();
  }

  void startCount() {
    switch (TicketStatusEnum.values[widget.entity.status.code]) {
      case TicketStatusEnum.inTolerance:
        countDownController.showTolerenceProgress(
          entryTime: widget.entity.entradaDatahora,
        );
        break;
      case TicketStatusEnum.open:
        countDownController.showOpenProgress(
          entryTime: widget.entity.entradaDatahora,
        );
        break;
      case TicketStatusEnum.paid:
        countDownController.showPaidProgress(
          stayLimit: widget.entity.tempoLimitePermanencia,
          paymentDate: widget.entity.transacaoValidadeDatahora,
        );
        break;
      case TicketStatusEnum.exceeded:
        countDownController.showExpiredProgress(
          stayLimit: widget.entity.validadeDatahora,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TimerData>(
      valueListenable: countDownController,
      builder: (context, state, child) {
        return RepaintBoundary(
          child: TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0.0, end: state.percent),
            curve: Curves.easeOut,
            duration: const Duration(seconds: 2),
            builder: (context, value, _) => CircularPercentIndicator(
              backgroundColor: progressBackgroundColor(
                type: TicketStatusEnum.values[widget.entity.status.code],
              ),
              radius: 80.0,
              lineWidth: 10.0,
              percent: value,
              circularStrokeCap: CircularStrokeCap.round,
              center: Text(
                DateFormat.toDateTime(
                  state.timer,
                  pattern: 'HH:mm:ss',
                ),
                style: context.textTheme.headlineSmall,
              ),
              progressColor: progressColor(
                type: TicketStatusEnum.values[widget.entity.status.code],
              ),
            ),
          ),
        );
      },
    );
  }
}

Color progressBackgroundColor({required TicketStatusEnum type}) {
  switch (type) {
    case TicketStatusEnum.open:
      return Colors.transparent;
    default:
      return AppColorsBase.grey3;
  }
}

Color progressColor({required TicketStatusEnum type}) {
  switch (type) {
    case TicketStatusEnum.inTolerance:
      return AppColorsBase.success1;
    case TicketStatusEnum.open:
      return Colors.green;
    case TicketStatusEnum.paid:
      return AppColorsBase.success1;
    case TicketStatusEnum.exceeded:
      return AppColorsBase.error2;
    default:
      return Colors.transparent;
  }
}

String textTimer(Duration duration) {
  return '${duration.inHours.remainder(24).toString().padLeft(2, '0')}:'
      '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:'
      '${(duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}';
}
