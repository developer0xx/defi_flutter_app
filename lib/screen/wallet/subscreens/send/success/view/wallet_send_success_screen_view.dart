import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/button/button.dart';
import 'package:sapiency_app/util/extension/extensions.dart';
import '../state/use_wallet_send_success_screen_state.dart';

class WalletSendSuccessScreenView extends StatelessWidget {
  final WalletSendSuccessScreenState state;

  const WalletSendSuccessScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              SizedBox(height: 16),
              Text(context.strings.wallet.send.success.title, style: AppText.subtitle),
              Spacer(flex: 2),
              _buildContent(context),
              Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(AppImages.transactionSuccessHandShake),
        Text(context.strings.wallet.send.success.text, style: AppText.textTitle),
        SizedBox(width: 16),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 200),
          child: Button(
            text: context.strings.wallet.send.success.button,
            onPressed: state.onProceed,
          ),
        ),
      ],
    );
  }
}
