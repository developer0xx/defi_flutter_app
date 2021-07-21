import 'package:sapiency_app/app/state/user/user_state.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';
import 'package:sapiency_app/config/config.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/model/price/precision/price_with_precision.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';
import 'package:sapiency_app/model/user/user.dart';
import 'package:sapiency_app/model/user/wallet/user_wallet.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';
import 'package:sapiency_app/util/hook/use_togglable_bool.dart';

class WalletPageState {
  final TogglableBoolState searchPanelState;
  final FieldState searchFieldState;
  final String walletsValue;
  final PublicUser user;
  final List<UserWallet> wallets;
  final Future<void> Function() onRefresh;
  final Function() onSearchPanelToggle;
  final Function(UserWallet wallet) onSendPressed;
  final Function() onReceivePressed;

  const WalletPageState({
    required this.onSearchPanelToggle,
    required this.searchFieldState,
    required this.searchPanelState,
    required this.wallets,
    required this.walletsValue,
    required this.onRefresh,
    required this.user,
    required this.onSendPressed,
    required this.onReceivePressed,
  });
}

WalletPageState useWalletPageState({
  required Function(UserWallet) navigateToSend,
  required Function() navigateToReceive,
  required Function() showComingSoonSnackBar,
}) {
  final config = useInjected<Config>();
  final userState = useProvided<UserState>();

  final searchPanelState = useTogglableBool(false);
  final searchFieldState = useFieldStateSimple();

  final walletsValue = userState.user!.wallets.estimate.toCashDisplay();
  final userWallets = userState.user!.wallets.items.values
      .where((element) => !['BTC', 'ETH'].contains(element.value.symbol))
      .toList();

  bool checkSearch(UserWallet wallet, String search) {
    if (wallet.value.symbol.toUpperCase().contains(search.toUpperCase())) return true;
    if (wallet is UserWalletUser) {
      final influencer = wallet.user.influencer;
      if (influencer.firstName.toUpperCase().contains(search.toUpperCase())) return true;
      if (influencer.lastName.toUpperCase().contains(search.toUpperCase())) return true;
    }
    return false;
  }

  List<UserWallet> buildWallets() {
    final searchValue = searchFieldState.value;

    if (searchValue.isEmpty) {
      return userWallets;
    } else {
      return userWallets.where((wallet) => checkSearch(wallet, searchValue)).toList();
    }
  }

  return WalletPageState(
    searchPanelState: searchPanelState,
    searchFieldState: searchFieldState,
    user: userState.user!.public,
    wallets: buildWallets(),
    walletsValue: walletsValue,
    onRefresh: userState.refresh,
    onSearchPanelToggle: () {
      searchPanelState.toggle();
      searchFieldState.onChanged('');
    },
    onSendPressed: (wallet) => config.isWalletEnabled ? navigateToSend(wallet) : showComingSoonSnackBar(),
    onReceivePressed: navigateToReceive,
  );
}
