import 'package:supabase_flutter/supabase_flutter.dart' as supabase;
import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required String id,
    required String email,
    required String? displayName,
  }) : super(id: id, email: email, displayName: displayName);

  factory UserModel.fromSupabase(supabase.User user) {
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      displayName: user.userMetadata?['full_name'],
    );
  }
}
