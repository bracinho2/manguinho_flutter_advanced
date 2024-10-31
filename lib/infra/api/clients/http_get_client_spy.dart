import 'package:manguinho_flutter_advanced/infra/api/clients/http_client.dart';
import 'package:manguinho_flutter_advanced/infra/types/json.dart';

class HttpGetClientSpy implements HttpGetClient {
  String? url;
  int callsCount = 0;
  Json? params;
  dynamic response;
  Error? error;

  @override
  Future<T> get<T>({required String url, Json? params}) async {
    this.url = url;
    this.params = params;
    callsCount++;
    if (error != null) throw error!;
    return response;
  }
}
