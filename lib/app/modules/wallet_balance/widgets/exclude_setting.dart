import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepital/app/global_widgets/section_panel.dart';

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
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).size.width * 0.05),
        SectionPanel(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 1,
                child: Checkbox(
                  checkColor: Theme.of(context).backgroundColor,
                  activeColor: Theme.of(context).iconTheme.color!.withOpacity(0.7),
                  value: isChecked,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        isChecked = value;
                        widget.onTap(value);
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('exclude_label'.tr, style: Theme.of(context).textTheme.bodyText1),
                    Text(
                      'exclude_description'.tr,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Color.fromARGB(127, 0, 0, 0)),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
