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

class LoadNextEventRepository {
  String? groupId;
  var callsCount = 0;

  Future<void> loadNextEvent({
    required String groupId,
  }) async {
    this.groupId = groupId;
    callsCount++;
  }
}

void main() {
  test('should load event data from a repository', () async {
    //arrange
    final groupId = Random().nextInt(50000).toString();
    final repo = LoadNextEventRepository();
    final sut = NextEventLoader(repo: repo);

    //act
    await sut(groupId: groupId);

    //assert
    expect(repo.groupId, groupId);
    expect(repo.callsCount, 1);
  });
}
