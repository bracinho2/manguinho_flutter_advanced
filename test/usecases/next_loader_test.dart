import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

class NextEventLoader {
  final LoadNextEventRepository repo;

  const NextEventLoader({required this.repo});

  Future<void> call({
    required String groupId,
  }) async {
    await repo.loadNextEvent(groupId: groupId);
  }
}

abstract class LoadNextEventRepository {
  Future<void> loadNextEvent({required String groupId});
}

class LoadNextEventMockRepository implements LoadNextEventRepository {
  String? groupId;
  var callsCount = 0;

  @override
  Future<void> loadNextEvent({
    required String groupId,
  }) async {
    this.groupId = groupId;
    callsCount++;
  }
}

void main() {
  late String groupId;
  late LoadNextEventMockRepository repo;
  late NextEventLoader sut;

  setUp(() {
    groupId = Random().nextInt(50000).toString();
    repo = LoadNextEventMockRepository();
    sut = NextEventLoader(repo: repo);
  });

  test('should load event data from a repository', () async {
    //act
    await sut(groupId: groupId);

    //assert
    expect(repo.groupId, groupId);
    expect(repo.callsCount, 1);
  });
}
