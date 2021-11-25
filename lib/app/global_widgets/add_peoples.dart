import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AddPeoplesScreen extends StatefulWidget {
  AddPeoplesScreen({ Key? key, }) : super(key: key);

  @override
  State<AddPeoplesScreen> createState() => _AddPeoplesScreenState();
}

class _AddPeoplesScreenState extends State<AddPeoplesScreen> {
  String strPeoples = Get.arguments;
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    textController.text = strPeoples;
    return Scaffold(
      appBar: AddPeoplesTopBar(title: 'Add peoples'.tr, onSaveTap: () {
        Get.back<String>(result: textController.text);
      },),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(5),
            color: Theme.of(context).backgroundColor,
            child: TextField(
              controller: textController,
              style: Theme.of(context).textTheme.bodyText1!,
              decoration: InputDecoration(
                hintText: 'Type in names separated by comma (,)'.tr,
                hintStyle: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 2),
                  child: Text('suggest_label'.tr, style: Theme.of(context).textTheme.bodyText2),
                ),
                Text('You can type in peoples who pay with you in this transaction'.tr, style: Theme.of(context).textTheme.subtitle1,),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class AddPeoplesTopBar extends StatelessWidget implements PreferredSizeWidget {
  AddPeoplesTopBar({Key? key, this.onSaveTap, required this.title})
      : size = Size.fromHeight(55),
        super(key: key);

  final Size size;
  final Function()? onSaveTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
      actions: [
        TextButton(onPressed: onSaveTap, child: Text('save'.tr), style: Theme.of(context).textButtonTheme.style,)
      ],
    );
  }

  @override
  Size get preferredSize => size;
}