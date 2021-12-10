import 'package:flutter/material.dart';
import 'package:keepital/app/core/values/app_colors.dart';
import 'package:keepital/app/core/values/assets.gen.dart';
import 'package:keepital/app/data/services/auth_service.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/global_widgets/user_avatar.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 16),
      child: Row(
        children: [
          Stack(
            children: [
              UserAvatar(
                user: AuthService.instance.currentUser!,
                size: 24,
                borderRadius: 24,
                borderWidth: 0,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: SizedBox(
                  width: 12,
                  height: 12,
                  child: CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: (AuthService.instance.loginType == SignInType.withGoogle) ? Assets.imagesGoogleLogo.image() : Assets.imagesFacebookLogo.image(),
                    ),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(width: 20),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthService.instance.currentUser!.displayName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  'User ID: ${AuthService.instance.currentUser?.uid ?? ''}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(color: AppColors.textColor.withOpacity(AppColors.disabledTextOpacity)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
