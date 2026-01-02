import 'package:flicknova/core/models/genre_entity.dart';

import 'genre_model.dart';
import 'profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.id,
    super.displayName,
    super.avatarUrl,
    super.updatedAt,
    super.favoriteGenres,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      displayName: json['display_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      favoriteGenres: json['favorite_genres']?.map(
        (genre) => GenreModel.fromJson(genre as Map<String, dynamic>),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'display_name': displayName,
      'avatar_url': avatarUrl,
      'updated_at': updatedAt?.toIso8601String(),
      'favorite_genres': favoriteGenres,
    };
  }
}
