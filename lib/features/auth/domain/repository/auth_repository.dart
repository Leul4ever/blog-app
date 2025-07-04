import 'package:flutter_bloc_app/core/error/failure.dart';
import 'package:flutter_bloc_app/core/common/entities/user.dart';
import 'package:flutter_bloc_app/features/auth/domain/usecases/current_user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String name, required String email, required String password});
  Future<Either<Failure, User>> loginWithEmailPassword(
      {required String email, required String password});

  Future<Either<Failure, User>> getCurrentUser();
  Future<Either<Failure, User>> currentUser();
}
