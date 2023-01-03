import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get pWidth => MediaQuery.of(this).size.width;
  double get pHeight => MediaQuery.of(this).size.height;
  double get hPadding => pWidth * 0.05;
  double get vPadding => pHeight * 0.015;
}
