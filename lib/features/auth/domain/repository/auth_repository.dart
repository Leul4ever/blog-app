import 'package:flutter_bloc_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart'; // Assuming you're using dartz for Either

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmailPassword(
      {required String name, required String email, required String password});
  Future<Either<Failure, String>> signInWithEmailPassword(
      {required String email, required String password});
}
