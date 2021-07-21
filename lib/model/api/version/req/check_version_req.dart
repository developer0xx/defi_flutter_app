import 'package:freezed_annotation/freezed_annotation.dart';

part 'check_version_req.freezed.dart';

part 'check_version_req.g.dart';

@freezed
class CheckVersionReq with _$CheckVersionReq {
  factory CheckVersionReq({required String version}) = _CheckVersionReq;

  factory CheckVersionReq.fromJson(Map<String, dynamic> json) => _$CheckVersionReqFromJson(json);
}
