class LabelHeader {
  final String id;
  final String name;
  final String? displayName;
  final String? imagePath;
  final String? cnpj;
  final String? phone;

  LabelHeader({
    required this.id,
    required this.name,
    this.displayName,
    this.imagePath,
    this.cnpj,
    this.phone,
  });
}
