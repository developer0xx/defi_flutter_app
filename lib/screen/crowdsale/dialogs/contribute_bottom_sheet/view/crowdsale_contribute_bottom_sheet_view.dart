import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/button/button.dart';
import 'package:sapiency_app/common/widgets/input/app_text_input.dart';
import 'package:sapiency_app/common/widgets/layout/bottom_sheet/app_bottom_sheet.dart';
import 'package:sapiency_app/common/widgets/layout/bottom_sheet/app_bottom_sheet_drag_bar.dart';
import 'package:sapiency_app/screen/crowdsale/dialogs/contribute_bottom_sheet/state/crowdsale_contribute_bottom_sheet_state.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class CrowdsaleContributeBottomSheetView extends StatelessWidget {
  final CrowdsaleContributeBottomSheetState state;

  const CrowdsaleContributeBottomSheetView({required this.state});

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet(builder: (context) => _buildContent(context));
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBottomSheetDragBar(),
        _buildTitle(context),
        _buildFields(context),
        _buildButton(context),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        children: [
          Text(context.strings.crowdsale.sheet.title, style: AppText.textTitle),
          Spacer(),
          Text(context.strings.crowdsale.sheet.tokenPrice, style: AppText.text2),
          SizedBox(width: 10),
          Text(state.tokenPrice.toCashDisplay(), style: AppText.text2.copyWith(color: AppColors.primary)),
        ],
      ),
    );
  }

  Widget _buildFields(BuildContext context) {
    return Column(
      children: [
        AppTextInput(
          state: state.amountFieldState,
          label: context.strings.crowdsale.sheet.label.amount,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.number,
          onSubmitFocusChanged: state.cashFieldState.requestFocus,
        ),
        AppTextInput(
          state: state.cashFieldState,
          label: context.strings.crowdsale.sheet.label.price,
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Button(
        text: context.strings.crowdsale.sheet.button,
        enabled: state.isProceedEnabled,
        loading: state.isProceedLoading,
        onPressed: state.onProceedPressed,
      ),
    );
  }
}
