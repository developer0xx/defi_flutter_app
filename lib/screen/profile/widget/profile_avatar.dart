import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/avatar/user_avatar.dart';

class ProfileAvatar extends StatelessWidget {
  final String? url;
  final String? tokenName;
  final String name;

  const ProfileAvatar({Key? key, this.url, this.tokenName, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UserAvatar(avatarUrl: url, size: 70),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(name, style: AppText.textTitle),
            if (tokenName != null)
              Text(
                tokenName!,
                style: AppText.text.copyWith(color: AppColors.primary),
              ),
          ],
        )
      ],
    );
  }
}
