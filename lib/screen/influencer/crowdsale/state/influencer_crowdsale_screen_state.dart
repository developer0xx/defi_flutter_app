import 'package:decimal/decimal.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/common/widgets/input/date_input/date_input_helper.dart';
import 'package:sapiency_app/common/widgets/input/input_validator.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/model/crowdsale/input/crowdsale_input.dart';
import 'package:sapiency_app/model/price/precision/price_with_precision.dart';
import 'package:sapiency_app/screen/influencer/flow/influencer_flow_state.dart';
import 'package:sapiency_app/service/crowdsale/computed/crowdsale_computed_data_service.dart';
import 'package:sapiency_app/util/extension/extensions.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';
import 'package:sapiency_app/util/hook/use_togglable_bool.dart';

class InfluencerCrowdsaleScreenState {
  final TogglableBoolState crowdsaleActiveState;
  final FieldState toRaiseState;
  final String toRaiseCurrency;
  final FieldState toSaleState;
  final String toSaleToken;
  final FieldState startDateState;
  final int durationDays;
  final PriceWithPrecision? price;
  final Function() onProceed;

  const InfluencerCrowdsaleScreenState({
    required this.crowdsaleActiveState,
    required this.toRaiseState,
    required this.toRaiseCurrency,
    required this.toSaleState,
    required this.toSaleToken,
    required this.startDateState,
    required this.durationDays,
    required this.price,
    required this.onProceed,
  });
}

InfluencerCrowdsaleScreenState useInfluencerCrowdsaleScreenState({
  required Function() navigateToDescription,
  required Function() navigateToSummary,
}) {
  final computedDataService = useInjected<CrowdsaleComputedDataService>();
  final flowState = useProvided<InfluencerFlowState>();
  final crowdsale = flowState.crowdsale;

  final crowdsaleActiveState = useTogglableBool(false);
  final toRaiseFieldState = useFieldStateSimple(initialValue: crowdsale?.toRaise?.amount.toString());
  final toSaleFieldState = useFieldStateSimple(initialValue: crowdsale?.toSale?.amount.toString());

  final startDateFieldState =
      useFieldStateSimple(initialValue: crowdsale != null ? DateHelper.formatDMY.format(crowdsale.startDate!) : null);

  final double maxRaise = 100000;
  final double maxSell = 21000000;

  final startDate = DateHelper.formatDMY.tryParseStrict(startDateFieldState.value);

  bool validate() {
    if (!crowdsaleActiveState.value) return true;

    final startDateError = startDateFieldState.validate((value) {
      final error = InputValidator.validateDateInput(value);
      if (error != null) return error;
      if (startDate!.difference(DateTime.now()).inDays < 14)
        return (context) => context.strings.inf.crowdsale.startDate.error;
    });

    final toRaiseError = toRaiseFieldState.validate((value) {
      if (InputValidator.validateRequiredInput(value) != null) return InputValidator.validateRequiredInput(value);
      if (double.parse(toRaiseFieldState.value) > maxRaise)
        return (context) => context.strings.inf.crowdsale.toRaise.rangeExceededError;
    });

    final toSaleError = toSaleFieldState.validate((value) {
      if (InputValidator.validateRequiredInput(value) != null) return InputValidator.validateRequiredInput(value);
      if (double.parse(toSaleFieldState.value) > maxSell)
        return (context) => context.strings.inf.crowdsale.toSale.rangeExceededError;
    });

    return startDateError == null && toRaiseError == null && toSaleError == null;
  }

  CrowdsaleInput buildCrowdsale() {
    return CrowdsaleInput(
      toRaise: Decimal.tryParse(toRaiseFieldState.value)?.let((it) => PriceWithPrecision.usd(it)),
      toSale: Decimal.tryParse(toSaleFieldState.value)
          ?.let((it) => PriceWithPrecision.token(flowState.influencer.token!, it)),
      startDate: startDate,
    );
  }

  onProceed() {
    if (!crowdsaleActiveState.value) {
      navigateToSummary();
    } else if (validate()) {
      flowState.onCrowdsaleUpdated(buildCrowdsale());
      navigateToDescription();
    }
  }

  final computedData = useMemoized(
    () => computedDataService.compute(buildCrowdsale()),
    [toRaiseFieldState.value, toSaleFieldState.value, startDateFieldState.value],
  );

  return InfluencerCrowdsaleScreenState(
    crowdsaleActiveState: crowdsaleActiveState,
    toRaiseState: toRaiseFieldState,
    toRaiseCurrency: 'USD',
    toSaleState: toSaleFieldState,
    toSaleToken: flowState.influencer.token!,
    startDateState: startDateFieldState,
    durationDays: computedData.days,
    price: computedData.price,
    onProceed: onProceed,
  );
}
