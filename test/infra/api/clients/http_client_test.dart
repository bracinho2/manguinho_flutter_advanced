import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

import '../../../helpers/fakes.dart';
import 'client_spy.dart';

class HttpClient {
  final Client client;
  HttpClient({required this.client});
  Future<void> get({required String url}) async {
    final uri = Uri.parse(url);
    client.get(uri);
  }
}

void main() {
  late ClientSpy client;
  late HttpClient sut;
  late String url;

  setUp(() {
    client = ClientSpy();
    sut = HttpClient(client: client);
    url = anyString();
  });

  group('get', () {
    test('shoud request with correct method', () async {
      await sut.get(url: url);
      expect(client.method, 'get');
      expect(client.callsCount, 1);
    });

    test('shoud request with correct url', () async {
      await sut.get(url: url);
      expect(client.url, url);
      expect(client.callsCount, 1);
    });
  });
}
