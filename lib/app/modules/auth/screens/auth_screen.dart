import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:get/get.dart';



class AuthenticationScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,0,30),
              child: Container(
                child: Image.asset(AssetStringsPng.logo),
                width: 100,
                height: 100,
              ),
            ),
            Text("Keeptial", style: GoogleFonts.montserrat(fontSize: 28, fontWeight: FontWeight.bold),),
            AnimatedTextKit(totalRepeatCount: 10, animatedTexts: [
              TyperAnimatedText('for money for life', textStyle: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.normal)),
            ]),
            Container(
              child: SvgPicture.asset(AssetStringsSvg.financialGoal),
              width: 400,
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20 ),
              child: Text("inspirational".tr,style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.normal)),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10,bottom: 10),
              child: ButtonWithLeadIcon(
                  onPressed: () =>{},
                  text: 'login_google'.tr,
                  path:AssetStringsPng.googleLogo),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ButtonWithLeadIcon(
                  onPressed: () =>{},
                  text: 'login_facebook'.tr,
                  path:AssetStringsPng.facebookLogo),
            )
          ],
        ),
      ),
    );
  }
}
class ButtonWithLeadIcon extends StatelessWidget {
  final String text;
  final String path;
  final VoidCallback? onPressed;
  const ButtonWithLeadIcon({
    Key ?key,
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
  