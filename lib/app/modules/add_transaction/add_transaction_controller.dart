import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/utils/utils.dart';
import 'package:keepital/app/core/values/assets.gen.dart';
import 'package:keepital/app/data/models/base_model.dart';
import 'package:keepital/app/data/models/event.dart';
import 'package:keepital/app/data/models/transaction.dart';
import 'package:keepital/app/data/models/category.dart';
import 'package:keepital/app/data/models/recurring_transaction.dart';
import 'package:keepital/app/data/models/repeat_options.dart';
import 'package:keepital/app/data/models/wallet.dart';
import 'package:keepital/app/data/providers/recurring_transaction_provider.dart';
import 'package:keepital/app/data/services/data_service.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/routes/pages.dart';

class AddTransactionController extends GetxController {
  AddTransactionController() {
    walletId = currentWallet.obs;
    walletName = (wallets[walletId]?.name ?? '').obs;
  }

  final amountTextController = TextEditingController();
  final noteTextController = TextEditingController();
  final cycleLengthTextController = TextEditingController(text: '1');
  final numRepetitionsTextController = TextEditingController(text: '1');

  Category? category;
  var strCategory = ''.tr.obs;
  RxString categoryIconId = Assets.iconsUnknown.path.obs;

  var date = DateTime.now();
  late var strDate = date.fullDate.obs;

  late RxString walletId;
  late RxString walletName;

  Rx<List<String>?> peoples = Rx<List<String>?>([]);

  Event? event;
  var strEvent = ''.tr.obs;

  DateTime startDate = DateTime.now();
  late var strStartDate = startDate.fullDate.obs;
  DateTime? endDate;
  late var strEndDate = ''.obs;

  RxInt selectedUnitIndex = 0.obs;
  RxInt selectedOptsIndex = 0.obs;

  RxBool excludeFromReport = false.obs;

  Future createNewTrans() async {
    num amount = num.tryParse(amountTextController.text)!;
    String note = noteTextController.text;

    amount = category!.type == CategoryType.income ? amount : -amount;

    var trans = await addTransaction(amount, note);

    onAddTransactionClosed(trans);
  }

  Future modifyTrans(TransactionModel oldTrans) async {
    num amount = num.tryParse(amountTextController.text)!;
    String note = noteTextController.text;

    amount = category!.type == CategoryType.income ? amount : -amount;
    num diff = amount - oldAmount;

    var modTrans = await updateTransaction(oldTrans, amount, note, diff);

    onEditTransactionClosed(modTrans);
  }

  Future createNewRecurringTrans() async {
    num amount = num.tryParse(amountTextController.text)!;
    String note = noteTextController.text;

    var wallet = wallets[walletId]!;
    var repeatOpts = RepeatOptions(id: selectedOptsIndex.value, startDate: startDate, cycleLength: int.parse(cycleLengthTextController.text), recurUnitId: selectedUnitIndex.value, numRepetition: int.parse(numRepetitionsTextController.text), endDate: endDate);
    var trans = RecurringTransaction('', category: category!, currencyId: wallet.currencyId, isMarkedFinished: false, amount: amount, options: repeatOpts, note: note, walletId: wallet.id, excludeFromReport: excludeFromReport.value);
    trans = await RecurringTransactionProvider().addToWallet(trans, walletId.value);

    onRecurringTransClosed(trans);
  }

  Future modifyRecurringTrans(RecurringTransaction old) async {
    num amount = num.tryParse(amountTextController.text)!;
    String note = noteTextController.text;

    var repeatOpts = RepeatOptions(id: selectedOptsIndex.value, startDate: startDate, cycleLength: int.parse(cycleLengthTextController.text), recurUnitId: selectedUnitIndex.value, numRepetition: int.parse(numRepetitionsTextController.text), endDate: endDate);
    var trans = RecurringTransaction(old.id, category: category!, currencyId: old.currencyId, isMarkedFinished: old.isMarkedFinished, amount: amount, options: repeatOpts, note: note, walletId: old.walletId, excludeFromReport: excludeFromReport.value);
    trans = await RecurringTransactionProvider().update(trans.id!, trans);

    onRecurringTransClosed(trans);
  }

  Future<TransactionModel> updateTransaction(TransactionModel oldTrans, num amount, String note, num diff) async {
    var wallet = wallets[walletId]!;
    var modTrans = TransactionModel(oldTrans.id, walletId: oldTrans.walletId, amount: amount.abs(), category: category!, currencyId: wallet.currencyId, date: date, note: note, contact: listToString(peoples.value), excludeFromReport: excludeFromReport.value, eventId: event?.id);
    await DataService.modifyTransaction(modTrans, diff);
    return modTrans;
  }

  Future<TransactionModel> addTransaction(num amount, String note) async {
    var wallet = wallets[walletId]!;
    var trans = TransactionModel(null, amount: amount.abs(), category: category!, currencyId: wallet.currencyId, date: date, note: note, contact: listToString(peoples.value), excludeFromReport: excludeFromReport.value, walletId: walletId.value, eventId: event?.id);
    trans = await DataService.addTransaction(trans);
    return trans;
  }

  void onSelectCategory(Category? category) {
    strCategory.value = category?.name ?? '';
    categoryIconId.value = category?.iconId ?? Assets.iconsUnknown.path;
    if (categoryIconId.value.isEmpty) categoryIconId.value = Assets.inAppIconElectricityBill.path;
    this.category = category;
  }

  void onLoadData(BaseModel trans) {
    if (isEditingTrans) {
      onEditTransLoad(trans as TransactionModel);
    } else if (isEditingRecuringTrans) {
      onEditRecurringTrans(trans as RecurringTransaction);
    }
  }

  void onEditTransLoad(TransactionModel trans) {
    oldAmount = trans.category.type == CategoryType.income ? trans.amount : -trans.amount;
    amountTextController.text = trans.amount.toString();

    category = trans.category;
    strCategory.value = category?.name ?? '';
    categoryIconId.value = category?.iconId ?? Assets.iconsUnknown.path;
    if (categoryIconId.value.isEmpty) categoryIconId.value = Assets.inAppIconElectricityBill.path;

    noteTextController.text = trans.note ?? '';

    date = trans.date;
    strDate.value = date.fullDate;

    walletId.value = trans.walletId ?? '';
    walletName.value = wallets[walletId]?.name ?? '';

    peoples.value = stringToList(trans.contact);

    excludeFromReport.value = trans.excludeFromReport;
  }

  void onEditRecurringTrans(RecurringTransaction trans) {
    oldAmount = trans.category.type == CategoryType.income ? trans.amount : -trans.amount;
    amountTextController.text = trans.amount.toString();

    category = trans.category;
    strCategory.value = category?.name ?? '';
    categoryIconId.value = category?.iconId ?? Assets.iconsUnknown.path;
    if (categoryIconId.value.isEmpty) categoryIconId.value = Assets.inAppIconElectricityBill.path;

    noteTextController.text = trans.note ?? '';

    walletId.value = trans.walletId ?? '';
    walletName.value = wallets[walletId]?.name ?? '';

    cycleLengthTextController.text = trans.options.cycleLength.toString();
    numRepetitionsTextController.text = (trans.options.numRepetition ?? 1).toString();
    startDate = trans.options.startDate;
    strStartDate.value = startDate.fullDate;
    endDate = trans.options.endDate;
    strEndDate.value = endDate?.fullDate ?? '';
    selectedUnitIndex.value = trans.options.recurUnitId;
    selectedOptsIndex.value = trans.options.id;

    excludeFromReport.value = trans.excludeFromReport;
  }

  void onAddTransactionClosed(TransactionModel transaction) {
    Get.back(result: transaction);
  }

  void onEditTransactionClosed(TransactionModel modTrans) {
    Get.back(result: modTrans);
  }

  void onRecurringTransClosed(RecurringTransaction trans) {
    Get.back(result: trans);
  }

  num oldAmount = 0;

  String get totalCurrencyId => DataService.currentUser!.currencyId;
  String get currentWallet => DataService.currentUser!.currentWallet;
  Map<String, Wallet> get wallets => DataService.currentUser!.wallets;
}

bool get isEditing => isEditingTrans || isEditingRecuringTrans;
bool get isEditingTrans => Get.currentRoute == Routes.editTransaction;
bool get isEditingRecuringTrans => Get.currentRoute == Routes.editRecurringTransaction;
bool get isAddRecurringTrans => Get.currentRoute == Routes.addRecurringTransaction;
bool get isRecurringTrans => isEditingRecuringTrans || isAddRecurringTrans;
