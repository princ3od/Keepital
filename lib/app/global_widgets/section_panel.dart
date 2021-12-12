import 'package:flutter/material.dart';
import 'package:keepital/app/core/values/app_colors.dart';

class SectionPanel extends StatelessWidget {
  const SectionPanel({Key? key, this.padding = const EdgeInsets.all(10.0), required this.child}) : super(key: key);
  final EdgeInsets padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.30),
            spreadRadius: 0.8,
            blurRadius: 0.8,
            offset: Offset(0, 0.8),
          ),
        ],
      ),
      child: child,
    );
  }
}
