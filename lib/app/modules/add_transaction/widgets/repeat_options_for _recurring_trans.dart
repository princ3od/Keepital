import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/global_widgets/clickable_list_item.dart';

class RepeatOptionsForRecurringTrans extends StatelessWidget {
  const RepeatOptionsForRecurringTrans({Key? key, required this.cycleLengthTextController, required this.numRepetitionsTextController, this.selectedUnitIndex = 0, this.selectedOptsIndex = 0, this.onUnitSelected, this.onOptsSelected, this.onFromDatePressed, this.onToDatePressed, this.fromDate, this.toDate}) : super(key: key);

  final TextEditingController cycleLengthTextController;
  final TextEditingController numRepetitionsTextController;
  final int selectedUnitIndex;
  final int selectedOptsIndex;
  final Function(int?)? onUnitSelected;
  final Function(int?)? onOptsSelected;
  final Function()? onFromDatePressed;
  final Function()? onToDatePressed;
  final String? fromDate;
  final String? toDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 1,
            child: Opacity(opacity: 0.7, child: Center(child: Icon(Icons.repeat))),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            flex: 7,
            child: Column(
              children: [
                Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Recurring every'.tr,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        IntrinsicWidth(
                          child: Container(
                            constraints: BoxConstraints(minWidth: 5, maxWidth: 100),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: cycleLengthTextController,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        DropdownButton(
                          value: selectedUnitIndex,
                          onChanged: onUnitSelected,
                          items: List.generate(
                              recurUnits.length,
                              (index) => DropdownMenuItem(
                                    child: Text(
                                      recurUnits[index],
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                    value: index,
                                  )),
                          underline: SizedBox(),
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'From',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                        width: 150,
                        child: ClickableListItem(
                          onPressed: () {
                            onFromDatePressed?.call();
                          },
                          leading: Image.asset(AssetStringsPng.calendar, color: Theme.of(context).iconTheme.color),
                          text: fromDate,
                          hintText: 'Date'.tr,
                        )),
                    Expanded(child: SizedBox()),
                  ],
                ),
                Row(
                  children: [
                    DropdownButton(
                      value: selectedOptsIndex,
                      onChanged: onOptsSelected,
                      items: List.generate(
                          recurOpts.length,
                          (index) => DropdownMenuItem(
                                child: Text(
                                  recurOpts[index],
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                value: index,
                              )),
                      underline: SizedBox(),
                    ),
                    Visibility(
                      visible: isNeededToShowEndDate,
                      child: Container(
                          width: 150,
                          child: ClickableListItem(
                            onPressed: () {
                              onToDatePressed?.call();
                            },
                            leading: Image.asset(AssetStringsPng.calendar, color: Theme.of(context).iconTheme.color),
                            text: toDate,
                            hintText: 'Date'.tr,
                          )),
                    ),
                    Visibility(
                      visible: isNeededToShowNumRepetitions,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: IntrinsicWidth(
                          child: Container(
                            constraints: BoxConstraints(minWidth: 5, maxWidth: 100),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: numRepetitionsTextController,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isNeededToShowNumRepetitions,
                      child: Text(
                        'times'.tr,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
  bool get isNeededToShowNumRepetitions => selectedOptsIndex == 2;
  bool get isNeededToShowEndDate => selectedOptsIndex == 1;
}
