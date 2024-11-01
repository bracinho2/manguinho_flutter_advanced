import 'package:manguinho_flutter_advanced/domain/entities/next_event.dart';
import 'package:manguinho_flutter_advanced/domain/repositories/load_next_event_repository.dart';
import 'package:manguinho_flutter_advanced/infra/api/clients/http_client.dart';
import 'package:manguinho_flutter_advanced/infra/api/mappers/next_event_mapper.dart';
import 'package:manguinho_flutter_advanced/infra/types/json.dart';

class LoadNextEventApiRepository implements LoadNextEventRepository {
  final HttpGetClient httpClient;
  final String url;

  LoadNextEventApiRepository({required this.httpClient, required this.url});
  @override
  Future<NextEvent> loadNextEvent({required String groupId}) async {
    final json =
        await httpClient.get<Json>(url: url, params: {'groupId': groupId});
    return NextEventMapper.toObject(json);
  }
}