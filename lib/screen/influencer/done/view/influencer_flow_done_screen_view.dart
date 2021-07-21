import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/widgets/button/button.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';
import '../state/influencer_flow_done_screen_state.dart';

class InfluencerFlowDoneScreenView extends StatelessWidget {
  final InfluencerFlowDoneScreenState state;

  const InfluencerFlowDoneScreenView({required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppValues.screenPadding,
        child: Column(
          children: [
            _buildInfo(context),
            Flexible(flex: 1, child: Container()),
            Button(
              text: context.strings.inf.done.button,
              onPressed: state.onProceed,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Flexible(
      flex: 2,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(AppImages.influencerRegistrationDone),
            SizedBox(height: 24),
            Text(context.strings.inf.done.title, style: AppText.title),
            SizedBox(height: 16),
            Text(context.strings.inf.done.subtitle, style: AppText.subtitle, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
