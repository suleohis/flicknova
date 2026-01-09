import '../../../../core/models/season_entity.dart';
import '../../../../core/network/tmdb_service.dart';
import '../../domain/repositories/season_repository.dart';

class SeasonRepositoryImpl implements SeasonRepository {
  final TmdbService _tmdbService = TmdbService();

  @override
  Future<SeasonEntity> getSeasonDetails({
    required int tvId,
    required int seasonNumber,
  }) async {
    final response = await _tmdbService.getSeasonDetails(tvId, seasonNumber);
    return SeasonEntity.fromJson(response);
  }
}
