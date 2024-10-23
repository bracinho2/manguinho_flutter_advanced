import 'package:manguinho_flutter_advanced/domain/entities/next_event_player.dart';

import 'package:flutter_test/flutter_test.dart';

void main() {
  String initialsOf(String name) =>
      NextEventPlayer(id: '', name: name, isConfirmed: true).initials;

  test('should return the first letter of the first and last names', () {
    expect(initialsOf('Alexandre Ernzen'), 'AE');

    expect(initialsOf('Rodrigo Manguinho'), 'RM');

    expect(initialsOf('Ingrid Mota da Silva'), 'IS');
  });

  test('should return the first letter of the first name', () {
    expect(initialsOf('Alexandre'), 'AL');
    expect(initialsOf('A'), 'A');
  });

  test('should convert to upper case', () {
    expect(initialsOf('Alexandre Ernzen'), 'AE');
    expect(initialsOf('Alexandre'), 'AL');
    expect(initialsOf('a'), 'A');
  });

  test('should return "-" when name is empty', () {
    expect(initialsOf(''), '-');
  });

  test('should ignore whitespaces', () {
    expect(initialsOf('Alexandre Ernzen '), 'AE');
    expect(initialsOf(' Alexandre Ernzen'), 'AE');
    expect(initialsOf(' Alexandre  Ernzen'), 'AE');
    expect(initialsOf(' Alexandre  Ernzen '), 'AE');
    expect(initialsOf(' Alexandre '), 'AL');
    expect(initialsOf(' A '), 'A');
    expect(initialsOf(' '), '-');
    expect(initialsOf('  '), '-');
  });
}
