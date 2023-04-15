part of '../ticket_voucher_details_page.dart';

class InfoPayment extends StatelessWidget {
  const InfoPayment({
    super.key,
    required this.value,
    required this.cardName,
    required this.cardNumber,
  });

  final String value;
  final String cardName;
  final String cardNumber;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColorsBase.genPurpleBackgroundColor,
        border: Border.all(
          color: AppColorsBase.genPurpleBackgroundColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(
          const Spacing(1).value,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ParkingLabels.ticketValue,
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: AppColorsBase.genPurpleColor,
                  ),
                ),
                Text(
                  value,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: AppColorsBase.genPurpleColor,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pagamento',
                  style: context.textTheme.headlineSmall?.copyWith(
                    color: AppColorsBase.genPurpleColor,
                  ),
                ),
                Text(
                  '$cardName $cardNumber',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: AppColorsBase.genPurpleColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
