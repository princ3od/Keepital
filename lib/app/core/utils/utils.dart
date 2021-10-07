import 'package:flutter/material.dart';

class Utils {
  static bool isLightMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.light;
  }
}
