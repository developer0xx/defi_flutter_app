import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sapiency_app/common/constants/app_values.dart';
import 'package:sapiency_app/common/widgets/input/use_field_state.dart';

import '../../../util/widget/wrapper/stateless_text_controller_wrapper.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text.dart';

class AppCodeInput extends HookWidget {
  final ValueChanged<String>? onChanged;
  final FieldState state;
  final Stream<ErrorAnimationType>? errorStream;
  final int length;

  const AppCodeInput({
    Key? key,
    this.onChanged,
    this.errorStream,
    this.length = 4,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatelessTextEditingControllerWrapper(
      onChanged: state.onChanged,
      value: state.value,
      child: (controller) => Container(
        child: Padding(
          padding: EdgeInsets.only(top: 4, left: 16, right: 16),
          child: HookBuilder(
            builder: (context) => PinCodeTextField(
              boxShadows: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(1, 1), //(x,y)
                  blurRadius: 3.0,
                ),
              ],
              appContext: context,
              length: length,
              enableActiveFill: true,
              keyboardType: TextInputType.number,
              animationType: AnimationType.none,
              showCursor: false,
              obscureText: false,
              textStyle: AppText.text,
              onChanged: state.onChanged,
              errorAnimationController: useErrorController(),
              controller: controller,
              backgroundColor: Colors.transparent,
              pinTheme: PinTheme(
                fieldHeight: 46,
                fieldWidth: MediaQuery.of(context).size.width / (length * 1.5),
                shape: PinCodeFieldShape.box,
                inactiveFillColor: Colors.white,
                borderRadius: AppValues.smallBorderRadius,
                disabledColor: Colors.white,
                selectedFillColor: Colors.white,
                activeFillColor: Colors.white,
                activeColor: Colors.white,
                selectedColor:AppColors.primary,
                inactiveColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // bad API design of PinCodeTextField, requires StreamController.
  StreamController<ErrorAnimationType> useErrorController() {
    final errorController = useStreamController<ErrorAnimationType>(); // ignore: close_sinks
    useEffect(() {
      final subscription = errorStream?.listen((event) => errorController.add(event));
      return () => subscription?.cancel();
    }, [errorStream]);
    return errorController;
  }
}
