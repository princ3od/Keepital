import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/core/values/asset_strings.dart';

class EventListItemCard extends StatelessWidget {
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
                  'Event name',
                  style: GoogleFonts.montserrat(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 178, right: 20),
                  child: InkWell(
                      splashColor: Colors.grey,
                      onTap: () {},
                      child: Icon(
                        Icons.edit,
                        size: 20,
                      )),
                ),
                InkWell(
                    splashColor: Colors.grey,
                    onTap: () {},
                    child: Icon(
                      Icons.delete,
                      size: 20,
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 34.0),
              child: Text('12/12/2021', style: Theme.of(context).textTheme.subtitle2),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 34.0),
                  child: Text('spending'.tr, style: Theme.of(context).textTheme.subtitle2),
                ),
                Text('1,000,000 vnd')
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
