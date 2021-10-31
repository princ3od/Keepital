import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keepital/app/core/theme/app_theme.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/profile/profile_controller.dart';
import 'package:keepital/app/modules/profile/widgets/profile_tile.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final _controller = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.currentTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Profile'.tr,
          style: Theme.of(context).textTheme.headline1,
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 0,
                ),
                Material(
                  elevation: 1,
                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        child: Row(
                          children: [
                            SizedBox(width: 10.0),
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 30.0,
                                  backgroundImage: NetworkImage(_controller.currentUser?.photoURL ?? ""),
                                  backgroundColor: Colors.transparent,
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 20,
                                  child: Container(
                                    height: 20,
                                    child: CircleAvatar(
                                      radius: 30.0,
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: (_controller.loginType == SignInType.withGoogle) ? Image.asset(AssetStringsPng.gooogleLogo) : Image.asset(AssetStringsPng.facebookLogo),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(_controller.currentUser?.displayName ?? "", style: Theme.of(context).textTheme.headline2),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
                ProfileTile(
                  title: 'My wallets'.tr,
                  action: () {},
                ),
                ProfileTile(
                  title: 'Categories'.tr,
                ),
                ProfileTile(
                  title: 'Debts'.tr,
                ),
                ProfileTile(
                  title: 'Travel mode'.tr,
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
                Container(width: 350, child: Divider()),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    SizedBox(width: 45.0),
                    InkWell(
                      child: Text(
                        'Sign out'.tr,
                        style: Theme.of(context).textTheme.headline6?.copyWith(color: Colors.red),
                      ),
                      onTap: () {
                        print('object');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
