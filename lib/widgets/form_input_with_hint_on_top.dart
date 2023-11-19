import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';

class FormInputWithHint extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorText;
  final Function? onChanged;
  final FocusNode? focusNode;
  final String? initialValue;
  final String? hintText;
  final int maxLine;
  final int? maxLength;
  final bool isEnabled;
  final TextEditingController? controller;
  final double formSize;
  final double horizontalTextPadding;
  final double textFieldHeight;
  final Color? fillColor;
  final double formRadius;
  final bool isDigitsOnly;

  const FormInputWithHint({
    super.key,
    required this.label,
    this.obscureText = false,
    this.keyboardType,
    this.formSize = 48,
    this.prefixIcon,
    this.suffixIcon,
    this.horizontalTextPadding = 20,
    this.controller,
    this.isDigitsOnly = false,
    this.fillColor = AppColors.lightGrey,
    this.isEnabled = true,
    this.maxLine = 1,
    this.maxLength,
    this.errorText,
    this.onChanged,
    this.focusNode,
    this.initialValue,
    required this.hintText,
    this.textFieldHeight = 0,
    this.formRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          textAlign: TextAlign.left,
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: AppColors.titleColor,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        TextField(
          focusNode: focusNode,
          enabled: isEnabled,
          controller: controller,
          maxLength: maxLength,
          decoration: InputDecoration(
            enabled: isEnabled,
            filled: true,
            hintStyle: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.hintGrey,
            ),
            fillColor: AppColors.bgWhite,
            alignLabelWithHint: true,
            /*  border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(formRadius),
              borderSide: const BorderSide(
                width: 0,
                style: BorderStyle.solid,
              ),
            ),*/
            contentPadding: EdgeInsets.symmetric(
              vertical: textFieldHeight,
              horizontal: horizontalTextPadding,
            ),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            errorText: errorText,
            errorMaxLines: 3,
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(formRadius),
              borderSide:
              const BorderSide(color: AppColors.hintGrey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
              const BorderSide(color: AppColors.primaryColor, width: 1),
              borderRadius: BorderRadius.circular(formRadius),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide:
              const BorderSide(color: AppColors.hintGrey, width: 1),
              borderRadius: BorderRadius.circular(formRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
              const BorderSide(color: AppColors.hintGrey, width: 1),
              borderRadius: BorderRadius.circular(formRadius),
            ),
          ),
          inputFormatters: [
            if (isDigitsOnly) FilteringTextInputFormatter.digitsOnly
          ],
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Colors.black,
          ),

          /*style: const TextStyle(fontSize: 16, letterSpacing: 0.7),*/
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLine,
          key: key,
          //onChanged: onChanged,
        ),
      ],
    );
  }
}