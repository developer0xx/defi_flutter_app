import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/util/hook/use_togglable_bool.dart';

class AppSwitchTile extends StatelessWidget {
  final TogglableBoolState state;
  final Widget title;

  const AppSwitchTile({Key? key, required this.state, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSwitch(context),
        _buildText(),
      ],
    );
  }

  Widget _buildSwitch(BuildContext context) {
    return Switch(
      activeTrackColor: AppColors.primary,
      inactiveTrackColor: AppColors.lighter,
      activeColor: Colors.white,
      value: state.value,
      onChanged: (_) => state.toggle(),
    );
  }

  Widget _buildText() {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.only(top: 14.0),
        child: title,
      ),
    );
  }
}
