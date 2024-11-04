import 'package:flutter_test/flutter_test.dart';

import 'package:manguinho_flutter_advanced/domain/entities/errors.dart';
import 'package:manguinho_flutter_advanced/infra/api/adapters/http_adapter.dart';
import 'package:manguinho_flutter_advanced/infra/types/json.dart';

import '../../../helpers/fakes.dart';
import '../clients/client_spy.dart';

void main() {
  late ClientSpy client;
  late HttpAdapter sut;
  late String url;

  setUp(() {
    client = ClientSpy();
    client.responseJson = '''
    {
      "key1": "value1",
      "key2": "value2"
    }
    ''';
    sut = HttpAdapter(client: client);
    url = anyString();
  });

  group('get', () {
    test('should request with correct method', () async {
      await sut.get(url: url);
      expect(client.method, 'get');
      expect(client.callsCount, 1);
    });

    test('should request with correct url', () async {
      await sut.get(url: url);
      expect(client.url, url);
      expect(client.callsCount, 1);
    });

    test('should request with default headers', () async {
      await sut.get(url: url);
      expect(client.headers?['content-type'], 'application/json');
      expect(client.headers?['accept'], 'application/json');
    });

    test('should append headers', () async {
      await sut.get(url: url, headers: {'h1': 'value1', 'h2': 'value2'});
      expect(client.headers?['content-type'], 'application/json');
      expect(client.headers?['accept'], 'application/json');
    });

    test('should request with correct params', () async {
      url = 'http://anyurl.com/:p1/:p2';
      await sut.get(url: url, params: {'p1': 'v1', 'p2': 'v2'});
      expect(client.url, 'http://anyurl.com/v1/v2');
    });

    test('should requirest with optional params', () async {
      url = 'http://anyurl.com/:p1/:p2';
      await sut.get(url: url, params: {'p1': 'v1', 'p2': null});
      expect(client.url, 'http://anyurl.com/v1');
    });
    test('should requirest with invalid params', () async {
      url = 'http://anyurl.com/:p1/:p2';
      await sut.get(url: url, params: {'p3': 'v3'});
      expect(client.url, 'http://anyurl.com/:p1/:p2');
    });

    test('should request with correct queryStrings', () async {
      await sut.get(url: url, queryString: {'q1': 'v1', 'q2': 'v2'});
      expect(client.url, '$url?q1=v1&q2=v2');
    });

    test('should request with correct queryStrings and params', () async {
      url = 'http://anyurl.com/:p3/:p4';
      await sut.get(
          url: url,
          queryString: {'q1': 'v1', 'q2': 'v2'},
          params: {'p3': 'v3', 'p4': 'v4'});
      expect(client.url, 'http://anyurl.com/v3/v4?q1=v1&q2=v2');
    });

    test('shoud throw UnexpectedError on 400', () {
      client.simulateBadRequestError();
      final future = sut.get(url: url);
      expect(future, throwsA(const TypeMatcher<UnexpectedError>()));
    });

    test('shoud throw SessionExpired on 401', () {
      client.simulateUnauthorizedError();
      final future = sut.get(url: url);
      expect(future, throwsA(const TypeMatcher<SessionExpiredError>()));
    });

    test('shoud throw UnexpectedError on 403', () {
      client.simulateForbiddenError();
      final future = sut.get(url: url);
      expect(future, throwsA(const TypeMatcher<UnexpectedError>()));
    });

    test('shoud throw UnexpectedError on 404', () {
      client.simulateNotFoundError();
      final future = sut.get(url: url);
      expect(future, throwsA(const TypeMatcher<UnexpectedError>()));
    });

    test('shoud throw UnexpectedError on 500', () {
      client.simulateServerError();
      final future = sut.get(url: url);
      expect(future, throwsA(const TypeMatcher<UnexpectedError>()));
    });

    test('should return a Map on 200', () async {
      final data = await sut.get<Json>(url: url);

      expect(data?['key1'], 'value1');
      expect(data?['key2'], 'value2');
    });
    test('should return a List of Map on 200', () async {
      client.responseJson = '''
    [{
      "key": "value1"
    }, {
      "key": "value2"
    }]
    ''';
      final data = await sut.get<JsonArr>(url: url);

      expect(data?[0]['key'], 'value1');
      expect(data?[1]['key'], 'value2');
    });
    test('should return a Map with a List on 200', () async {
      client.responseJson = '''
        {
          "key1": "value1",
          "key2":  [{
            "key": "value1"
          }, {
            "key": "value2"
          }]
        }
    ''';
      final data = await sut.get<Json>(url: url);

      expect(data?['key1'], 'value1');
      expect(data?['key2'][0]['key'], 'value1');
      expect(data?['key2'][1]['key'], 'value2');
    });
    test('should return null on 200 with empty response', () async {
      client.responseJson = '';
      final data = await sut.get(url: url);

      expect(data, isNull);
    });

    test('shoud return null on 204', () async {
      client.simulateNoContent();
      final data = await sut.get(url: url);
      expect(data, isNull);
    });
  });
}
