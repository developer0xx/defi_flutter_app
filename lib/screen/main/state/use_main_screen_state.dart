import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/app/state/user/user_state.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';

class MainScreenState {
  final int tabIndex;
  final PublicUser user;
  final Function(int) onTabPressed;
  final Function() onActionButtonPressed;

  const MainScreenState({
    required this.tabIndex,
    required this.onTabPressed,
    required this.onActionButtonPressed,
    required this.user,
  });
}

MainScreenState useMainScreenState() {
  final userState = useProvided<UserState>();
  final tabIndexState = useState<int>(0);

  return MainScreenState(
    user: userState.user!.public,
    tabIndex: tabIndexState.value,
    onTabPressed: (int index) => tabIndexState.value = index,
    onActionButtonPressed: () {},
  );
}
