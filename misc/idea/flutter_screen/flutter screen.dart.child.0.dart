#set($camelcase_name = ${StringUtils.removeAndHump(${NAME})})
import 'package:flutter/widgets.dart';

import '../state/${NAME}_state.dart';

class ${camelcase_name}View extends StatelessWidget {
  final ${camelcase_name}State state;
  
  const ${camelcase_name}View({required this.state});
  
  @override
  Widget build(BuildContext context) {
    return;
  }
}