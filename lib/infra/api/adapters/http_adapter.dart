import 'dart:convert';

import 'package:dartx/dartx.dart';
import 'package:http/http.dart';
import 'package:manguinho_flutter_advanced/domain/entities/errors.dart';
import 'package:manguinho_flutter_advanced/infra/api/clients/http_client.dart';
import 'package:manguinho_flutter_advanced/infra/types/json.dart';

final class HttpAdapter implements HttpGetClient {
  final Client client;
  const HttpAdapter({required this.client});

  @override
  Future<T?> get<T>({
    required String url,
    Json? headers,
    Map<String, String?>? params,
    Map<String, String>? queryString,
  }) async {
    final response = await client.get(
      _buildUri(
        url: url,
        params: params,
        queryString: queryString,
      ),
      headers: _buildHeaders(
        url: url,
        headers: headers,
      ),
    );
    return _handleResponse(response);
  }

  T? _handleResponse<T>(Response response) {
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
        throw SessionExpiredError();
      default:
        throw UnexpectedError();
    }
  }

  Map<String, String> _buildHeaders({
    required String url,
    Json? headers,
  }) {
    final defaultHeaders = {
      'content-type': 'application/json',
      'accept': 'application/json'
    };
    return defaultHeaders
      ..addAll({
        for (final key in (headers ?? {}).keys) key: headers![key].toString()
      });
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
