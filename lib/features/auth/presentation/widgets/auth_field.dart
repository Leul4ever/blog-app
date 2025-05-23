import 'package:flutter/material.dart';
import 'package:flutter_bloc_app/core/theme/app_pallete.dart';

class AuthField extends StatelessWidget {
  final String hintText;

  final TextEditingController controller;
  final bool isObscuredText;
  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isObscuredText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppPallete.gradient1, width: 2),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing !";
        }
        return null;
      },
      obscureText: isObscuredText,
    );
  }
}
