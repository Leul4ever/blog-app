part of 'app_user_cubit.dart';

@immutable
sealed class AppUserState {}

final class AppUserInitial extends AppUserState {}

final class AppUserLoggedIn extends AppUserState {
  final User user;
  AppUserLoggedIn({required this.user});
}

final class AppUserLoggedOut extends AppUserState {}

final class AppUserError extends AppUserState {
  final String message;
  AppUserError({required this.message});
}
