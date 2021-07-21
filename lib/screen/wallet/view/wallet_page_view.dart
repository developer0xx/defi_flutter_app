import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/screen/wallet/widgets/slidable/wallet_slidable.dart';
import 'package:sapiency_app/screen/wallet/widgets/wallet_info_panel.dart';
import 'package:sapiency_app/screen/wallet/widgets/wallet_search_panel.dart';

import '../state/wallet_page_state.dart';

class WalletPageView extends StatelessWidget {
  final WalletPageState state;

  const WalletPageView({required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => await state.onRefresh(),
        color: AppColors.primary,
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.all(0),
          children: [
            WalletInfoPanel(state: state),
            WalletSearchPanel(state: state),
            for (final wallet in state.wallets) WalletSlidable(state: state, wallet: wallet),
          ],
        ),
      ),
    );
  }
}
