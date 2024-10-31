import 'package:manguinho_flutter_advanced/domain/entities/next_event.dart';
import 'package:manguinho_flutter_advanced/infra/api/mappers/next_event_player_mapper.dart';
import 'package:manguinho_flutter_advanced/infra/types/json.dart';

class NextEventMapper {
  static NextEvent toObject(Json json) => NextEvent(
        groupName: json['groupName'],
        date: DateTime.parse(json['date']),
        players: NextEventPlayerMapper.toList(json['players']),
      );
}
