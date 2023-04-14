class OrderItemEntity {
  final String itemId;
  final int quantity;
  final int unitPriceCents;
  final String externalId;
  final String description;
  final String imageUrl;
  final String id;

  OrderItemEntity({
    required this.itemId,
    required this.quantity,
    required this.unitPriceCents,
    required this.externalId,
    required this.description,
    required this.imageUrl,
    required this.id,
  });
}
