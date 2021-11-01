import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/core/values/asset_strings.dart';

class UserAvatar extends StatelessWidget {
  final User user;
  final int size;
  const UserAvatar({
    Key? key,
    required this.user,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        border: Border.all(
          color: AppColors.textColor,
          width: 0.8,
        ),
      ),
      child: CircleAvatar(
        backgroundColor: Colors.white60,
        radius: size * 1.0,
        child: ClipOval(
          child: FadeInImage.assetNetwork(
            fadeInDuration: Duration(milliseconds: 200),
            fadeOutDuration: Duration(milliseconds: 180),
            image: this.user.photoURL ?? '',
            width: 85,
            height: 85,
            fit: BoxFit.cover,
            placeholder: AssetStringsPng.gooogleLogo,
          ),
        ),
      ),
    );
  }
}
