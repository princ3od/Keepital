import 'package:flutter/material.dart';

class MyWalletsScreen extends StatefulWidget {
  const MyWalletsScreen({Key? key}) : super(key: key);

  @override
  _MyWalletsScreenState createState() => _MyWalletsScreenState();
}

class _MyWalletsScreenState extends State<MyWalletsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Text('My wallets screen'),
        ),
      ),
    );
  }
}
