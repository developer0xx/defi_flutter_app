import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_version_res.freezed.dart';

part 'check_version_res.g.dart';

@Freezed(unionKey: 'result')
class CheckVersionRes with _$CheckVersionRes {
  @FreezedUnionValue('ok')
  factory CheckVersionRes.ok() = CheckVersionResOk;

  @FreezedUnionValue('fail')
  factory CheckVersionRes.error() = CheckVersionResError;

  factory CheckVersionRes.fromJson(Map<String, dynamic> json) => _$CheckVersionResFromJson(json);
}
