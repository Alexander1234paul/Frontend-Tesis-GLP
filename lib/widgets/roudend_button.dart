import 'package:flutter/material.dart';
import 'package:frontend_tesis_glp/utils/app_colors.dart';

class RoundedButton extends StatelessWidget {
  final double size;
  final String label;
  final VoidCallback onPressed;
  final Color? backgroundColor;

  const RoundedButton({
    Key? key,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    required this.size,
  })  : assert(label != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: backgroundColor ?? AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size),
        ),
        elevation: 5,
      ),
      onPressed: onPressed,
      child: Container(
        // padding: EdgeInsets.symmetric(horizontal: 90, vertical: 17),
        width: size * 0.80,
        height: size * .15,
        child: Center(
          child: Text(
            label,
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'sans',
                letterSpacing: 1,
                fontSize: size * 0.05),
          ),
        ),
      ),
    );
  }
}
