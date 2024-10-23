import 'package:manguinho_flutter_advanced/domain/entities/next_event.dart';
import 'package:manguinho_flutter_advanced/domain/repositories/load_next_event_repository.dart';

class NextEventLoader {
  final LoadNextEventRepository repo;

  const NextEventLoader({required this.repo});

  Future<NextEvent> call({required String groupId}) async {
    return await repo.loadNextEvent(groupId: groupId);
  }
}
