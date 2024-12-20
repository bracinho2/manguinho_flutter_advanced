import 'package:manguinho_flutter_advanced/domain/entities/next_event_player.dart';
import 'package:manguinho_flutter_advanced/infra/api/mappers/mapper.dart';
import 'package:manguinho_flutter_advanced/infra/types/json.dart';

final class NextEventPlayerMapper extends Mapper<NextEventPlayer> {
  @override
  NextEventPlayer toObject(Json json) {
    return NextEventPlayer(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      photo: json['photo'],
      confirmationDate: DateTime.tryParse(json['confirmationDate'] ?? ''),
      isConfirmed: json['isConfirmed'],
    );
  }
}
