import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/widgets/avatar/user_avatar.dart';
import 'package:sapiency_app/screen/wallet/subscreens/send/state/use_wallet_send_screen_state.dart';
import 'package:sapiency_app/util/extension/extensions.dart';

class WalletSendScreenInfo extends StatelessWidget {
  final WalletSendScreenState state;

  const WalletSendScreenInfo({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.accent,
            AppColors.primary,
          ],
        ),
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: AppValues.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTitle(context),
            SizedBox(height: 16),
            _buildUserInfo(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        Text(context.strings.wallet.send.title, style: AppText.button),
        SizedBox(width: 50),
      ],
    );
  }

  Widget _buildUserInfo() {
    final wallet = state.wallet;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        UserAvatar(
          size: 50,
          avatarUrl: state.wallet.map(
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
    );
  }

  Widget _buildTextWithSubtitle(String title, String subtitle, CrossAxisAlignment alignment) {
    return Column(
      crossAxisAlignment: alignment,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title, style: AppText.text.copyWith(color: Colors.white)),
        Text(subtitle, style: AppText.label.copyWith(color: Colors.white)),
      ],
    );
  }

  Widget _buildWithoutInfluencer(String text) {
    return Text(text, style: AppText.text.copyWith(color: Colors.white));
  }
}
