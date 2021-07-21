import 'package:decimal/decimal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/common/state/submit/use_submit_state.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/model/price/precision/price_with_precision.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';
import 'package:sapiency_app/screen/payment/payment_screen_result.dart';
import 'package:sapiency_app/service/payment/payment_service.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class CrowdsaleContributeBottomSheetState {
  final PriceWithPrecision tokenPrice;
  final FieldState amountFieldState;
  final String amountCurrency;
  final FieldState cashFieldState;
  final String cashCurrency;
  final bool isProceedEnabled;
  final bool isProceedLoading;
  final Function() onProceedPressed;

  const CrowdsaleContributeBottomSheetState({
    required this.tokenPrice,
    required this.amountFieldState,
    required this.amountCurrency,
    required this.cashFieldState,
    required this.cashCurrency,
    required this.isProceedEnabled,
    required this.isProceedLoading,
    required this.onProceedPressed,
  });
}

class _AmountAndCash {
  final String amount;
  final String cash;

  const _AmountAndCash({this.amount = '', this.cash = ''});

  get isValid => Decimal.tryParse(amount) != null && Decimal.tryParse(cash) != null;
}

CrowdsaleContributeBottomSheetState useCrowdsaleContributeBottomSheetState({
  required Function() close,
  required Future<PaymentScreenResult?> Function(String url) awaitPayment,
  required Function() showPaymentSuccessSnackbar,
  required Function() showPaymentErrorSnackbar,
  required PublicUserInfluencer user,
}) {
  final paymentService = useInjected<PaymentService>();

  final amountAndCashState = useState<_AmountAndCash>(_AmountAndCash());
  final tooMuchErrorState = useState<bool>(false);

  final crowdsale = user.crowdsaleOrNull ?? (throw StateError('User has no active crowdsale'));

  void updateAmount(String amount) {
    tooMuchErrorState.value = false;
    if (amount == '') {
      amountAndCashState.value = _AmountAndCash();
    } else if (amount != amountAndCashState.value.amount) {
      final amountValue = Decimal.tryParse(amount);
      final cash = amountValue != null
          ? crowdsale.price.copyWith(amount: amountValue * crowdsale.price.amount).toValueDisplay()
          : null;
      amountAndCashState.value = _AmountAndCash(
        amount: amount,
        cash: cash ?? amountAndCashState.value.cash,
      );
    }
  }

  void updateCash(String cash) {
    tooMuchErrorState.value = false;
    if (cash == '') {
      amountAndCashState.value = _AmountAndCash();
    } else if (cash != amountAndCashState.value.cash) {
      final cashValue = Decimal.tryParse(cash);
      final amount = cashValue != null
          ? crowdsale.toSale.copyWith(amount: cashValue / crowdsale.price.amount).toValueDisplay()
          : null;
      amountAndCashState.value = _AmountAndCash(
        amount: amount ?? amountAndCashState.value.amount,
        cash: cash,
      );
    }
  }

  bool validate() {
    final max = crowdsale.toSale.amount - crowdsale.sold.value.amount;
    final isTooMuch = Decimal.parse(amountAndCashState.value.amount) > max;
    tooMuchErrorState.value = isTooMuch;
    return !isTooMuch;
  }

  Future<void> awaitPaymentAndShowSnackbar(String url) async {
    await Future.delayed(Duration(milliseconds: 500));
    final result = await awaitPayment(url);
    if (result == PaymentScreenResult.success) showPaymentSuccessSnackbar();
    if (result == PaymentScreenResult.error) showPaymentErrorSnackbar();
  }

  final errorMessage =
      tooMuchErrorState.value ? (BuildContext context) => context.strings.crowdsale.sheet.tooMuchError : null;

  final amountFieldState = useFieldState(
    value: amountAndCashState.value.amount,
    onChanged: (amount) => updateAmount(amount),
    errorMessage: errorMessage,
  );
  final cashFieldState = useFieldState(
    value: amountAndCashState.value.cash,
    onChanged: (cash) => updateCash(cash),
    errorMessage: errorMessage,
  );

  final submitState = useSubmitStateSimple<String>(
    shouldSubmit: validate,
    performSubmit: () async => await paymentService.payment(
      token: user.influencer.token,
      quantity: Decimal.parse(amountAndCashState.value.amount),
    ),
    afterSubmit: (url) {
      close();
      awaitPaymentAndShowSnackbar(url);
    },
  );

  return CrowdsaleContributeBottomSheetState(
    tokenPrice: crowdsale.price,
    amountFieldState: amountFieldState,
    amountCurrency: user.influencer.token,
    cashFieldState: cashFieldState,
    cashCurrency: crowdsale.toRaise.symbol,
    isProceedEnabled: amountAndCashState.value.isValid && !submitState.isSubmitInProgress,
    isProceedLoading: submitState.isSubmitInProgress,
    onProceedPressed: () => submitState.onSubmitPressed(),
  );
}
