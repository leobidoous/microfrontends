import 'mall_file_entity.dart';

class CampaignMallEntity {
  final int id;
  final String title;
  final String description;
  final String dateBegin;
  final String dateEnd;
  final MallFileEntity bannerUrl;
  final int shoppingId;
  final String typeCampaign;
  final String rules;

  const CampaignMallEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.dateBegin,
    required this.dateEnd,
    required this.bannerUrl,
    required this.shoppingId,
    required this.typeCampaign,
    required this.rules,
  });
}
