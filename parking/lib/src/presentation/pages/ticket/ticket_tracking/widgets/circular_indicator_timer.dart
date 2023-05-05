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
        if (widget.entity.historys != null &&
            widget.entity.historys!.isNotEmpty) {
          countDownController.showPaidProgress(
            stayLimit: widget.entity.historys!.first.saidaAte,
            paymentDate: widget.entity.historys!.first.pagoEm,
          );
        } else {
          countDownController.showOpenProgress(
            entryTime: widget.entity.entradaDatahora,
          );
        }

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
        return Column(
          children: [
            RepaintBoundary(
              child: TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: state.percent),
                curve: Curves.easeOut,
                duration: const Duration(seconds: 2),
                builder: (context, value, _) => CircularPercentIndicator(
                  backgroundColor: progressBackgroundColor(
                    type: (widget.entity.historys != null &&
                            widget.entity.historys!.isNotEmpty)
                        ? TicketStatusEnum.values[widget.entity.status.code]
                        : TicketStatusEnum.open,
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
            ),
            Spacing.xs.vertical,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Status: ',
                  style: context.textTheme.titleMedium,
                ),
                Spacing.xs.vertical,
                Text(
                  widget.entity.status.status.capitalize,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: context.textTheme.fontWeightMedium,
                    color: statusTicketColor(widget.entity.status.code),
                  ),
                ),
              ],
            ),
            Spacing.xs.vertical,
            textCircularIndicator(widget.entity.status.code)
          ],
        );
      },
    );
  }

  Widget textCircularIndicator(int code) {
    switch (code) {
      case 0:
        return Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Tr.of(context).exitLimited,
                style: context.textTheme.headlineSmall!.copyWith(fontSize: 18),
              ),
              Text(
                DateFormat.toTime(
                  widget.entity.validadeDatahora,
                  pattern: 'HH:mm',
                ),
                style: context.textTheme.headlineSmall!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      case 1:
        return Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${Tr.of(context).estimatedValue}: ',
                style: context.textTheme.headlineSmall!.copyWith(fontSize: 18),
              ),
              Text(
                'R\$ ${NumberFormat.toCurrency(
                  widget.entity.valorTotal,
                  symbol: '',
                )}',
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      case 2:
        return Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Tr.of(context).exitLimited,
                style: context.textTheme.headlineSmall!.copyWith(
                  fontSize: 18,
                ),
              ),
              Text(
                DateFormat.toTime(
                  widget.entity.validadeDatahora,
                ),
                style: context.textTheme.headlineSmall!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      case 3:
        return Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Tr.of(context).outputLimitExceeded,
                style: context.textTheme.headlineSmall!.copyWith(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        );
      default:
        return Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Tr.of(context).exitLimited,
                style: context.textTheme.headlineSmall!.copyWith(
                  fontSize: 18,
                ),
              ),
              Text(
                DateFormat.toTime(
                  widget.entity.validadeDatahora,
                  pattern: 'HH:mm',
                ),
                style: context.textTheme.headlineSmall!.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
    }
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
