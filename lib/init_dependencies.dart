import 'package:flutter_bloc_app/core/secrets/app_secrets.dart';
import 'package:flutter_bloc_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:flutter_bloc_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:flutter_bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_bloc_app/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_bloc_app/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_bloc_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final ServiceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);
  _initAuth(supabase.client);
  ServiceLocator.registerLazySingleton<SupabaseClient>(() => supabase.client);
// ServiceLocator.registerLazySingleton(() => AppUserCubit());
}

void _initAuth(SupabaseClient supabase) {
  ServiceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(supabase),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(ServiceLocator()),
    )
    ..registerFactory<UserSignUp>(
      () => UserSignUp(ServiceLocator()),
    )
    ..registerFactory<UserLogin>(
      () => UserLogin(ServiceLocator()),
    )
    ..registerFactory(
      () => CurrentUser(ServiceLocator()),
    )
    ..registerLazySingleton(() => AuthBloc(
          ServiceLocator(),
          userSignUp: ServiceLocator(),
          userLogin: ServiceLocator(),
          authRepository: ServiceLocator(),
          appUserCubit: ServiceLocator(),
        ));
