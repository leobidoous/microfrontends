class FAQEntity {
  final String title;
  final String subtitle;
  final String content;

  FAQEntity({
    required this.title,
    this.subtitle = '',
    this.content = '',
  });
}
