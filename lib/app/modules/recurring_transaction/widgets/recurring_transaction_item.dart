import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/utils/image_view.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/core/values/assets.gen.dart';
import 'package:keepital/app/data/models/recurring_transaction.dart';

class RecurringTransactionItem extends StatefulWidget {
  const RecurringTransactionItem({required this.transaction, this.onMark, this.onEdit, this.onDelete});
  final RecurringTransaction transaction;
  final Function()? onMark;
  final Function()? onEdit;
  final Function()? onDelete;

  @override
  State<RecurringTransactionItem> createState() => _RecurringTransactionItemState();
}

class _RecurringTransactionItemState extends State<RecurringTransactionItem> {
  String get buttonText => widget.transaction.isMarkedFinished ? 'mark_as_unfinished'.tr : 'mark_as_finished'.tr;
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: isEmptyIconId ? Container(width: 32, child: Assets.inAppIconElectricityBill.image()) : ImageView(widget.transaction.category.iconId, size: 32),
                  ),
                  Text(
                    widget.transaction.category.name.tr,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ],
              ),
              Row(
                children: [
                  IconButton(onPressed: widget.onEdit, icon: Icon(Icons.edit), color: AppColors.textColor),
                  IconButton(onPressed: widget.onDelete, icon: Icon(Icons.delete), color: AppColors.textColor),
                ],
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 42.0),
            child: Text('Next occurrence:'.tr, style: Theme.of(context).textTheme.bodyText1),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 42.0),
            child: Text(widget.transaction.options.nextOcurrence().fullDate, style: Theme.of(context).textTheme.bodyText1),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 42.0, top: 10),
                child: Text('Amount'.tr, style: Theme.of(context).textTheme.headline4),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Text(widget.transaction.amount.money('\₫'), style: Theme.of(context).textTheme.headline4),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 42.0, top: 5.0),
            child: OutlinedButton(
              child: Text(buttonText),
              onPressed: () {
                widget.onMark?.call();
              },
            ),
          )
        ],
      ),
    ));
  }

  bool get isEmptyIconId => widget.transaction.category.iconId.isEmpty;
}
