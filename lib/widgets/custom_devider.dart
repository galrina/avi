import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomerDivider extends StatelessWidget {
  final double horizontalMargin;
  final double verticalMargin;
  final Color color;
  final double height;

  const CustomerDivider(
      {super.key,
        this.horizontalMargin = 20,
        this.verticalMargin = 0,
        this.color = AppColors.bgPurple,
        this.height = 0.5});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      color: color,
      margin: EdgeInsets.symmetric(
          horizontal: horizontalMargin, vertical: verticalMargin),
    );
  }
}