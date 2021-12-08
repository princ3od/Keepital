import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/data/services/localization_service.dart';
import 'package:keepital/app/modules/app_setting/setting_controller.dart';

class LanguagueButton extends StatefulWidget {
  const LanguagueButton({Key? key}) : super(key: key);

  @override
  _LanguagueButtonState createState() => _LanguagueButtonState();
}

class _LanguagueButtonState extends State<LanguagueButton> {
  final SettingController _settingController = Get.find<SettingController>();
  @override
  Widget build(BuildContext context) {
    var langText = {
      'vi': 'Tiếng Việt',
      'en': 'English (US)',
    };
    var langImage = {
      'vi': 'assets/images/vi.png',
      'en': 'assets/images/en.png',
    };
    return SizedBox(
        width: double.infinity,
        child: InkWell(
          onTap: () async {
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Column(
                  children: [
                    for (var item in langText.keys)
                      buildLang(langImage, langText, item, () async {
                        _settingController.defaultLanguage.value = item;
                        _settingController.saveSetting();
                        LocalizationService.changeLocale(item);
                        print(item);
                        Get.back();
                      }),
                  ],
                ),
              ),
            );
            setState(() {});
          },
          child: Obx(
            () => Text(
              "${langText[_settingController.defaultLanguage.value]}",
              textAlign: TextAlign.right,
            ),
          ),
        ));
  }

  Material buildLang(Map<String, String> langImage, Map<String, String> langText, String locale, Function onTap) {
    return Material(
      color: (_settingController.defaultLanguage.value == locale) ? AppColors.primaryColor.withOpacity(0.1) : Colors.transparent,
      child: InkWell(
        onTap: () async {
          await onTap();
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                child: ClipOval(
                  child: Image.asset(
                    langImage[locale] ?? 'assets/images/en.png',
                    fit: BoxFit.fitWidth,
                    width: 32,
                    height: 32,
                  ),
                ),
                radius: 16.0,
              ),
              SizedBox(width: 10),
              Text(
                "${langText[locale]}",
                style: GoogleFonts.nunitoSans(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
