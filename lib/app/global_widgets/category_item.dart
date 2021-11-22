import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/data/models/category.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key, required this.category, this.onTap, this.selectedIndex, this.index}) : super(key: key);

  final Category category;
  final void Function(Category category)? onTap;
  final int? selectedIndex;
  final int? index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: category.iconId.isEmpty
          ? Image(
              image: AssetImage(AssetStringsPng.electricity_bill),
              height: 30,
            )
          : Image.asset(
              category.iconId,
              width: 30,
            ),
      title: Text(
        category.name,
        style: Theme.of(context).textTheme.headline6,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Visibility(
        child: Icon(Icons.check_circle, color: Theme.of(context).iconTheme.color),
        visible: isVisisble(),
      ),
      onTap: () {
        if (onTap != null) {
          onTap!(category);
        }
      },
    );
  }

  bool isVisisble() {
    return selectedIndex == index && selectedIndex != null;
  }
}
