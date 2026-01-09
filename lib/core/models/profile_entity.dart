
import 'genre_model.dart';

class ProfileEntity {
  final String id;
  final String? displayName;
  final String? avatarUrl;
  final DateTime? updatedAt;
   List<GenreModel>? favoriteGenres;
   List<Map<String, dynamic>>? watchList;

  ProfileEntity({
    required this.id,
    this.displayName,
    this.avatarUrl,
    this.updatedAt,
    this.favoriteGenres,
    this.watchList
  });

  // Optional: copyWith for updates
  ProfileEntity copyWith({
    String? displayName,
    String? avatarUrl,
    DateTime? updatedAt,
    List<GenreModel>? favoriteGenres,
    List<Map<String, dynamic>>? watchList
  }) {
    return ProfileEntity(
      id: id,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      updatedAt: updatedAt ?? this.updatedAt,
      favoriteGenres: favoriteGenres,
      watchList: watchList,
    );
  }
}