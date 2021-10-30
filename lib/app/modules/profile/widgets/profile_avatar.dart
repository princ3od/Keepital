import 'package:flutter/material.dart';
import 'package:keepital/app/core/values/asset_strings.dart';
import 'package:keepital/app/enums/app_enums.dart';
import 'package:keepital/app/modules/profile/profile_controller.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    Key? key,
    required ProfileController controller,
  })  : _controller = controller,
        super(key: key);

  final ProfileController _controller;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      child: Container(
          height: 60,
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 32.0),
                  Stack(
                    children: [
                      SizedBox(
                        height: 28,
                        width: 28,
                        child: CircleAvatar(
                          radius: 30.0,
                          backgroundImage: NetworkImage(_controller.currentUser?.photoURL ?? ""),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 20,
                        child: SizedBox(
                          width: 10,
                          height: 10,
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
                  Text(_controller.currentUser?.displayName ?? "", style: Theme.of(context).textTheme.headline3?.copyWith(fontSize: 12)),
                ],
              ),
            ],
          )),
    );
  }
}
