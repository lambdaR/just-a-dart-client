import 'dart:io';

import 'package:m3o/m3o.dart';

void main() async {
  final token = Platform.environment['M3O_API_TOKEN']!;
  final hwservice = HelloWorldService(
    Options(
      token: token,
      address: liveAddress,
    ),
  );

  final request1 = {
    'name': 'Mighty Zeus',
  };

  Response res1 = await hwservice.call(request1);

  print(res1);

  final request2 = {
    'messages': 15,
    'name': 'World',
  };

  final st = await hwservice.stream(request2);
  final mst = st.asBroadcastStream();

  final first = await mst.first;
  print(first);

  await for (var value in mst) {
    print(value);
  }

  exit(0);
}
