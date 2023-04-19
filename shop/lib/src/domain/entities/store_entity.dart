import 'delivery_options_entity.dart';
import 'store_address_entity.dart';
import 'store_brand_entity.dart';
import 'store_category_entity.dart';
import 'store_mall_entity.dart';
import 'store_preferences_entity.dart';

class StoreEntity {
  final int averageTime;
  final String callNumber;
  final List<DeliveryOptionsEntity> deliveryOptions;
  final String description;
  final String displayName;
  final String fee;
  final String id;
  final bool isVisible;
  final String logo;
  final String mainSegment;
  final List<dynamic> openingHours;
  final bool outOfHours;
  final StoreAddressEntity pointOfSale;
  final String relevance;
  final StoreBrandEntity storeBrand;
  final StoreCategoryEntity storeCategory;
  final StoreMallEntity storeMall;
  final StorePreferencesEntity storePreferences;
  final List<dynamic> tags;
  final Map<String, dynamic> themeColors;
  final String whatsappConfirmedAt; //TODO: Convert to DateTime
  final String whatsappNumber;

  StoreEntity({
    required this.averageTime,
    required this.callNumber,
    required this.deliveryOptions,
    required this.description,
    required this.displayName,
    required this.fee,
    required this.id,
    required this.isVisible,
    required this.logo,
    required this.mainSegment,
    required this.openingHours,
    required this.outOfHours,
    required this.pointOfSale,
    required this.relevance,
    required this.storeBrand,
    required this.storeCategory,
    required this.storeMall,
    required this.storePreferences,
    required this.tags,
    required this.themeColors,
    required this.whatsappConfirmedAt,
    required this.whatsappNumber,
  });
}
