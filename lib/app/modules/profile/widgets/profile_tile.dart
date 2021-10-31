import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileTile extends StatelessWidget {
  String? title;
  Function()? action;

  ProfileTile({this.title, this.action});
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 350,
        height: 40,
        child: ListTile(
          title: Text(
            title ?? "",
            style: GoogleFonts.montserrat(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: InkWell(
            child: Icon(Icons.keyboard_arrow_right),
            onTap: action,
          ),
        ));
  }
}
