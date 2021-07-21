import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

abstract class HookStateProviderWidget<T> extends SingleChildStatelessWidget {
  T use();

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    return HookBuilder(builder: (context) => Provider<T>.value(value: use(), child: child));
  }
}
