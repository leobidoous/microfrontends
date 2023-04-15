class DiscountEntity {
  const DiscountEntity({
    required this.id,
    required this.name,
    required this.percentOfDiscount,
    required this.hasDescont,
  });

  final int id;
  final String name;
  final double percentOfDiscount;
  final bool hasDescont;
}
