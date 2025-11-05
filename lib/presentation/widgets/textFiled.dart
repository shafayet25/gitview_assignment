
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      cursorColor: theme.primaryColor,
      style: TextStyle(color: theme.textTheme.bodyMedium?.color),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey), 
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey), 
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: theme.primaryColor, width: 2), 
        ),
        border: const UnderlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
      ),
    );
  }
}
