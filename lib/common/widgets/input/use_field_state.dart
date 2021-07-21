import 'package:flutter/cupertino.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sapiency_app/util/hook/use_simple_effect.dart';

class FieldState {
  final Function(String Function(BuildContext)?) onErrorChanged;
  final Function(String?) onChanged;

  final String value;
  final String Function(BuildContext)? errorMessage;
  final bool? isObscured;

  ///Note: should not contain focusChange ([FieldStates] should not be coupled), there is special field in [AppTextInput] - [onSubmitFocusRequest]
  final Function(String)? onSubmit;
  final FocusNode focusNode;
  final Function() requestFocus;
  final Function() onIsObscuredChanged;

  const FieldState({
    required this.onChanged,
    required this.value,
    required this.onIsObscuredChanged,
    required this.focusNode,
    required this.requestFocus,
    required this.errorMessage,
    required this.onErrorChanged,
    required this.isObscured,
    required this.onSubmit,
  });

  bool get isEmpty => value.isEmpty;

  bool get isNotEmpty => value.isNotEmpty;

  bool get hasError => errorMessage != null;

  set value(String value) => onChanged(value);

  set errorMessage(String Function(BuildContext)? value) => onErrorChanged(value);

  String Function(BuildContext)? validate(String Function(BuildContext)? Function(String value) validator) {
    final result = validator(value);
    errorMessage = result;
    return result;
  }

  Future<String Function(BuildContext)?> validateAsync(
      Future<String Function(BuildContext)?> Function(String value) validator) async {
    final result = await validator(value);
    errorMessage = result;
    return result;
  }
}

FieldState useFieldState({
  required String value,
  required Function(String) onChanged,
  String Function(BuildContext)? errorMessage,
  Function(String Function(BuildContext)?)? onErrorChanged,
  bool isObscurable = false,
  Function(String)? onSubmit,
}) {
  final isObscuredState = useState<bool?>(isObscurable ? true : null);
  final node = useFocusNode();
  final context = useContext();

  return FieldState(
    value: value,
    errorMessage: errorMessage,
    isObscured: isObscuredState.value,
    focusNode: node,
    onSubmit: onSubmit,
    requestFocus: () => FocusScope.of(context).requestFocus(node),
    onErrorChanged: (text) => onErrorChanged?.call(text),
    onIsObscuredChanged: () {
      if (isObscuredState.value != null) isObscuredState.value = !isObscuredState.value!;
    },
    onChanged: (value) => onChanged(value ?? ''),
  );
}

FieldState useFieldStateSimple({
  String? initialValue,
  Function(String)? onChanged,
  bool isObscurable = false,
  Function(String)? onSubmit,
}) {
  final state = useState<String>(initialValue ?? '');
  final errorState = useState<String Function(BuildContext)?>(null);

  return useFieldState(
    value: state.value,
    onChanged: (text) {
      if (onChanged != null) onChanged(text);
      state.value = text;
    },
    errorMessage: errorState.value,
    onErrorChanged: (text) => errorState.value = text,
    isObscurable: isObscurable,
    onSubmit: onSubmit,
  );
}
