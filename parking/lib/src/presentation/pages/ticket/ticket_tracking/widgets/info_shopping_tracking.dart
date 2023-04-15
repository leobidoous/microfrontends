part of '../ticket_tracking_page.dart';

class _InfoShoppingTracking extends StatelessWidget {
  const _InfoShoppingTracking({
    required this.imageMall,
    required this.mallName,
    required this.mallAddress,
  });

  final String imageMall;
  final String mallName;
  final String mallAddress;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColorsBase.grey2,
        border: Border.all(
          color: AppColorsBase.kPrimaryDarkShadow,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(
          const Spacing(1).value,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: const Spacing(1).value,
              horizontal: const Spacing(2).value,
            ),
            child: CachedNetworkImage(
              imageUrl: imageMall,
              placeholder: (context, url) => Shimmer(
                colorOpacity: 0.8,
                child: Material(
                  color: context.colorScheme.onBackground.withOpacity(
                    .26,
                  ),
                  child: SizedBox(
                    width: const Spacing(4).value,
                    height: const Spacing(3).value,
                  ),
                ),
              ),
              imageBuilder: (context, imageProvider) => Image(
                image: imageProvider,
                fit: BoxFit.fitWidth,
                height: const Spacing(6).value,
                width: const Spacing(3).value,
              ),
              errorWidget: (context, url, error) {
                printException(exception: error);
                return const LimitedBox();
              },
              fadeInDuration: const Duration(seconds: 2),
              placeholderFadeInDuration: const Duration(seconds: 2),
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mallName,
                  softWrap: true,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: AppColorsBase.grey6,
                  ),
                ),
                Text(
                  mallAddress,
                  softWrap: true,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w300,
                    color: AppColorsBase.grey8,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
