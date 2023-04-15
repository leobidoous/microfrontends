part of '../vehicle_list_page.dart';

class _EmptyListVehicleWidget extends StatelessWidget {
  const _EmptyListVehicleWidget({Key? key, required this.onTapAddVehicle})
      : super(key: key);
  final VoidCallback onTapAddVehicle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: const Spacing(3).value,
        vertical: const Spacing(4).value,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: ParkingLabels.seeAllVehicles,
              style:
                  genTextTheme.headlineSmall!.copyWith(color: GenColors.gray),
            ),
          ),
          BasicTextButtonWidget(
            text: ParkingLabels.addVehicle,
            color: GenColors.primary,
            onPressed: onTapAddVehicle,
          ),
          Padding(
            padding: const EdgeInsets.only(top: GenMeasures.base * 10),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/images/vehicle_not_found.svg',
                    height: 100,
                    width: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: GenMeasures.base),
                    child: Text(
                      ParkingLabels.notFoundVehicles,
                      style: genTextTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
