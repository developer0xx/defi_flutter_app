import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/screen/home/state/home_page_state.dart';
import 'package:sapiency_app/screen/home/view/home_page_view.dart';

class HomePage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = useHomePageState();
    return HomePageView(state: state);
  }
}
