import 'package:decimal/decimal.dart';
import 'package:sapiency_app/model/user/wallet/user_wallet.dart';

class WalletSendConfirmationScreenArgs {
  //nick or email
  final String recipient;
  final Decimal amount;
  final String notes;
  final String tokenSymbol;

  WalletSendConfirmationScreenArgs({
    required this.recipient,
    required this.amount,
    required this.notes,
    required this.tokenSymbol,
  });
}
