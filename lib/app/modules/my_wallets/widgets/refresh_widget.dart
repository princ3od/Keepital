import 'package:flutter/material.dart';

class RefreshWidget extends StatefulWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const RefreshWidget({Key? key, required this.onRefresh, required this.child}) : super(key: key);
  @override
  _RefreshWidgetState createState() => _RefreshWidgetState();
}

class _RefreshWidgetState extends State<RefreshWidget> {
  @override
  Widget build(BuildContext context) => buildAndroidList();

  Widget buildAndroidList() => RefreshIndicator(
        onRefresh: widget.onRefresh,
        child: widget.child,
      );
}
