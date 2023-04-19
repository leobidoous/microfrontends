import 'package:equatable/equatable.dart';

class SearchableFieldsStoreEntity extends Equatable {
  const SearchableFieldsStoreEntity({
    this.displayName,
    this.mainSegment,
    this.mall,
  });

  final String? displayName;
  final String? mainSegment;
  final String? mall;

  SearchableFieldsStoreEntity copyWith({
    String? displayName,
    String? mainSegment,
    String? mall,
  }) =>
      SearchableFieldsStoreEntity(
        displayName: displayName ?? this.displayName,
        mainSegment: mainSegment ?? this.mainSegment,
        mall: mall ?? this.mall,
      );

  factory SearchableFieldsStoreEntity.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const SearchableFieldsStoreEntity();
    return SearchableFieldsStoreEntity(
      displayName: json['displayName'],
      mainSegment: json['mainSegment'],
      mall: json['mall'],
    );
  }

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'mainSegment': mainSegment,
        'mall': mall,
      };

  @override
  List<Object?> get props => [
        displayName,
        mainSegment,
        mall,
      ];
}
