import 'package:flutter_bloc_app/core/error/exception.dart';
import 'package:flutter_bloc_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Session get currentUserSession;
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> signInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<UserModel> getCurrentUser();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<UserModel> getCurrentUser() async {
    try {
      final response = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', currentUserSession.user.id)
          .single();

      return UserModel.fromJson(response).copyWith(
        email: currentUserSession.user.email,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Session get currentUserSession {
    final session = supabaseClient.auth.currentSession;
    if (session == null) {
      throw ServerException('No current session');
    }
    return session;
  }

  @override
  Future<UserModel> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signUp(password: password, email: email, data: {
        'name': name,
      });
      if (response.user == null) {
        throw ServerException('User is null ');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      if (response.user == null) {
        throw ServerException('User is null');
      }
      return UserModel.fromJson(response.user!.toJson());
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
