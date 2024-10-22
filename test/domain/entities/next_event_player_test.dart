import 'package:flutter_test/flutter_test.dart';

class NextEventPlayer {
  final String id;
  final String name;
  final String? photo;
  final String? position;
  final bool isConfirmed;
  final DateTime? confirmationDate;

  NextEventPlayer({
    required this.id,
    required this.name,
    required this.isConfirmed,
    this.photo,
    this.position,
    this.confirmationDate,
  });

  String getInitials() {
    final names = name.split(' ');
    final firstChar = names.first[0];
    final lastChar = names.last[0];
    return '$firstChar$lastChar';
  }
}

void main() {
  NextEventPlayer makeSut(String name) =>
      NextEventPlayer(id: '', name: name, isConfirmed: true);

  test('should return the first letter of the first and last names', () {
    final sut = makeSut('Alexandre Ernzen');

    expect(sut.getInitials(), 'AE');

    final player2 = makeSut('Rodrigo Manguinho');

    expect(player2.getInitials(), 'RM');

    final player3 = makeSut('Ingrid Mota da Silveira');

    expect(player3.getInitials(), 'IS');
  });
}
