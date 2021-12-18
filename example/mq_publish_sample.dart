// import 'dart:io';

// import 'package:m3o/m3o.dart';

// void main() async {
//   final token = Platform.environment['M3O_API_TOKEN']!;
//   final mqservice = MQService(
//     Options(
//       token: token,
//       address: liveAddress,
//     ),
//   );

//   final request = {
//     'message': {'id': '200', 'type': 'Logging', 'user': 'Debo'},
//     'topic': 'events'
//   };

//   Response res = await mqservice.publish(request);

//   print(res);

//   exit(0);
// }
