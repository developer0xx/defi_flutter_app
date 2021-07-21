import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/input/stateless_text_controller_wrapper.dart';
import 'package:sapiency_app/screen/wallet/state/wallet_page_state.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class WalletSearchPanel extends StatelessWidget {
  final WalletPageState state;

  const WalletSearchPanel({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
              offset: Offset(1, 1), //(x,y)
              blurRadius: 3.0,
            ),
          ],
        ),
      height: 60,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: state.searchPanelState.value ? _buildSearchOn() : _buildSearchOff(context),
      ),
    );
  }

  Widget _buildSearchOn() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: StatelessTextEditingControllerWrapper(
            onChanged: state.searchFieldState.onChanged,
            value: state.searchFieldState.value,
            child: (controller) => TextFormField(
              autofocus: true,
              controller: controller,
              style: AppText.subtitle,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        _buildIcon(AppImages.crossIcon),
      ],
    );
  }

  Widget _buildSearchOff(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(context.strings.wallet.search(tokens: state.wallets.length.toString()), style: AppText.subtitle),
        Spacer(),
        _buildIcon(AppImages.searchIcon),
      ],
    );
  }

  Widget _buildIcon(String path) {
    return GestureDetector(
      onTap: state.onSearchPanelToggle,
      child: SvgPicture.asset(path, height: 15),
    );
  }
}
