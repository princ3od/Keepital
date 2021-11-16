import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class ExcludeSetting extends StatefulWidget {
  late String title;
  late String subtitle;

  late void Function(bool isChecked) onTap;

  ExcludeSetting({required this.title, required this.subtitle, required this.onTap});

  @override
  State<ExcludeSetting> createState() => _ExcludeSettingState();
}

class _ExcludeSettingState extends State<ExcludeSetting> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.backgroundColor,
      child: ListTile(
        leading: (!isChecked)
            ? Icon(
                Icons.check_box_outline_blank,
                size: 40,
              )
            : Icon(
                Icons.check_box,
                size: 40,
              ),
        title: Text(
          widget.title,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          widget.subtitle,
          style: GoogleFonts.montserrat(
            fontSize: 10,
            fontWeight: FontWeight.normal,
          ),
        ),
        onTap: () {
          setState(() {
            isChecked = !isChecked;
            widget.onTap(isChecked);
          });
        },
      ),
    );
  }
}
