import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoryContainer extends StatelessWidget {
  const CategoryContainer({Key? key, required this.parent, this.children}) : super(key: key);

  final Widget parent;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.all(0),
        title: parent,
        subtitle: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: children ??
                    [
                      SizedBox(
                        height: 0,
                      )
                    ],
              ),
            ),
            Divider()
          ],
        ));
  }
}
