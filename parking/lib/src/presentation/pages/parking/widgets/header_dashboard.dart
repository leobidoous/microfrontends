part of 'parking_page.dart';

class _HeaderDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.tr.titleParkingDashBoard,
          style: context.textTheme.titleLarge,
        ),
        Spacing.sm.vertical,
        Text(
          context.tr.subtitleParkingDashBoard,
          style: context.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
