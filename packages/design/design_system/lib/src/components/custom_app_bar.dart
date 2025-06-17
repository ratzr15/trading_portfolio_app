import 'package:flutter/material.dart';

import '../dimens/dimens.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String? userAvatarUrl;
  final String languageCode;

  const CustomAppBar({
    required this.userName,
    this.userAvatarUrl,
    this.languageCode = 'EN',
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        children: [
          CircleAvatar(
            radius: Dimens.boxHeight,
            backgroundImage: userAvatarUrl != null
                ? NetworkImage(userAvatarUrl!)
                : AssetImage(
                    'assets/images/avatar.png',
                    package: 'design_system',
                  ) as ImageProvider,
          ),
          const SizedBox(width: Dimens.boxHeight / 2),
          Text(
            userName,
            style: const TextStyle(
              color: Colors.black,
              fontSize: FontSize.heading,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            languageCode,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: FontSize.subHeading,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
