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

  CallRequest req = CallRequest(name: 'Mighty Zeus');

  CallResponse res1 = await hwservice.call(req);

  print('the message is ${res1.message}');
  print('the code is ${res1.code}');
  print(res1);

  StreamRequest req2 = StreamRequest(messages: 15, name: 'World');

  final st = await hwservice.stream(req2);
  final mst = st.asBroadcastStream();

  final first = await mst.first;
  print(first);

  await for (var value in mst) {
    print(value);
  }

  exit(0);
}
