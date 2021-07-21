import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/model/auth/auth_status.dart';
import 'package:sapiency_app/util/hook/hook_state_provider_widget.dart';

class AuthState {
  final AuthStatus status;
  final Function(AuthStatus) changeStatus;

  const AuthState({required this.status, required this.changeStatus});

  set status(AuthStatus status) => changeStatus(status);
}

class AuthStateProvider extends HookStateProviderWidget<AuthState> {
  @override
  AuthState use() {
    final statusState = useState<AuthStatus>(AuthStatus.unknown);

    return AuthState(
      status: statusState.value,
      changeStatus: (status) => statusState.value = status,
    );
  }
}
