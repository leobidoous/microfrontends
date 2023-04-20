import 'dart:convert';

import 'package:core/core.dart';

import '../../domain/entities/delivery_options_entity.dart';
import '../../domain/entities/store_address_entity.dart';
import '../../domain/entities/store_brand_entity.dart';
import '../../domain/entities/store_category_entity.dart';
import '../../domain/entities/store_entity.dart';
import '../../domain/entities/store_mall_entity.dart';
import '../../domain/entities/store_preferences_entity.dart';
import 'delivery_options_model.dart';
import 'store_address_model.dart';
import 'store_brand_model.dart';
import 'store_category_model.dart';
import 'store_mall_model.dart';
import 'store_preferences_model.dart';

class StoreModel extends StoreEntity with EquatableMixin {
  StoreModel({
    required super.averageTime,
    required super.callNumber,
    required super.deliveryOptions,
    required super.description,
    required super.displayName,
    required super.fee,
    required super.id,
    required super.isVisible,
    required super.logo,
    required super.mainSegment,
    required super.openingHours,
    required super.outOfHours,
    required super.pointOfSale,
    required super.relevance,
    required super.storeBrand,
    required super.storeCategory,
    required super.storeMall,
    required super.storePreferences,
    required super.tags,
    required super.themeColors,
    required super.whatsappConfirmedAt,
    required super.whatsappNumber,
  });

  factory StoreModel.fromMap(Map<String, dynamic> map) {
    return StoreModel(
      averageTime: map['averageTime'] ?? 0,
      callNumber: map['callNumber'] ?? '',
      deliveryOptions: (map['deliveryOptions'] as List<dynamic>)
          .map(
            (e) => DeliveryOptionsModel.fromMap(
              Map<String, dynamic>.from(map['deliveryOptions '] ?? {}),
            ),
          )
          .toList(),
      description: map['description'] ?? '',
      displayName: map['displayName'] ?? '',
      fee: map['fee'] ?? '',
      id: map['id'] ?? '',
      isVisible: map['isVisible'] ?? false,
      logo: map['logo'] ?? '',
      mainSegment: map['mainSegment'] ?? '',
      openingHours: map['openingHours'] ?? <Map<String, dynamic>>[],
      outOfHours: map['outOfHours'] ?? false,
      pointOfSale: StoreAddressModel.fromMap(
        Map<String, dynamic>.from(map['pointOfSale'] ?? {}),
      ),
      relevance: map['relevance'] ?? '',
      storeBrand: StoreBrandModel.fromMap(
        Map<String, dynamic>.from(map['storeBrand'] ?? {}),
      ),
      storeCategory: StoreCategoryModel.fromMap(
        Map<String, dynamic>.from(map['storeCategory'] ?? {}),
      ),
      storeMall: StoreMallModel.fromMap(
        Map<String, dynamic>.from(map['storeMall'] ?? {}),
      ),
      storePreferences: StorePreferencesModel.fromMap(
        Map<String, dynamic>.from(map['storePreferences'] ?? {}),
      ),
      tags: map['tags'] ?? <String>[],
      themeColors: map['themeColors'] ?? {},
      whatsappConfirmedAt:
          DateFormat.tryParseOrDateNow(map['whatsappConfirmedAt'])
              .toIso8601String(),
      whatsappNumber: map['whatsappNumber'] ?? '',
    );
  }

  factory StoreModel.fromEntity(StoreEntity entity) {
    return StoreModel(
      averageTime: entity.averageTime,
      callNumber: entity.callNumber,
      deliveryOptions: entity.deliveryOptions,
      description: entity.description,
      displayName: entity.displayName,
      fee: entity.fee,
      id: entity.id,
      isVisible: entity.isVisible,
      logo: entity.logo,
      mainSegment: entity.mainSegment,
      openingHours: entity.openingHours,
      outOfHours: entity.outOfHours,
      pointOfSale: entity.pointOfSale,
      relevance: entity.relevance,
      storeBrand: entity.storeBrand,
      storeCategory: entity.storeCategory,
      storeMall: entity.storeMall,
      storePreferences: entity.storePreferences,
      tags: entity.tags,
      themeColors: entity.themeColors,
      whatsappConfirmedAt: entity.whatsappConfirmedAt,
      whatsappNumber: entity.whatsappNumber,
    );
  }

  StoreModel copyWith({
    int? averageTime,
    String? callNumber,
    List<DeliveryOptionsEntity>? deliveryOptions,
    String? description,
    String? displayName,
    String? fee,
    String? id,
    bool? isVisible,
    String? logo,
    String? mainSegment,
    List<dynamic>? openingHours,
    bool? outOfHours,
    StoreAddressEntity? pointOfSale,
    String? relevance,
    StoreBrandEntity? storeBrand,
    StoreCategoryEntity? storeCategory,
    StoreMallEntity? storeMall,
    StorePreferencesEntity? storePreferences,
    List<dynamic>? tags,
    Map<String, dynamic>? themeColors,
    String? whatsappConfirmedAt,
    String? whatsappNumber,
  }) =>
      StoreModel(
        averageTime: averageTime ?? this.averageTime,
        callNumber: callNumber ?? this.callNumber,
        deliveryOptions: deliveryOptions ?? this.deliveryOptions,
        description: description ?? this.description,
        displayName: displayName ?? this.displayName,
        fee: fee ?? this.fee,
        id: id ?? this.id,
        isVisible: isVisible ?? this.isVisible,
        logo: logo ?? this.logo,
        mainSegment: mainSegment ?? this.mainSegment,
        openingHours: openingHours ?? this.openingHours,
        outOfHours: outOfHours ?? this.outOfHours,
        pointOfSale: pointOfSale ?? this.pointOfSale,
        relevance: relevance ?? this.relevance,
        storeBrand: storeBrand ?? this.storeBrand,
        storeCategory: storeCategory ?? this.storeCategory,
        storeMall: storeMall ?? this.storeMall,
        storePreferences: storePreferences ?? this.storePreferences,
        tags: tags ?? this.tags,
        themeColors: themeColors ?? this.themeColors,
        whatsappConfirmedAt: whatsappConfirmedAt ?? this.whatsappConfirmedAt,
        whatsappNumber: whatsappNumber ?? this.whatsappNumber,
      );

  factory StoreModel.fromJson(String source) =>
      StoreModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  StoreEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'averageTime': averageTime,
      'callNumber': callNumber,
      'deliveryOptions': deliveryOptions,
      'description': description,
      'displayName': displayName,
      'fee': fee,
      'id': id,
      'isVisible': isVisible,
      'logo': logo,
      'mainSegment': mainSegment,
      'openingHours': openingHours,
      'outOfHours': outOfHours,
      'pointOfSale': pointOfSale,
      'relevance': relevance,
      'storeBrand': storeBrand,
      'storeCategory': storeCategory,
      'storeMall': storeMall,
      'storePreferences': storePreferences,
      'tags': tags,
      'themeColors': themeColors,
      'whatsappConfirmedAt': DateFormat.tryParseOrDateNow(whatsappConfirmedAt),
      'whatsappNumber': whatsappNumber,
    };
  }

  @override
  List<Object?> get props => [
        averageTime,
        callNumber,
        deliveryOptions,
        description,
        displayName,
        fee,
        id,
        isVisible,
        logo,
        mainSegment,
        openingHours,
        outOfHours,
        pointOfSale,
        relevance,
        storeBrand,
        storeCategory,
        storeMall,
        storePreferences,
        tags,
        themeColors,
        whatsappConfirmedAt,
        whatsappNumber,
      ];

  @override
  bool? get stringify => true;
}
