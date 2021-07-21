import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/widgets/button/button.dart';
import 'package:sapiency_app/common/widgets/input/app_text_input.dart';
import 'package:sapiency_app/util/extension/extensions.dart';
import '../state/wallet_receive_screen_state.dart';

class WalletReceiveScreenView extends StatelessWidget {
  final WalletReceiveScreenState state;

  const WalletReceiveScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.wallet.receive.title, style: AppText.text2),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: AppValues.screenPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildAddressField(context),
            Spacer(flex: 2),
            _buildQrCode(),
            Spacer(flex: 4),
            _buildButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildQrCode() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: AppValues.bigBorderRadius),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: QrImage(
          data: state.addressState.value,
          version: QrVersions.auto,
          size: 200,
        ),
      ),
    );
  }

  Widget _buildAddressField(BuildContext context) {
    return AppTextInput(
      label: context.strings.wallet.receive.label.address,
      readOnly: true,
      state: state.addressState,
    );
  }

  Widget _buildButtons() {
    return Builder(builder: (context) {
      return Column(
        children: [
          Button(
            text: context.strings.wallet.receive.button.copy,
            buttonType: ButtonType.secondary,
            onPressed: () => state.onCopyPressed(context),
            padding: EdgeInsets.all(0),
          ),
          Button(
            text: context.strings.wallet.receive.button.share,
            onPressed: () => state.onSharePressed(),
          ),
        ],
      );
    });
  }
}
