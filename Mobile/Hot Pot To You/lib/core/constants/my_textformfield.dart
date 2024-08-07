import 'package:electronic_equipment_store/core/constants/color_constants.dart';
import 'package:electronic_equipment_store/core/constants/dismension_constants.dart';
import 'package:electronic_equipment_store/core/constants/textstyle_constants.dart';
import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final controller;
  final String hintText;
  final bool? obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputType? keyboardType;
  final AutovalidateMode? autovalidateMode;
  final void Function()? onTap;
  final bool? readOnly;

  const MyTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.autovalidateMode,
    this.onChanged,
    this.onTap,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText!,
      keyboardType: keyboardType,
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: autovalidateMode,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kDefaultCircle14),
          borderSide: const BorderSide(color: ColorPalette.textHide),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorPalette.primaryColor),
          borderRadius: BorderRadius.circular(kDefaultCircle14),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kDefaultCircle14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        errorStyle: TextStyles.defaultStyle.setColor(Colors.redAccent),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(kDefaultCircle14),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        fillColor: Colors.white,
        filled: true,
        hintStyle: TextStyles.defaultStyle.setColor(ColorPalette.textHide),
      ),
      onTap: onTap,
      readOnly: readOnly?? false
    );
  }
}
