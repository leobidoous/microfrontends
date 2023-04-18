part of '../vehicles_page.dart';

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
          Text(
            Tr.of(context).seeAllVehicle,
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w300,
              color: AppColorsBase.greyText02,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: const Spacing(1).value),
            child: InkWell(
              highlightColor: context.colorScheme.primary.withOpacity(
                .16,
              ),
              borderRadius: AppThemeBase.borderRadiusSM,
              onTap: onTapAddVehicle,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: const Spacing(1).value,
                  horizontal: const Spacing(1).value,
                ),
                child: Text(
                  Tr.of(context).addVehicle,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: const Spacing(20).value),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    CustomAssets.vehicleNotFound,
                    height: 100,
                    width: 100,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: const Spacing(2).value),
                    child: Text(
                      Tr.of(context).notFoundVehicles,
                      style: context.textTheme.titleMedium,
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
