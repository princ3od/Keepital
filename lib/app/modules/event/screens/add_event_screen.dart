import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/data/models/event.dart';
import 'package:keepital/app/global_widgets/clickable_list_item.dart';
import 'package:keepital/app/global_widgets/section_panel.dart';
import 'package:keepital/app/global_widgets/textfield_with_icon_picker_item.dart';
import 'package:keepital/app/modules/event/add_event_controller.dart';

class AddEventScreen extends StatelessWidget {
  final Event? editEvent;
  AddEventScreen({this.editEvent});
  @override
  Widget build(BuildContext context) {
    final _controller = Get.put(AddEventController(editEvent));
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.close_sharp,
              color: AppColors.textColor,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text('add_event'.tr),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(primary: AppColors.textColor, textStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
              onPressed: () => _controller.save(context),
              child: Text("save".tr),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
            Obx(
              () => SectionPanel(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextfieldWithIconPicker(
                      iconId: _controller.eventIcon.value,
                      onPressed: () => _controller.selectIcon(context),
                      hintText: 'event_name'.tr,
                      textEditingController: _controller.eventNameController,
                    ),
                    ClickableListItem(
                      hintText: 'Ending date'.tr,
                      text: _controller.endDate.value.fullDate,
                      leading: Icon(Icons.calendar_today),
                      onPressed: () => _controller.selectEndDate(context),
                    ),
                    ClickableListItem(
                      hintText: 'currency'.tr,
                      leading: Icon(
                        FontAwesomeIcons.dollarSign,
                      ),
                      text: _controller.currencyName.value,
                      onPressed: () => _controller.selectCurrency(context),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
