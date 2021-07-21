import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/widgets/avatar/user_avatar.dart';
import 'package:sapiency_app/common/widgets/snackbar/snackbars.dart';
import 'package:sapiency_app/screen/wallet/state/wallet_page_state.dart';
import 'package:sapiency_app/screen/wallet/widgets/wallet_icon.dart';
import 'package:sapiency_app/screen/wallet/widgets/wallet_option_row.dart';
import 'package:sapiency_app/service/wallet/wallet_service.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';
import 'package:sapiency_app/util/extension/decimal_extension.dart';

class WalletInfoPanel extends StatelessWidget {
  final WalletPageState state;

  const WalletInfoPanel({Key? key, required this.state}) : super(key: key);

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
      child: SafeArea(
        child: Padding(
          padding: AppValues.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTopRow(),
              _buildCodeField(context),
              _buildWalletValueInfo(context),
              WalletOptionRow(state: state),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWalletValueInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0, top: 12.0),
            child: Text(
              context.strings.wallet.totalValue,
              style: AppText.label.copyWith(color: Colors.white),
            ),
          ),
          Text(
            state.walletsValue,
            style: AppText.title.copyWith(color: Colors.white, fontSize: 36, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildCodeField(BuildContext context) {
    final text = WalletService.encodeNickname(state.user.nickname);
    return Padding(
      padding: const EdgeInsets.only(top: 18.0, bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(3000),
        child: Container(
          height: 30,
          color: Colors.white.withOpacity(0.4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 16),
              Flexible(
                flex: 12,
                child: Text(
                  text,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.text.copyWith(color: Colors.white),
                ),
              ),
              Spacer(flex: 4),
              WalletIcon(
                iconPath: AppImages.copyIcon,
                size: 30,
                onPressed: () => FlutterClipboard.copy(text).then((value) => SnackBars.showCopied(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopRow() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Row(
        children: [
          UserAvatar(size: 40, avatarUrl: state.user.imageUrl),
          SizedBox(width: 4),
          Text(
            '@' + state.user.nickname,
            style: AppText.label.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
