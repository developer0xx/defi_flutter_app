import 'package:decimal/decimal.dart';
import 'package:json_annotation/json_annotation.dart';

class DecimalConverter implements JsonConverter<Decimal, Object> {
  const DecimalConverter();

  @override
  Decimal fromJson(Object json) => Decimal.parse(json.toString());

  @override
  String toJson(Decimal object) => object.toString();
}
