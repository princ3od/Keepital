import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepital/app/core/values/app_colors.dart';

class ButtonWithLeadIcon extends StatelessWidget {
  final String text;
  final String path;
  final VoidCallback? onPressed;
  const ButtonWithLeadIcon({
    Key? key,
    required this.text,
    required this.path,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                  child: Image.asset(
                path,
                width: 25,
                height: 25,
              )),
            ),
            Expanded(
              flex: 5,
              child: Text(text,
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  )),
            ),
          ],
        ),
        style: ElevatedButton.styleFrom(
          primary: AppColors.primaryColor,
          onPrimary: AppColors.lightBackgroundColor,
          padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
        ));
  }
}
