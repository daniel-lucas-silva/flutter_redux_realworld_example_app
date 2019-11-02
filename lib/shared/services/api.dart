part of services;

const API_ROOT = 'https://conduit.productionready.io/api';

class Api {
  final Dio _dio = Dio();

  Future<dynamic> get(String url) async => (await _dio.get("$API_ROOT/$url")).data;

  Future<dynamic> post(String url, {Map<String, dynamic> data}) async =>
      (await _dio.post("$API_ROOT/$url", data: data)).data;

  Future<dynamic> put(String url, {Map<String, dynamic> data}) async =>
      (await _dio.put("$API_ROOT/$url", data: data)).data;

  Future<dynamic> delete(String url) async => (await _dio.delete("$API_ROOT/$url")).data;
}

final api = Api();
