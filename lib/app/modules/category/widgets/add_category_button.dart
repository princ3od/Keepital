import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddCategoryButton extends StatelessWidget {
  const AddCategoryButton({ Key? key, this.text, this.onTap }) : super(key: key);
  final String? text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.add, color: Theme.of(context).iconTheme.color,),
      title: Text(text ?? '', style: Theme.of(context).textTheme.button),
      onTap: onTap,
    );
  }
}