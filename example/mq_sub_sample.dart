import 'dart:io';

import 'package:m3o/m3o.dart';

void main() async {
  final token = Platform.environment['M3O_API_TOKEN']!;
  final mqservice = MQService(
    Options(
      token: token,
      address: liveAddress,
    ),
  );

  final request = {'topic': 'events'};

  final st = await mqservice.subscribe(request);

  await for (var value in st) {
    print(value);
  }

  exit(0);
}
