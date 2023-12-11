import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/app_colors.dart';

class RoundedEdgedButton extends StatelessWidget {
  final String buttonText;
  final double buttonFontSize;
  final Color buttonTextColor;
  final Function onButtonClick;
  final double height;
  final Color buttonBackground;
  final double borderRadius;

  const RoundedEdgedButton({
    super.key,
    required this.buttonText,
    required this.onButtonClick,
    this.height = 50,
    this.buttonBackground = (AppColors.primaryColor),
    this.borderRadius = 5,
    this.buttonFontSize = 16,
    this.buttonTextColor = AppColors.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onButtonClick();
      },
      child: Container(
        height: height,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(1, 1),
              blurRadius: 0,
              color: buttonBackground,
            )
          ],
          color: buttonBackground,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: GoogleFonts.inter(
                color: buttonTextColor,
                fontSize: buttonFontSize,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}