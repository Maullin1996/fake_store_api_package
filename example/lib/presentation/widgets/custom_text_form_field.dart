import 'package:flutter/material.dart';

import '../../config/design/tokens.dart';

/// This file defines a custom widget for a styled text form field.

class CustomTextFormField extends StatelessWidget {
  /// The label text displayed above the input field.
  final String title;

  /// Whether the input field should obscure the text (e.g., for passwords).
  final bool obscureText;

  /// A function to validate the input value.
  /// Returns a string with an error message if validation fails, or `null` if valid.
  final String? Function(String?)? validator;

  /// The controller for managing the input field's text.
  final TextEditingController controller;

  CustomTextFormField({
    super.key,
    required this.controller,
    required this.title,
    this.validator,
    this.obscureText = false,
  });

  /// The border decoration for the input field, including color and border radius.
  final borderDecoration = OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.primaryVariant, width: 2),
    borderRadius: BorderRadius.circular(25),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: AppColors.background,
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        obscureText: obscureText,
        decoration: InputDecoration(
          label: Text(title, style: TextStyle(color: AppColors.primaryVariant)),
          errorStyle: TextStyle(color: AppColors.error),
          isDense: true,
          focusedErrorBorder: borderDecoration.copyWith(
            borderSide: BorderSide(color: AppColors.error),
          ),
          errorBorder: borderDecoration.copyWith(
            borderSide: BorderSide(color: AppColors.error),
          ),
          focusedBorder: borderDecoration,
          enabledBorder: borderDecoration,
        ),
      ),
    );
  }
}
