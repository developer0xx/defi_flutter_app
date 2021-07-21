import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/app/state/user/user_state.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';

class ProfileScreenState {
  final bool isCurrentUser;
  final PublicUser user;
  final int tabIndex;
  final Function(int) onTabChanged;
  final Function() onEditTap;
  final Function() onTokenizeTap;

  const ProfileScreenState({
    required this.isCurrentUser,
    required this.user,
    required this.onEditTap,
    required this.onTokenizeTap,
    required this.onTabChanged,
    required this.tabIndex,
  });
}

ProfileScreenState useProfileScreenState({
  required PublicUser? user,
  required Function() navigateToEdit,
  required Function() navigateToInfluencerFlow,
}) {
  final userState = useProvided<UserState>();
  final thisUser = userState.user!.public;

  final tabState = useState<int>(0);

  return ProfileScreenState(
    user: user ?? thisUser,
    isCurrentUser: user == null || user.nickname == userState.user!.public.nickname,
    tabIndex: tabState.value,
    onTabChanged: (index) => tabState.value = index,
    onEditTap: navigateToEdit,
    onTokenizeTap: navigateToInfluencerFlow,
  );
}
