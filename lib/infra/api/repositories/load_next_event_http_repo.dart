// import 'dart:convert';

// import 'package:http/http.dart';
// import 'package:manguinho_flutter_advanced/domain/entities/domain_error.dart';
// import 'package:manguinho_flutter_advanced/domain/entities/next_event.dart';
// import 'package:manguinho_flutter_advanced/domain/entities/next_event_player.dart';

// class LoadNextEventHttpRepository {
//   final Client httpClient;
//   final String url;

//   LoadNextEventHttpRepository({
//     required this.httpClient,
//     required this.url,
//   });

//   Future<NextEvent> loadNextEvent({required String groupId}) async {
//     final uri = Uri.parse(url.replaceAll(':groupId', groupId));
//     final headers = {
//       'content-type': 'application/json',
//       'accept': 'application/json'
//     };
//     final response = await httpClient.get(uri, headers: headers);

//     switch (response.statusCode) {
//       case 200:
//         break;
//       case 401:
//         throw DomainError.sessionExpired;
//       default:
//         throw DomainError.unexpected;
//     }

//     final event = jsonDecode(response.body);

//     return NextEvent(
//       groupName: event['groupName'],
//       date: DateTime.parse(event['date']),
//       players: event['players']
//           .map<NextEventPlayer>(
//             (player) => NextEventPlayer(
//               id: player['id'],
//               name: player['name'],
//               position: player['position'],
//               photo: player['photo'],
//               confirmationDate:
//                   DateTime.tryParse(player['confirmationDate'] ?? ''),
//               isConfirmed: player['isConfirmed'],
//             ),
//           )
//           .toList(),
//     );
//   }
// }
