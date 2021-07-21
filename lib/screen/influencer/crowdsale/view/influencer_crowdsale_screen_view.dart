import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/date_picker/date_picker.dart';
import 'package:sapiency_app/common/widgets/input/app_text_input.dart';
import 'package:sapiency_app/common/widgets/input/date_input/date_input_helper.dart';
import 'package:sapiency_app/common/widgets/tile/app_switch_tile.dart';
import 'package:sapiency_app/screen/influencer/crowdsale/widget/influencer_crowdsale_info_card.dart';
import 'package:sapiency_app/screen/influencer/widget/influencer_view_layout.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

import '../influencer_crowdsale_screen.dart';
import '../state/influencer_crowdsale_screen_state.dart';

class InfluencerCrowdsaleScreenView extends StatelessWidget {
  final InfluencerCrowdsaleScreenState state;

  const InfluencerCrowdsaleScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return InfluencerViewLayout(
      title: context.strings.inf.crowdsale.title,
      subtitle: context.strings.inf.crowdsale.subtitle,
      progressTitle: context.strings.inf.crowdsale.progressTitle,
      step: InfluencerCrowdsaleScreen.step,
      child: _buildFields(context),
      onProceed: state.onProceed,
    );
  }

  Widget _buildFields(BuildContext context) {
    return Column(
      children: [
        AppSwitchTile(
          state: state.crowdsaleActiveState,
          title: Text(
            context.strings.inf.crowdsale.radioTitle,
            style: AppText.subtitle,
          ),
        ),
        if (state.crowdsaleActiveState.value) _buildContent(context),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 8),
        AppTextInput(
          state: state.toRaiseState,
          label: context.strings.inf.crowdsale.label.raise,
          linkText: context.strings.inf.crowdsale.information.raise,
          textInputAction: TextInputAction.next,
          onSubmitFocusChanged: state.toSaleState.requestFocus,
          keyboardType: TextInputType.number,
          suffixText: state.toRaiseCurrency,
        ),
        AppTextInput(
          state: state.toSaleState,
          label: context.strings.inf.crowdsale.label.tokens,
          linkText: context.strings.inf.crowdsale.information.tokens,
          keyboardType: TextInputType.number,
          suffixText: state.toSaleToken,
        ),
        AppTextInput(
            state: state.startDateState,
            label: context.strings.inf.crowdsale.label.start,
            linkText: context.strings.inf.crowdsale.information.start,
            keyboardType: TextInputType.number,
            hintText: DateHelper.dateFormat.toUpperCase(),
            inputFormatters: DateHelper.dateInputFormatter,
            readOnly: true,
            onTap: () async {
              final result = await DatePicker.show(context: context, type: DatePickerDataType.crowdsale);
              state.startDateState.onChanged(result);
            }),
        _buildInfoCards(context),
      ],
    );
  }

  Widget _buildInfoCards(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 20,
          child: InfluencerCrowdsaleInfoCard(
            title: context.strings.inf.crowdsale.duration,
            content: '${state.durationDays} days',
          ),
        ),
        Spacer(flex: 1),
        Flexible(
          flex: 20,
          child: InfluencerCrowdsaleInfoCard(
            title: context.strings.inf.crowdsale.tokenPrice,
            content: state.price?.toCashDisplay() ?? '?',
          ),
        ),
      ],
    );
  }
}
