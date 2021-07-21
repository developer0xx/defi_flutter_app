import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/constants/app_images.dart';
import 'package:sapiency_app/common/constants/app_text.dart';
import 'package:sapiency_app/common/widgets/app_link.dart';
import 'package:sapiency_app/common/widgets/button/button.dart';
import 'package:sapiency_app/common/widgets/layout/bottom_sheet/app_bottom_sheet.dart';
import 'package:sapiency_app/common/widgets/layout/bottom_sheet/app_bottom_sheet_drag_bar.dart';
import 'package:sapiency_app/common/widgets/tile/app_switch_tile.dart';
import 'package:sapiency_app/screen/auth/sign_up/create_account/view/widgets/terms_bottom_sheet/state/use_auth_sign_up_create_account_terms_bottom_sheet_state.dart';
import 'package:sapiency_app/util/extension/context_extensions.dart';

class AuthSignUpCreateAccountTermsBottomSheetView extends StatelessWidget {
  final AuthSignUpCreateAccountTermsBottomSheetState state;

  const AuthSignUpCreateAccountTermsBottomSheetView({required this.state});

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
        _buildIcon(context),
        _buildTitle(context),
        _buildSubtitle(context),
        _buildTermList(context),
        _buildButton(context),
      ],
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SvgPicture.asset(AppImages.signUpLocker),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      context.strings.auth.signUp.createAccount.termsBottomSheet.title,
      style: AppText.title.copyWith(
        color: AppColors.textDarker,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.left,
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Text(
        context.strings.auth.signUp.createAccount.termsBottomSheet.subtitle,
        style: AppText.text.copyWith(color: AppColors.grey),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _buildTerm(
    BuildContext context, {
    required String termName,
    required Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8.0),
      child: Row(
        children: [
          Text(
            context.strings.auth.signUp.createAccount.termsBottomSheet.readOur,
            style: AppText.text.copyWith(color: AppColors.grey),
          ),
          AppLink(
            label: termName,
            onTap: onTap,
          ),
        ],
      ),
    );
  }

  Widget _buildTermList(BuildContext context) {
    return Column(
      children: [
        _buildTerm(
          context,
          termName: context.strings.auth.signUp.createAccount.termsBottomSheet.serviceTerms,
          onTap: state.onServiceTermsPressed,
        ),
        _buildTerm(
          context,
          termName: context.strings.auth.signUp.createAccount.termsBottomSheet.privacyPolicy,
          onTap: state.onPrivacyPolicyPressed,
        ),
        AppSwitchTile(
          state: state.marketingConcernsSwitcherState,
          title: Text(
            context.strings.auth.signUp.createAccount.termsBottomSheet.marketingConcerns,
            style: AppText.text.copyWith(color: AppColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Button(
        text: context.strings.auth.signUp.createAccount.termsBottomSheet.accept,
        onPressed: state.onAcceptPressed,
        enabled: state.isAcceptButtonEnabled,
      ),
    );
  }
}
