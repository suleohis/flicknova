import '../../../../core/models/season_entity.dart';

abstract class SeasonRepository {
  Future<SeasonEntity> getSeasonDetails({
    required int tvId,
    required int seasonNumber,
  });
}
