import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/global_widgets/clickable_list_item.dart';
import 'package:keepital/app/global_widgets/section_panel.dart';
import 'package:keepital/app/global_widgets/textfield_with_icon_picker_item.dart';
import 'package:keepital/app/routes/pages.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreen createState() => _AddEventScreen();
}

class _AddEventScreen extends State<AddEventScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.grey[100],
          leading: IconButton(
            icon: Icon(
              Icons.close_sharp,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'add_event'.tr,
            style: Theme.of(context).textTheme.headline6,
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(primary: AppColors.primaryColor, textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
              onPressed: () {},
              child: Text("save".tr),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            SectionPanel(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextfieldWithIconPicker(
                    onPressed: () async {
                      final result = await Get.toNamed(Routes.selectIcon);
                    },
                    hintText: 'event_name'.tr,
                    textEditingController: TextEditingController(),
                  ),
                  ClickableListItem(
                    hintText: 'Ending date'.tr,
                    leading: Icon(Icons.calendar_today),
                    onPressed: () {},
                  ),
                  ClickableListItem(
                    hintText: 'Wallet name'.tr,
                    leading: Icon(FontAwesomeIcons.wallet),
                    onPressed: () {},
                  ),
                  ClickableListItem(
                    hintText: 'currency'.tr,
                    leading: Icon(
                      FontAwesomeIcons.dollarSign,
                    ),
                    text: '',
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
