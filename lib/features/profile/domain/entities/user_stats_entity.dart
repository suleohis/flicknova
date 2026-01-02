class UserStatsEntity {
  final int moviesWatched;
  final int totalHours;
  final double avgRating;
  final Map<String, double> genreDistribution; // genre name -> percentage

  UserStatsEntity({
    required this.moviesWatched,
    required this.totalHours,
    required this.avgRating,
    required this.genreDistribution,
  });

  UserStatsEntity copyWith({
    int? moviesWatched,
    int? totalHours,
    double? avgRating,
    Map<String, double>? genreDistribution,
  }) {
    return UserStatsEntity(
      moviesWatched: moviesWatched ?? this.moviesWatched,
      totalHours: totalHours ?? this.totalHours,
      avgRating: avgRating ?? this.avgRating,
      genreDistribution: genreDistribution ?? this.genreDistribution,
    );
  }
}
