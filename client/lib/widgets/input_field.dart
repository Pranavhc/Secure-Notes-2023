import 'package:flutter/material.dart';
import '../colors.dart';

class InputField extends StatelessWidget {
  final String hint;
  final bool obscure;

  const InputField({Key? key, required this.hint, required this.obscure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextField(
        cursorColor: kFairText,
        style: const TextStyle(color: kFairText),
        obscureText: obscure,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          filled: true,
          fillColor: kFieldBackground,
          hintText: hint,
          hintStyle: const TextStyle(color: kFairTextSecondary),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: kFairTextSecondary, width: 1)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: kFieldBackground, width: 1),
          ),
        ),
      ),
    );
  }
}
