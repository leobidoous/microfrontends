import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/campaign_mall_entity.dart';
import 'mall_file_model.dart';

class CampaignMallModel extends CampaignMallEntity with EquatableMixin {
  CampaignMallModel({
    required super.id,
    required super.title,
    required super.description,
    required super.dateBegin,
    required super.dateEnd,
    required super.bannerUrl,
    required super.shoppingId,
    required super.typeCampaign,
    required super.rules,
  });

  factory CampaignMallModel.fromMap(Map<String, dynamic> map) {
    return CampaignMallModel(
      id: map['id'] ?? 0,
      title: map['title_campaign'] ?? '',
      description: map['description'] ?? '',
      dateBegin: map['start_date'] ?? '',
      dateEnd: map['end_date'] ?? '',
      bannerUrl: MallFileModel.fromMap(map['cover'] ?? {}),
      shoppingId: map['id_mall'] ?? 0,
      typeCampaign: map['type_campaign'] ?? '',
      rules: map['regulation_link'] ?? '',
    );
  }

  factory CampaignMallModel.fromEntity(CampaignMallEntity entity) {
    return CampaignMallModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      dateBegin: entity.dateBegin,
      dateEnd: entity.dateEnd,
      bannerUrl: entity.bannerUrl,
      shoppingId: entity.shoppingId,
      typeCampaign: entity.typeCampaign,
      rules: entity.rules,
    );
  }

  factory CampaignMallModel.fromJson(String source) =>
      CampaignMallModel.fromMap(json.decode(source));

  String get toJson => json.encode(toMap);

  CampaignMallEntity get toEntity => this;

  Map<String, dynamic> get toMap {
    return {
      'id': id,
      'title_campaign': title,
      'description': description,
      'start_date': dateBegin,
      'end_date': dateEnd,
      'cover': MallFileModel.fromEntity(bannerUrl).toMap,
      'id_mall': shoppingId,
      'type_campaign': typeCampaign,
      'regulation_link': rules,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        dateBegin,
        dateEnd,
        bannerUrl,
        shoppingId,
        typeCampaign,
        rules,
      ];

  @override
  bool? get stringify => true;
}
