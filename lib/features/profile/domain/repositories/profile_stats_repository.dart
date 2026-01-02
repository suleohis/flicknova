import '../entities/user_stats_entity.dart';

abstract class ProfileStatsRepository {
  Future<UserStatsEntity> getUserStats();
}
