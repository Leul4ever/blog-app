import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_app/core/common/widgets/loader.dart';
import 'package:flutter_bloc_app/core/theme/app_pallete.dart';
import 'package:flutter_bloc_app/core/utils/show_snackbar.dart';
import 'package:flutter_bloc_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_bloc_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:flutter_bloc_app/features/auth/presentation/widgets/auth_gradient_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  late bool isObscuredText;

  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailure) {
              showSnackBar(context, state.message);
            } else if (state is AuthSuccess) {
              showSnackBar(context, 'Signup successful!');
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }
            return Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign Up .',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  AuthField(hintText: ' Name ', controller: nameController),
                  const SizedBox(height: 15),
                  AuthField(hintText: 'Email', controller: emailController),
                  const SizedBox(height: 15),
                  AuthField(
                    hintText: 'password',
                    controller: passwordController,
                    isObscuredText: true,
                  ),
                  const SizedBox(height: 20),
                  AuthGradientButton(
                    buttonText:
                        state is AuthLoading ? "Signing Up..." : "Sign Up",
                    onPressed: state is AuthLoading
                        ? () {}
                        : () {
                            if (formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(AuthSignUp(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  name: nameController.text.trim()));
                            }
                          },
                  ),
                  const SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      text: "Already  have an account? ",
                      style: Theme.of(context).textTheme.titleMedium,
                      children: [
                        TextSpan(
                          text: 'Sign In ',
                          style:
                              Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: AppPallete.gradient2,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
