import 'package:sapiency_app/service/api/api_service.dart';
import 'package:sapiency_app/service/storage/shared_preferences_service.dart';
import 'package:uuid/uuid.dart';

class DeviceService {
  final SharedPreferencesService _storageService;

  const DeviceService(this._storageService);

  Future<String> obtainDeviceId() async {
    final savedId = await _storageService.loadDeviceId();
    final id = savedId ?? Uuid().v4();
    if (id != savedId) await _storageService.storeDeviceId(id);
    return id;
  }
}