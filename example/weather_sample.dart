import 'dart:io';

import 'package:m3o/m3o.dart';

void main() async {
  final token = Platform.environment['M3O_API_TOKEN']!;
  final wservice = WeatherService(
    Options(
      token: token,
      address: liveAddress,
    ),
  );

  final request1 = {'days': 2, 'location': 'London'};

  Response res1 = await wservice.forecast(request1);

  print(res1);

  final resquest2 = {'location': 'london'};

  Response res2 = await wservice.now(resquest2);

  print(res2);

  exit(0);
}
