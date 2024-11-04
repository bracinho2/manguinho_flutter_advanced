import 'dart:convert';

import 'package:dartx/dartx.dart';
import 'package:http/http.dart';
import 'package:manguinho_flutter_advanced/domain/entities/domain_error.dart';
import 'package:manguinho_flutter_advanced/infra/api/clients/http_client.dart';
import 'package:manguinho_flutter_advanced/infra/types/json.dart';

class HttpAdapter implements HttpGetClient {
  final Client client;
  HttpAdapter({required this.client});

  @override
  Future<T?> get<T>({
    required String url,
    Map<String, String>? headers,
    Map<String, String?>? params,
    Map<String, String>? queryString,
  }) async {
    final allHeaders = (headers ?? {})
      ..addAll(
          {'content-type': 'application/json', 'accept': 'application/json'});
    final uri = _buildUri(url: url, params: params, queryString: queryString);
    final response = await client.get(uri, headers: allHeaders);

    switch (response.statusCode) {
      case 200:
        {
          if (response.body.isEmpty) return null;
          final data = jsonDecode(response.body);
          return (T == JsonArr)
              ? data.map<Json>((e) => e as Json).toList()
              : data;
        }
      case 204:
        return null;
      case 401:
        throw DomainError.sessionExpired;
      default:
        throw DomainError.unexpected;
    }
  }

  Uri _buildUri(
      {required String url,
      Map<String, String?>? params,
      Map<String, String>? queryString}) {
    url = params?.keys
            .fold(
                url,
                (result, key) =>
                    result.replaceFirst(':$key', params[key] ?? ''))
            .removeSuffix('/') ??
        url;

    url = (queryString?.keys
            .fold('$url?', (result, key) => '$result$key=${queryString[key]}&')
            .removeSuffix('&')) ??
        url;

    return Uri.parse(url);
  }
}
