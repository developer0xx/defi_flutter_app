import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:sapiency_app/config/config.dart';
import 'package:sapiency_app/logger.dart';
import 'package:sapiency_app/service/api/client/response_type_registry.dart';
import 'package:sapiency_app/service/storage/shared_preferences_service.dart';

class ApiClientService {
  final Config _config;
  final SharedPreferencesService _storageService;

  const ApiClientService(this._config, this._storageService);

  ChopperClient createClient() {
    return ChopperClient(
      baseUrl: _config.apiBaseUrl,
      converter: _JsonToTypeConverter(responseTypeRegistry),
      interceptors: [
        _AuthInterceptor(() => _storageService.loadAuthToken()),
        _LoggerInterceptor(),
      ],
    );
  }

  Future<void> storeAuthToken(String authToken) async => await _storageService.storeAuthToken(authToken);

  Future<bool> hasAuthToken() async => (await _storageService.loadAuthToken()) != null;
}

class _LoggerInterceptor implements RequestInterceptor, ResponseInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final base = await request.toBaseRequest();
    logger.i([
      'HTTP request',
      '${base.method} ${base.url}',
      for(final header in base.headers.entries) '${header.key}: ${header.value}',
      if(base is http.Request && base.body.isNotEmpty) tryPrettyJson(base.body),
    ].join('\n'));

    return request;
  }

  @override
  FutureOr<Response> onResponse(Response response) {
    final base = response.base.request!;
    final baseResponse = response.base;
    logger.i([
      'HTTP response',
      '${base.method} ${base.url}',
      '<-- ${response.statusCode}',
      for(final header in response.headers.entries) '${header.key}: ${header.value}',
      if(baseResponse is http.Response && baseResponse.body.isNotEmpty) tryPrettyJson(baseResponse.body),
    ].join('\n'));

    return response;
  }

  String tryPrettyJson(String body) {
    try {
      final encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(json.decode(body));
    } on FormatException {
      return body;
    }
  }
}

class _AuthInterceptor implements RequestInterceptor {
  final Future<String?> Function() _tokenProvider;

  const _AuthInterceptor(this._tokenProvider);

  @override
  FutureOr<Request> onRequest(Request request) async {
    final token = await _tokenProvider();
    return request.copyWith(headers: {...request.headers, if (token != null) 'Authorization': 'Sapiency $token'});
  }
}

class _JsonToTypeConverter extends JsonConverter {
  final Map<Type, Function> typeToJsonFactoryMap;

  _JsonToTypeConverter(this.typeToJsonFactoryMap);

  @override
  Response<BodyType> convertResponse<BodyType, InnerType>(Response response) {
    return response.copyWith(
      body: fromJsonData<BodyType, InnerType>(utf8.decode(response.bodyBytes), typeToJsonFactoryMap[InnerType]!),
    );
  }

  @override
  Request convertRequest(Request request) {
    return super.convertRequest(request.copyWith(body: request.body.toJson()));
  }

  T fromJsonData<T, InnerType>(String jsonData, Function jsonParser) {
    var jsonMap = json.decode(jsonData);

    if (jsonMap is List) {
      return jsonMap.map((item) => jsonParser(item as Map<String, dynamic>) as InnerType).toList() as T;
    }

    return jsonParser(jsonMap);
  }
}
