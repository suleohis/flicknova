class TrendingPersonEntity {
  final bool adult;
  final int id;
  final String name;
  final String originalName;
  final String mediaType; // Always "person"
  final double popularity;
  final int gender; // 0 = not set, 1 = female, 2 = male
  final String knownForDepartment;
  final String? profilePath;
  final List<Map<String, dynamic>> knownFor; // Movies/TV they're known for

  TrendingPersonEntity({
    required this.adult,
    required this.id,
    required this.name,
    required this.originalName,
    required this.mediaType,
    required this.popularity,
    required this.gender,
    required this.knownForDepartment,
    this.profilePath,
    required this.knownFor,
  });

  factory TrendingPersonEntity.fromJson(Map<String, dynamic> json) {
    return TrendingPersonEntity(
      adult: json['adult'] as bool? ?? false,
      id: json['id'] as int,
      name: json['name'] as String,
      originalName: json['original_name'] as String,
      mediaType: json['media_type'] as String? ?? 'person',
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      gender: json['gender'] as int? ?? 0,
      knownForDepartment: json['known_for_department'] as String? ?? '',
      profilePath: json['profile_path'] as String?,
      knownFor:
          (json['known_for'] as List?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          [],
    );
  }
}
