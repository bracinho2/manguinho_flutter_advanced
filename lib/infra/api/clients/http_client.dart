import 'package:manguinho_flutter_advanced/infra/types/json.dart';

abstract interface class HttpGetClient {
  Future<T?> get<T>({
    required String url,
    Json? headers,
    Json? params,
    Json? queryString,
  });
}
