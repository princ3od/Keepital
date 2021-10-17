import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlanningTile extends StatelessWidget {
  late IconData iconData;
  String? title;
  String? subtitle;
  Function()? action;

  PlanningTile(
      {required this.iconData, this.title, this.subtitle, this.action});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        height: 40,
        child: ListTile(
          leading: Icon(
            iconData,
            size: 30,
          ),
          title: Text(
            title ?? "",
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subtitle ?? "",
            style: GoogleFonts.montserrat(
              fontSize: 10,
              fontWeight: FontWeight.normal,
            ),
          ),
          trailing: InkWell(
            child: Icon(Icons.keyboard_arrow_right),
            onTap: action,
          ),
        ));
  }
}
