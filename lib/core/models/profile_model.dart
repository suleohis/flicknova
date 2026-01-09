import 'genre_model.dart';
import 'profile_entity.dart';

class ProfileModel extends ProfileEntity {
  ProfileModel({
    required super.id,
    super.displayName,
    super.avatarUrl,
    super.updatedAt,
    super.favoriteGenres,
    super.watchList,
  });

  ProfileModel copyWith({
    String? id,
    String? displayName,
    String? avatarUrl,
    DateTime? updatedAt,
    List<GenreModel>? favoriteGenres,
    List<Map<String, dynamic>>? watchList,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      updatedAt: updatedAt ?? this.updatedAt,
      favoriteGenres: favoriteGenres ?? this.favoriteGenres,
      watchList: watchList ?? this.watchList,
    );
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      displayName: json['display_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      favoriteGenres: (json['favorite_genres'] as List?)
          ?.map((genre) => GenreModel.fromJson(genre as Map<String, dynamic>))
          .toList(),
      watchList: json['watch_list'] as List<Map<String, dynamic>>?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'display_name': displayName,
      'avatar_url': avatarUrl,
      'updated_at': updatedAt?.toIso8601String(),
      'favorite_genres': favoriteGenres,
      'watch_list': watchList,
    };
  }
}
