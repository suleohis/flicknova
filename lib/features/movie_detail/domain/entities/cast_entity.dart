class CastEntity {
  final int id;
  final String name;
  final String character;
  final String? profilePath;
  final int order;

  CastEntity({
    required this.id,
    required this.name,
    required this.character,
    this.profilePath,
    required this.order,
  });
}
