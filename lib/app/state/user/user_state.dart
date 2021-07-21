import 'package:sapiency_app/app/state/auth/auth_state.dart';
import 'package:sapiency_app/app/state/setup/setup_state.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:sapiency_app/model/auth/auth_status.dart';
import 'package:sapiency_app/model/user/input/user_input.dart';
import 'package:sapiency_app/model/user/user.dart';
import 'package:sapiency_app/service/user/user_service.dart';
import 'package:sapiency_app/util/hook/hook_state_provider_widget.dart';
import 'package:sapiency_app/util/hook/use_async_computed_state.dart';
import 'package:sapiency_app/util/hook/use_provided.dart';

class UserState {
  final User? user;
  final Future<User> Function(UserInput) update;
  final Future<User?> Function() refresh;

  const UserState({
    required this.user,
    required this.update,
    required this.refresh,
  });
}

class UserStateProvider extends HookStateProviderWidget<UserState> {
  @override
  UserState use() {
    final userService = useInjected<UserService>();
    final authState = useProvided<AuthState>();
    final setupState = useProvided<SetupState>();

    final userState = useAsyncComputedState<User>(
      compute: () async => await userService.obtainCurrent(),
      shouldCompute: () => authState.status == AuthStatus.authorized && setupState.isInitialized,
      keys: [authState.status, setupState.isInitialized],
    );

    Future<User> update(UserInput user) async {
      final updatedUser = await userService.update(user);
      userState.value = updatedUser;
      return updatedUser;
    }

    return UserState(
      user: userState.value,
      refresh: () => userState.refresh(),
      update: update,
    );
  }
}
