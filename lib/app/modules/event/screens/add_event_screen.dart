import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/global_widgets/clickable_list_item.dart';
import 'package:keepital/app/global_widgets/section_panel.dart';
import 'package:keepital/app/modules/event/widgets/text_feild_with_lead_icon.dart';

class AddEventScreen extends StatefulWidget {
  @override
  _AddEventScreen createState() => _AddEventScreen();
}

class _AddEventScreen extends State<AddEventScreen> {
  late DateTime pickedDate = new DateTime(1900);

  @override
  Widget build(BuildContext context) {
    var formatter = new DateFormat('yyyy-MM-dd');
    var dateNow = formatter.format(DateTime.now());
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
                  ClickableListItem(
                    onPressed: () {},
                    leading: Icon(
                      Icons.calendar_today,
                      color: Colors.black,
                    ),
                  ),
                  TextFieldWithLeadIcon(imagePath: AssetStringsPng.unknownCategory, hint: 'event_name'.tr),
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                            child: Image.asset(AssetStringsPng.calendar),
                            width: 30,
                            height: 30,
                          ),
                        ),
                        InkWell(
                          child: Text(
                            pickedDate == DateTime(1900) ? dateNow : formatter.format(pickedDate),
                            style: TextStyle(decoration: TextDecoration.underline),
                          ),
                          onTap: () {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1900), lastDate: DateTime(2100)).then((date) {
                              setState(() {
                                pickedDate = date!;
                              });
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  TextFieldWithLeadIcon(imagePath: AssetStringsPng.currency, hint: 'currency'.tr),
                ],
              ),
            ),
          ],
        ));
  }
}
