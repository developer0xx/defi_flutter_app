import 'package:flutter/material.dart';
import 'package:sapiency_app/common/constants/app_colors.dart';
import 'package:sapiency_app/common/widgets/input/date_input/date_input_helper.dart';

enum DatePickerDataType { birthday, crowdsale }

class DatePickerData {
  static final DateTime _now = DateTime.now();
  final DateTime initial;
  final DateTime first;
  final DateTime last;
  final DatePickerDataType type;

  DatePickerData._({
    required this.initial,
    required this.first,
    required this.last,
    required this.type,
  });

  static final birthday = DatePickerData._(
    initial: DateTime(_now.year - 13, _now.month, _now.day),
    first: DateTime(_now.year - 100, _now.month, _now.day),
    last: DateTime(_now.year - 13, _now.month, _now.day),
    type: DatePickerDataType.birthday,
  );

  static final crowdsale = DatePickerData._(
    initial: DateTime(_now.year, _now.month, _now.day + 14),
    first: DateTime(_now.year, _now.month, _now.day + 14),
    last: DateTime(_now.year + 1, _now.month, _now.day),
    type: DatePickerDataType.crowdsale,
  );

  static final all = {crowdsale, birthday};

  static DatePickerData find(DatePickerDataType type) => all.firstWhere((element) => element.type == type);
}

class DatePicker {
  static Future<String?> show({required BuildContext context, required DatePickerDataType type}) async {
    DateTime? result;
    final data = DatePickerData.find(type);

    await showDatePicker(
      context: context,
      initialDate: data.initial,
      firstDate: data.first,
      lastDate: data.last,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: AppColors.primary,
            accentColor: AppColors.accent,
            colorScheme: ColorScheme.light(primary: AppColors.primary),
          ),
          child: child!,
        );
      },
    ).then((value) => result = value);

    return result == null ? null : DateHelper.formatDMY.format(result!);
  }
}
