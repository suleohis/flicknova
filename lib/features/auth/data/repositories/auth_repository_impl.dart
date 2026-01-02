import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flicknova/core/models/profile_model.dart';
import 'package:flicknova/core/utils/api_const.dart';
import 'package:flicknova/features/auth/data/models/user_model.dart';
import 'package:flicknova/features/auth/domain/repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../domain/entities/user_entity.dart';

class AuthRepositoryImpl implements AuthRepository {
  final SupabaseClient _client = Supabase.instance.client;
  // Use your Web Client ID here (from Google Cloud Web client)
  static const String _webClientId =
      '996389293594-58f48nr2m2ajrv3v5p4osiaqdjaf1kv8.apps.googleusercontent.com';

  // Optional: iOS-specific client ID for better native flow
  static const String? _iosClientId =
      'YOUR_IOS_CLIENT_ID.apps.googleusercontent.com';

  @override
  Future<UserEntity> signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;
    unawaited(
      googleSignIn.initialize(
        serverClientId: _webClientId, // Required for Supabase
        // clientId: _iosClientId,        // iOS native
      ),
    );
    googleSignIn.authorizationClient.authorizationForScopes([
      'email',
      'profile',
    ]);

    final googleUser = await googleSignIn.authenticate();
    final googleAuth = googleUser.authentication;
    final idToken = googleAuth.idToken;

    if (idToken == null) {
      throw Exception('No ID Token received from Google');
    }

    final response = await _client.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
    );
    if (response.user == null) {
      throw Exception('Sign in failed - no user returned');
    }
    return UserModel.fromSupabase(response.user!);
  }

  @override
  Future<UserEntity> signInWithApple() async {
    final rawNonce = _client.auth.currentSession?.accessToken ?? '';
    final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: hashedNonce,
    );

    final idToken = credential.identityToken;
    if (idToken == null) {
      throw Exception('No ID Token received from Apple');
    }

    final response = await _client.auth.signInWithIdToken(
      provider: OAuthProvider.apple,
      idToken: idToken,
      nonce: rawNonce,
    );

    if (response.user == null) {
      throw Exception('Sign in failed - no user returned');
    }
    return UserModel.fromSupabase(response.user!);
  }

  @override
  Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
    await _client.auth.signOut();
  }

  @override
  Stream<UserEntity?> get currentUser {
    return _client.auth.onAuthStateChange.map((event) {
      final user = event.session?.user;
      return user != null ? UserModel.fromSupabase(user) : null;
    });
  }

  @override
  Future<ProfileModel?> getCurrentProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    final response = await _client
        .from(ApiConst.profiles)
        .select()
        .eq(ApiConst.id, user.id)
        .single();

    return ProfileModel.fromJson(response);
  }

  @override
  Future<ProfileModel?> updateProfile(ProfileModel profile) async {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    final response = await _client
        .from(ApiConst.profiles)
        .update(profile.toJson());

    return ProfileModel.fromJson(response);
  }
}
