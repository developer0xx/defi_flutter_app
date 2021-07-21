import 'package:sapiency_app/config/config.dart';
import 'package:sapiency_app/model/api/version/req/check_version_req.dart';
import 'package:sapiency_app/service/api/api_service.dart';

class VersionService {
  final ApiService _apiService;
  final Config _config;

  const VersionService(this._apiService, this._config);

  Future<bool> shouldUpdateApp() async {
    if (_config.version == null) return false;
    final response = await _apiService.checkVersion(CheckVersionReq(version: _config.version!));
    return response.body!.when<bool>(
      ok: () => false,
      error: () => true,
    );
  }
}
