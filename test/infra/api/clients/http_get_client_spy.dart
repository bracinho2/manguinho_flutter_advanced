import 'package:manguinho_flutter_advanced/infra/api/clients/http_client.dart';

final class HttpGetClientSpy implements HttpGetClient {
  String? url;
  int callsCount = 0;
  Map<String, String>? headers;
  Map<String, String?>? params;
  Map<String, String>? queryString;
  dynamic response;
  Error? error;

  @override
  Future<T?> get<T>({
    required String url,
    Map<String, String>? headers,
    Map<String, String?>? params,
    Map<String, String>? queryString,
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
