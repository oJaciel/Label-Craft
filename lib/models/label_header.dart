class LabelHeader {
  final String id;
  final String name;
  final String? displayName;
  final String? image;
  final String? aditionalInfo;

  LabelHeader({
    required this.id,
    required this.name,
    this.displayName,
    this.image,
    this.aditionalInfo,
  });
}
