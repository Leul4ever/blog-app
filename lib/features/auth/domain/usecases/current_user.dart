import 'package:flutter_bloc_app/core/error/failure.dart';
import 'package:flutter_bloc_app/core/usecase/usecase..dart';
import 'package:flutter_bloc_app/features/auth/domain/entities/user.dart';
import 'package:flutter_bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository authRepository;
  CurrentUser(this.authRepository);
  @override
  Future<Either<Failure, User>> call(NoParams params) async {
    return authRepository.getCurrentUser();
  }
}
