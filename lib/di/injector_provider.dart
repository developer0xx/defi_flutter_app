import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:injector/injector.dart';
import 'package:sapiency_app/di/injector.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class InjectorProvider extends SingleChildStatelessWidget {
  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return HookBuilder(
        builder: (context) => Provider<Injector>.value(value: useMemoized(() => setupInjector()), child: child),
    );
  }
}
