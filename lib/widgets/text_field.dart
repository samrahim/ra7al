import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? hintText;
  final IconData? suffixIcon;
  final bool isPasswordField;
  final bool? obscureText;

  final VoidCallback? onToggleObscure;
  final String? Function(String?)? validator;
  final TextDirection? textDirection;
  final TextAlign? textAlign;

  const CustomTextFormField({
    super.key,
    required this.controller,
    this.labelText,
    this.hintText,
    required this.suffixIcon,
    this.isPasswordField = false,
    this.obscureText,
    this.onToggleObscure,
    this.validator,
    this.textDirection,

    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (newValue) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 1),
            backgroundColor: Color.fromARGB(230, 23, 182, 57),
            content: Text(
              'الميزة قيد التطوير',
              textDirection: TextDirection.rtl,
            ),
          ),
        );
      },
      controller: controller,
      obscureText: obscureText ?? false,
      textDirection: textDirection,

      textAlign: textAlign ?? TextAlign.start,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 11, 75, 65),
            width: 0.8,
          ),
        ),
        suffixIcon: Icon(suffixIcon),
        prefixIcon:
            isPasswordField
                ? IconButton(
                  onPressed: onToggleObscure,
                  icon: Icon(
                    obscureText! ? Icons.visibility_off : Icons.visibility,
                  ),
                )
                : null,
        labelText: labelText,
        hintText: hintText,
      ),
      validator: validator,
    );
  }
}
