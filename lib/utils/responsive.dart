import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class Responsive {
  final double width, height, inch;
  final bool isTable;

  Responsive(
      {required this.width,
      required this.height,
      required this.inch,
      required this.isTable});

  factory Responsive.of(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final size = data.size;
    // c2 = a2+b2 => c = sqrt(a2+b2)
    final inch = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    final isTable = size.shortestSide >= 600;
    return Responsive(
        width: size.width, height: size.height, inch: inch, isTable: isTable);
  }

  double wp(double percent) {
    return width * percent / 100;
  }

  double hp(double percent) {
    return height * percent / 100;
  }

  double ip(double percent) {
    return inch * percent / 100;
  }
}
