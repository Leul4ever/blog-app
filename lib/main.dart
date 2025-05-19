import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/core/secrets/app_secrets.dart';
import 'package:flutter_bloc_app/core/theme/theme.dart';
import 'package:flutter_bloc_app/features/auth/data/datasource/auth_remote_data_source.dart';
import 'package:flutter_bloc_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:flutter_bloc_app/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_bloc_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter_bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
// import 'package:flutter_bloc_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter_bloc_app/features/auth/presentation/pages/signup_page.dart';
import 'package:flutter_bloc_app/init_dependencies.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  final supabase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseAnonKey);
  AuthRepository authRepository;
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
          create: (_) => ServiceLocator<AuthBloc>()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      home: const SignupPage(),
    );
  }
}
