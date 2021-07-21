import 'package:flutter_hooks/flutter_hooks.dart';

void useSimpleEffect(void Function() effect, [List<Object?>? keys]) =>
    useEffect(() {effect(); return null; }, keys);
