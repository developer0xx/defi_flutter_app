import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/util/navigation/route_config.dart';
import './state/use_edit_profile_screen_state.dart';
import './view/edit_profile_screen_view.dart';

class EditProfileScreen extends HookWidget {
  static const route = '/profile/edit';
  static final routeConfig = RouteConfig.material(() => EditProfileScreen());

  @override
  Widget build(BuildContext context) {
    final state = useEditProfileScreenState();
    return EditProfileScreenView(state: state);
  }
}
