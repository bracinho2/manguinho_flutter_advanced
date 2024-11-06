import 'package:manguinho_flutter_advanced/infra/api/clients/http_client.dart';
import 'package:manguinho_flutter_advanced/infra/types/json.dart';

final class HttpGetClientSpy implements HttpGetClient {
  String? url;
  int callsCount = 0;
  Json? headers;
  Json? params;
  Json? queryString;
  dynamic response;
  Error? error;

  @override
  Future<T?> get<T>({
    required String url,
    Json? headers,
    Json? params,
    Json? queryString,
  }) async {
    this.url = url;
    this.headers = headers;
    this.params = params;
    this.queryString = queryString;
    callsCount++;
    if (error != null) throw error!;
    return response;
  }
}
