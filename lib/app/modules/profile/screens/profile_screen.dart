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
          title: Text('Profile'.tr),
          elevation: 0,
        ),
        body: Column(
          children: [
            const ProfileAvatar(),
            const SizedBox(height: 4),
            const Divider(),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 4),
                  ProfileTile(
                    title: 'My wallets'.tr,
                    action: () => Get.toNamed(Routes.myWallets),
                    iconData: Icons.account_balance_wallet,
                  ),
                  ProfileTile(
                    title: 'Categories'.tr,
                    action: () => Get.toNamed(Routes.categories),
                    iconData: Icons.category,
                  ),
                  ProfileTile(
                    title: 'Debts'.tr,
                    iconData: Icons.payment,
                  ),
                  ProfileTile(
                    title: 'Travel mode'.tr,
                    action: () {},
                    iconData: Icons.directions_car,
                  ),
                  ProfileTile(
                    title: 'Help & Support'.tr,
                    iconData: Icons.help,
                  ),
                  ProfileTile(
                    title: 'Settings'.tr,
                    iconData: Icons.settings,
                  ),
                  ProfileTile(
                    title: 'About'.tr,
                    iconData: Icons.info,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 32),
                    child: Divider(),
                  ),
                  ProfileTile(
                    title: 'Sign out'.tr,
                    textColor: Colors.red,
                    isShownTrailingIcon: false,
                    iconData: Icons.exit_to_app,
                    action: () => _controller.signOut(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
