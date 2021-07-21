import 'package:easy_mask/easy_mask.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sapiency_app/common/widgets/date_picker/date_picker.dart';
import 'package:sapiency_app/common/widgets/input/app_text_input.dart';
import 'package:sapiency_app/common/widgets/input/date_input/app_date_input.dart';
import 'package:sapiency_app/common/widgets/input/date_input/date_input_helper.dart';
import 'package:sapiency_app/screen/influencer/widget/influencer_view_layout.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';
import '../influencer_info_screen.dart';
import '../state/influencer_info_screen_state.dart';

class InfluencerInfoScreenView extends StatelessWidget {
  final InfluencerInfoScreenState state;

  const InfluencerInfoScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return InfluencerViewLayout(
      title: context.strings.inf.personalInfo.title,
      subtitle: context.strings.inf.personalInfo.subtitle,
      progressTitle: context.strings.inf.personalInfo.progressTitle,
      step: InfluencerInfoScreen.step,
      child: _buildFields(context),
      onProceed: state.onProceed,
    );
  }

  Widget _buildFields(BuildContext context) {
    return Column(
      children: [
        AppTextInput(
          state: state.nameFieldState,
          label: context.strings.inf.personalInfo.label.name,
          textInputAction: TextInputAction.next,
          onSubmitFocusChanged: state.surnameFieldState.requestFocus,
        ),
        AppTextInput(
          state: state.surnameFieldState,
          label: context.strings.inf.personalInfo.label.surname,
        ),
        AppTextInput(
          state: state.birthdayFieldState,
          label: context.strings.inf.personalInfo.label.birthday,
          keyboardType: TextInputType.number,
          hintText: DateHelper.dateFormat.toUpperCase(),
          inputFormatters: DateHelper.dateInputFormatter,
          readOnly: true,
          onTap: () async {
            final result = await DatePicker.show(context: context, type: DatePickerDataType.birthday);
            state.birthdayFieldState.onChanged(result);
          },
        ),
      ],
    );
  }
}
