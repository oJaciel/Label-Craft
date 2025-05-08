class Label {
  final String id;
  final String name;
  final bool hasWeight;
  final String? weight;
  final bool hasPrice;
  final String? price;
  final bool hasFab;
  final bool hasExpDate;

  Label({
    required this.id,
    required this.name,
    required this.hasWeight,
    this.weight,
    required this.hasPrice,
    this.price,
    required this.hasFab,
    required this.hasExpDate,
  });
}
