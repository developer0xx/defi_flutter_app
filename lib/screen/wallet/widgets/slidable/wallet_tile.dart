import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/avatar/user_avatar.dart';
import 'package:sapiency_app/model/user/wallet/user_wallet.dart';
import 'package:sapiency_app/screen/wallet/state/wallet_page_state.dart';

class WalletTile extends HookWidget {
  final WalletPageState state;
  final UserWallet wallet;
  static const double slideValue = 180;

  WalletTile({required this.state, required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserAvatar(
            avatarUrl: wallet.map(
              user: (user) => user.user.imageUrl,
              crypto: (crypto) => crypto.cryptoCurrency!.imageUrl,
            ),
          ),
          SizedBox(width: 8),
          wallet.map(
            user: (wallet) => _buildTextWithSubtitle(
              wallet.userOrNull!.influencer.fullName,
              wallet.value.symbol,
              CrossAxisAlignment.start,
            ),
            crypto: (wallet) => _buildWithoutInfluencer(wallet.value.symbol),
          ),
          Spacer(),
          _buildTextWithSubtitle(
            wallet.value.toValueDisplay(),
            wallet.estimate.toCashDisplay(),
            CrossAxisAlignment.end,
          ),
        ],
      ),
    );
  }

  Widget _buildTextWithSubtitle(String title, String subtitle, CrossAxisAlignment alignment) {
    return Column(
      crossAxisAlignment: alignment,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: AppText.tileTitle),
        Text(subtitle, style: AppText.label.copyWith(color: AppColors.textParagraph)),
      ],
    );
  }

  Widget _buildWithoutInfluencer(String text) {
    return Text(text, style: AppText.tileTitle);
  }
}
