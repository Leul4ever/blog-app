import 'package:flutter_bloc_app/core/error/exception.dart';
import 'package:flutter_bloc_app/core/error/failure.dart';
import 'package:flutter_bloc_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:flutter_bloc_app/features/auth/data/models/user_model.dart';
import 'package:flutter_bloc_app/features/auth/domain/entities/user.dart';
import 'package:flutter_bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource);
  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final user = await authRemoteDataSource.getCurrentUser();
      // There is no need to check if user == null here because
      // authRemoteDataSource.getCurrentUser() never returns null.
      // It throws a ServerException if the user is not logged in.
      // So this check is redundant and can be removed.
      return right(user);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    return _getUser(
      () async => authRemoteDataSource.signUpWithEmailPassword(
          name: name, email: email, password: password),
    );
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(
      () async => await authRemoteDataSource.signInWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<UserModel> Function() fn,
  ) async {
    try {
      final userModel = await fn();
      return right(userModel as User);
    } on sb.AuthException catch (e) {
      return left(Failure(e.message));
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
