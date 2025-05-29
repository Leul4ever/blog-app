import 'package:flutter_bloc_app/core/error/exception.dart';
import 'package:flutter_bloc_app/core/error/failure.dart';
import 'package:flutter_bloc_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:flutter_bloc_app/features/auth/data/models/user_model.dart';
import 'package:flutter_bloc_app/features/auth/domain/entities/user.dart';
import 'package:flutter_bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(this.authRemoteDataSource);

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final userModel = await authRemoteDataSource.signUpWithEmailPassword(
          name: name, email: email, password: password);
      return right(userModel as User);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userModel = await authRemoteDataSource.signInWithEmailPassword(
        email: email,
        password: password,
      );
      return right(userModel as User);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
