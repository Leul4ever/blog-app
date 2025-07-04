import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_bloc_app/core/usecase/usecase..dart';
import 'package:flutter_bloc_app/core/common/entities/user.dart';
import 'package:flutter_bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_bloc_app/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_bloc_app/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_bloc_app/features/auth/domain/usecases/user_sign_up.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;

  AuthBloc(this._appUserCubit, {
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required AuthRepository authRepository,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogin,
        _currentUser = CurrentUser(authRepository),
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogin>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }
  void _isUserLoggedIn(
      AuthIsUserLoggedIn event, Emitter<AuthState> emit) async {
    final res = await _currentUser(NoParams());
    res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) {
        print(r.email);
        emit(AuthSuccess(user: r));
      },
    );
  }

  Future<void> _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (failure) => emit(AuthFailure(message: failure.message)),
      (user) => emit(AuthSuccess(user: user)),
    );
  }

  Future<void> _onAuthLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLogin(
      UserLoginParams(
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) {
        print('Login successful for email: ${event.email}');
        print('User ID: ${r.id}');
        print('User Name: ${r.name}');
        print('User Email: ${r.email}');
       
      },
    );
  }
}
