import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const _authTokenKey = 'authToken';
  static const _deviceIdKey = 'deviceId';

  SharedPreferences? _preferences;

  Future<String?> loadAuthToken() async {
    await _ensureInitialized();
    return await _preferences!.getString(_authTokenKey);
  }

  Future<void> storeAuthToken(String authToken) async {
    await _ensureInitialized();
    await _preferences!.setString(_authTokenKey, authToken);
  }

  Future<String?> loadDeviceId() async {
    await _ensureInitialized();
    return await _preferences!.getString(_deviceIdKey);
  }

  Future<void> storeDeviceId(String deviceId) async {
    await _ensureInitialized();
    await _preferences!.setString(_deviceIdKey, deviceId);
  }

  Future<void> _ensureInitialized() async {
    if (_preferences == null) _preferences = await SharedPreferences.getInstance();
  }
}
