import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/providers/exchange_rate_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/transactions/widgets/transaction_date_item.dart';
import 'package:tuple/tuple.dart';

class TransactionByCategoryContainer extends StatelessWidget {
  TransactionByCategoryContainer({Key? key, required this.transList}) : super(key: key);

  final List<TransactionModel> transList;

  @override
  Widget build(BuildContext context) {
    String nTrans = transList.length == 1 ? '${transList.length} ' + 'transaction'.tr : '${transList.length} ' + 'transactions'.tr;
    return Container(
      color: Theme.of(context).backgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              children: [
                transList[0].category.iconId.isEmpty
                    ? Image(
                        image: AssetImage(AssetStringsPng.electricity_bill),
                        height: 35,
                      )
                    : Image.asset(
                        "${transList[0].category.iconId}",
                        height: 35,
                      ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Text(
                            transList[0].category.name,
                            style: Theme.of(context).textTheme.headline5,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          nTrans,
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Theme.of(context).hintColor),
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
                Text(totalCalculation(transList).readable, style: Theme.of(context).textTheme.headline6),
              ],
            ),
          ),
          Divider(
            height: 2,
            color: Theme.of(context).dividerColor,
          ),
          ListView.builder(
              shrinkWrap: true,
              itemExtent: 55,
              physics: NeverScrollableScrollPhysics(),
              itemCount: transList.length,
              itemBuilder: (BuildContext context, int index) {
                return TransactionDateItem(
                  transaction: transList[index],
                );
              }),
        ],
      ),
    );
  }
}

num totalCalculation(List<TransactionModel> transList) {
  num total = 0;
  for (var trans in transList) {
    double rate = 1;
    if (isTotalWallet) {
      var fromCurrency = trans.currencyId;
      var toCurrency = DataService.currentUser!.currencyId;
      rate = ExchangeRate.getRate(fromCurrency, toCurrency);
    }

    if (trans.category.type == CategoryType.income) {
      total += trans.amount * rate;
    } else if (trans.category.type == CategoryType.expense) {
      total -= trans.amount * rate;
    }
  }
  return total;
}

bool get isTotalWallet => DataService.currentUser!.currentWallet == '';
