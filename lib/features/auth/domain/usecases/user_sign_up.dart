import 'package:flutter_bloc_app/core/error/failure.dart';
import 'package:flutter_bloc_app/core/usecase/usecase..dart';
import 'package:flutter_bloc_app/core/common/entities/user.dart';
import 'package:flutter_bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository authRepository;
  UserSignUp(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserSignUpParams params) async {
    return authRepository.signUpWithEmailPassword(
        name: params.name, email: params.email, password: params.password);
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;
  UserSignUpParams(
      {required this.name, required this.email, required this.password});
}
