import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/theme/app_theme.dart';
import 'package:keepital/app/modules/profile/profile_controller.dart';
import 'package:keepital/app/modules/profile/widgets/profile_avatar.dart';
import 'package:keepital/app/modules/profile/widgets/profile_tile.dart';
import 'package:keepital/app/routes/pages.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final _controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.currentTheme.backgroundColor,
        appBar: AppBar(
          title: Text(
            'Profile'.tr,
            style:
                Theme.of(context).textTheme.headline2?.copyWith(fontSize: 20),
          ),
          elevation: 0,
        ),
        body: Container(
          child: Center(
            child: Column(
              children: [
                ProfileAvatar(controller: _controller),
                SizedBox(
                  height: 8,
                ),
                ProfileTile(
                  title: 'My wallets'.tr,
                  action: () {},
                ),
                ProfileTile(
                  title: 'Categories'.tr,
                  action: () {
                    Get.toNamed(Routes.categories);
                  },
                ),
                ProfileTile(
                  title: 'Debts'.tr,
                ),
                ProfileTile(
                  title: 'Travel mode'.tr,
                  iconData: Icons.access_alarm,
                  action: () {},
                ),
                ProfileTile(
                  title: 'Help & Support'.tr,
                ),
                ProfileTile(
                  title: 'Settings'.tr,
                ),
                ProfileTile(
                  title: 'About'.tr,
                ),
                Container(
                    width: 350,
                    child: Divider(
                      thickness: 1,
                    )),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        child: Text(
                          'Sign out'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(color: Colors.red),
                        ),
                        onTap: () {
                          print('object');
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
