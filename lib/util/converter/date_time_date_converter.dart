import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sapiency_app/util/extension/extensions.dart';

class DateTimeDateConverter implements JsonConverter<DateTime, String> {
  static final _format = DateFormat('yyyy-MM-dd');
  
  const DateTimeDateConverter();

  @override
  DateTime fromJson(String json) => _format.parse(json);

  @override
  String toJson(DateTime object) => _format.format(object);
}

class NullableDateTimeDateConverter implements JsonConverter<DateTime?, String?> {
  static final _format = DateFormat('yyyy-MM-dd');

  const NullableDateTimeDateConverter();

  @override
  DateTime? fromJson(String? json) => json?.let((it) => _format.parse(it));

  @override
  String? toJson(DateTime? object) => object?.let((it) => _format.format(object));
}
