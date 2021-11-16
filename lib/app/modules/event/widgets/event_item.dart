import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/data/models/event.dart';

class EventItem extends StatelessWidget {
  final Event event;
  const EventItem({required this.event});
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Image.asset(AssetStringsPng.event),
                ),
                Text(
                  event.name,
                  style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                Spacer(flex: 5),
                InkWell(
                    splashColor: Colors.grey,
                    onTap: () {},
                    child: Icon(
                      Icons.edit,
                      size: 25,
                    )),
                Spacer(
                  flex: 1,
                ),
                InkWell(
                    splashColor: Colors.grey,
                    onTap: () {},
                    child: Icon(
                      Icons.delete,
                      size: 25,
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 34.0),
              child: Text(DateFormat('dd/MM/yyyy').format(event.endDate), style: Theme.of(context).textTheme.subtitle2),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 34.0),
                  child: Text('spending'.tr, style: Theme.of(context).textTheme.subtitle2),
                ),
                Text(event.spending.toString() + " " + event.currencyId)
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              height: 55,
              child: OutlinedButton(
                child: Text('MARK AS COMPLETE'.tr),
                onPressed: () {
                  print('Received click');
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
