import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWithLeadIcon extends StatelessWidget {
  final String hint;
  final String imagePath;
  //final TextEditingController controller;
  const TextFieldWithLeadIcon({
    Key? key,
    required this.hint,
    required this.imagePath,
    //required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            child: Image.asset(imagePath),
            width: 30,
            height: 30,
          ),
        ),
        Flexible(
            flex: 5,
            child: TextFormField(
              decoration: InputDecoration(hintText: hint.tr, hintStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w400, fontSize: 14, color: Color.fromARGB(35, 0, 0, 0))),
            ))
      ],
    );
  }

}