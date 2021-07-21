import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/widgets/button/button.dart';
import 'package:sapiency_app/common/widgets/submit/submit_wrapper.dart';
import 'package:sapiency_app/common/widgets/tile/app_switch_tile.dart';
import 'package:sapiency_app/screen/wallet/subscreens/send/confirmation/state/use_wallet_send_confirmation_screen_state.dart';
import 'package:sapiency_app/util/extension/extensions.dart';

class WalletSendConfirmationScreenView extends StatelessWidget {
  final WalletSendConfirmationScreenState state;

  const WalletSendConfirmationScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return SubmitWrapper(
      state: state.submitState,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.strings.wallet.send.confirmation.title, style: AppText.text2),
          centerTitle: true,
          elevation: 0,
        ),
        body: ListView(
          padding: AppValues.screenPadding,
          children: [
            _buildInfoTile(
              label: context.strings.wallet.send.confirmation.label.recipient,
              content: state.args.recipient,
            ),
            _buildInfoTile(
              label: context.strings.wallet.send.confirmation.label.amount,
              content: state.args.amount.toString() + ' ' + state.args.tokenSymbol,
            ),
            _buildSwitchTile(context),
            _buildPolygonLogo(),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPolygonLogo() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0, top: 30),
      child: Image.asset(AppImages.polygonLogo, height: 40),
    );
  }

  Widget _buildSwitchTile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: AppSwitchTile(
        state: state.switchState,
        title: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: context.strings.wallet.send.confirmation.switchTitle1,
                style: AppText.label.copyWith(color: AppColors.textPrimary),
              ),
              TextSpan(
                text: context.strings.wallet.send.confirmation.switchTitle2,
                style: AppText.label.copyWith(color: AppColors.primary),
              ),
              TextSpan(
                text: context.strings.wallet.send.confirmation.switchTitle3,
                style: AppText.label.copyWith(color: AppColors.textPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile({required String label, required String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.label),
        Text(content, style: AppText.subtitle.copyWith(fontWeight: FontWeight.w500)),
        Divider(thickness: 0.5, height: 32),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return Button(
      text: context.strings.common.confirm,
      onPressed: state.submitState.onSubmitPressed,
      enabled: state.switchState.value,
    );
  }
}
