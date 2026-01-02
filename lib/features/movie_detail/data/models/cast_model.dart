import '../../domain/entities/cast_entity.dart';

class CastModel extends CastEntity {
  CastModel({
    required super.id,
    required super.name,
    required super.character,
    super.profilePath,
    required super.order,
  });

  factory CastModel.fromJson(Map<String, dynamic> json) {
    return CastModel(
      id: json['id'] as int,
      name: json['name'] as String,
      character: json['character'] as String? ?? '',
      profilePath: json['profile_path'] as String?,
      order: json['order'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'character': character,
      'profile_path': profilePath,
      'order': order,
    };
  }
}
