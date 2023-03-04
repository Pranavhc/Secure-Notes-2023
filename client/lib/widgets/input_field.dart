import 'package:flutter/material.dart';
import '../utils/colors.dart';

class InputField extends StatelessWidget {
  final String hint;
  final bool obscure;
  final double top;
  final double bottom;
  final double right;
  final double left;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const InputField(
      {Key? key,
      required this.hint,
      this.obscure = false,
      this.top = 0,
      this.bottom = 0,
      this.right = 0,
      this.left = 0,
      required this.controller,
      this.keyboardType = TextInputType.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(top: top, bottom: bottom, left: left, right: right),
      child: SizedBox(
        height: 50,
        child: TextField(
          keyboardType: keyboardType,
          controller: controller,
          cursorColor: Theme.of(context).colorScheme.primary,
          style: TextStyle(color: Theme.of(context).colorScheme.primary),
          obscureText: obscure,
          obscuringCharacter: '*',
          decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).cardColor,
            hintText: hint,
            hintStyle: const TextStyle(color: kFairTextSecondary),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    const BorderSide(color: kFairTextSecondary, width: 1)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: kFieldBackground, width: 1),
            ),
          ),
        ),
      ),
    );
  }
}
