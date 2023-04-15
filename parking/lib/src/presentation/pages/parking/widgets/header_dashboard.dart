part of '../parking_page.dart';

class _HeaderDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          Tr.of(context).titleParkingDashBoard,
          style: context.textTheme.titleLarge,
        ),
        Spacing.sm.vertical,
        Text(
          Tr.of(context).subtitleParkingDashBoard,
          style: context.textTheme.bodyMedium,
        ),
      ],
    );
  }
}
