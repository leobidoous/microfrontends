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
        color: AppColorsBase.kContainerColor,
        borderRadius: BorderRadius.circular(
          const Spacing(1).value,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(const Spacing(2.5).value),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Tr.of(context).ticketValue,
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
                Text(
                  value,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pagamento',
                  style: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
                Text(
                  '$cardName $cardNumber',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.primary,
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
