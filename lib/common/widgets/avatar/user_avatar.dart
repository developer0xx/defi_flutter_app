import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_images.dart';

class UserAvatar extends StatelessWidget {
  final double size;
  final String? avatarUrl;
  final Function()? onTap;

  UserAvatar({
    this.size = 60,
    this.onTap,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.tight(Size(size, size)),
      child: InkResponse(
        onTap: onTap,
        child: _buildUserAvatarPhoto(context),
      ),
    );
  }

  Widget _buildAvatar() {
    if (avatarUrl == null) return Icon(Icons.person, color: AppColors.primary, size: size / 2.5);

    return ClipOval(
      child: CachedNetworkImage(
        height: size,
        width: size,
        useOldImageOnUrlChange: false,
        fit: BoxFit.cover,
        imageUrl: avatarUrl!,
        placeholder: (BuildContext context, String url) => Icon(Icons.person, color: AppColors.primary, size: size / 2),
      ),
    );
  }

  Widget _buildUserAvatarPhoto(BuildContext context) {
    return Card(
      color: AppColors.textPrimary,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(size * 2)),
      child: _buildAvatar(),
    );
  }
}
