import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/model/user/public/public_user.dart';
import 'package:sapiency_app/service/user/user_service.dart';
import 'package:sapiency_app/util/hook/use_async_computed_state.dart';

class HomePageState {
  final List<PublicUserInfluencer>? users;
  final bool isInProgress;
  final Future<void> Function() refresh;

  const HomePageState({
    required this.users,
    required this.isInProgress,
    required this.refresh,
  });
}

HomePageState useHomePageState() {
  final userService = useInjected<UserService>();

  final usersState = useAsyncComputedState(
    compute: () async => await userService.obtainWithActiveCrowdsales(),
  );

  return HomePageState(
    users: usersState.value,
    isInProgress: usersState.isInProgress,
    refresh: () async => await usersState.refresh(),
  );
}
