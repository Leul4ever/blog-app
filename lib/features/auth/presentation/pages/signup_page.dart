import 'package:flutter/material.dart';
import 'package:flutter_bloc_app/features/auth/presentation/widgets/auth_field.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign Up',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            AuthField(hintText: ' Name '),
            SizedBox(
              height: 15,
            ),
            AuthField(hintText: 'Email'),
            SizedBox(
              height: 15,
            ),
            AuthField(hintText: 'password'),
          ],
        ),
      ),
    );
  }
}
