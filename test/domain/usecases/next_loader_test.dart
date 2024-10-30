
import 'package:flutter_test/flutter_test.dart';
import 'package:manguinho_flutter_advanced/domain/entities/next_event.dart';

import 'package:manguinho_flutter_advanced/domain/entities/next_event_player.dart';
import 'package:manguinho_flutter_advanced/domain/repositories/load_next_event_repository.dart';
import 'package:manguinho_flutter_advanced/domain/usecases/next_event_loader.dart';

import '../../helpers/fakes.dart';

class LoadNextEventSpyRepository implements LoadNextEventRepository {
  String? groupId;
  var callsCount = 0;
  NextEvent? output;
  Error? error;

  @override
  Future<NextEvent> loadNextEvent({
    required String groupId,
  }) async {
    this.groupId = groupId;
    callsCount++;
    if (error != null) throw error!;
    return output!;
  }
}

void main() {
  late String groupId;
  late LoadNextEventSpyRepository repo;
  late NextEventLoader sut;

  setUp(() {
    groupId = anyString();
    repo = LoadNextEventSpyRepository();
    repo.output = NextEvent(
      groupName: 'any group',
      date: DateTime.now(),
      players: [
        NextEventPlayer(
          id: 'any id 1',
          name: 'any name 1',
          isConfirmed: true,
          photo: 'any photo 1',
          confirmationDate: DateTime.now(),
        ),
        NextEventPlayer(
          id: 'any id 2',
          name: 'any name 2',
          isConfirmed: true,
          confirmationDate: DateTime.now(),
          position: 'any position 2',
        ),
      ],
    );
    sut = NextEventLoader(repo: repo);
  });

  test('should load event data from a repository', () async {
    //act
    await sut(groupId: groupId);

    //assert
    expect(repo.groupId, groupId);
    expect(repo.callsCount, 1);
  });

  test('should return event data on success', () async {
    //act
    final event = await sut(groupId: groupId);

    //assert
    expect(event.groupName, repo.output?.groupName);
    expect(event.date, repo.output?.date);
    expect(event.players.length, 2);

    //player 1
    expect(event.players[0].id, repo.output?.players[0].id);
    expect(event.players[0].name, repo.output?.players[0].name);
    //atençao para a regra de negocio;
    expect(event.players[0].initials, isNotEmpty);
    expect(event.players[0].photo, repo.output?.players[0].photo);
    expect(event.players[0].isConfirmed, repo.output?.players[0].isConfirmed);
    expect(event.players[0].confirmationDate,
        repo.output?.players[0].confirmationDate);

    //player 2
    expect(event.players[1].id, repo.output?.players[1].id);
    expect(event.players[1].name, repo.output?.players[1].name);
    //atençao para a regra de negocio;
    expect(event.players[1].initials, isNotEmpty);
    expect(event.players[1].position, repo.output?.players[1].position);
    expect(event.players[1].isConfirmed, repo.output?.players[1].isConfirmed);
    expect(event.players[1].confirmationDate,
        repo.output?.players[1].confirmationDate);
  });

  test('shoud rethrow on error', () async {
    final error = Error();
    repo.error = error;
    final future = sut(groupId: groupId);
    expect(future, throwsA(error));
  });
}
