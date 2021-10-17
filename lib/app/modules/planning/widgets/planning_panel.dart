import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanningPanel extends StatelessWidget {
  String? txtTitle;
  Function()? action;
  late Icon icon;
  PlanningPanel({this.txtTitle, this.action, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 348,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            txtTitle ?? "",
            style: GoogleFonts.montserrat(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.ac_unit,
                size: 20,
              ),
              InkWell(
                child: Container(width: 20, height: 20, child: icon),
                onTap: action,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
