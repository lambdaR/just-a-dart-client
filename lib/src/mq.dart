import 'dart:convert';

import 'package:m3o/m3o.dart';

class MQService {
  final Options opts;
  var _client;

  MQService(this.opts) {
    _client = Client(opts);
  }

  Future<Response> publish(Map<String, dynamic> body) async {
    Request request = Request(
      service: 'mq',
      endpoint: 'Publish',
      body: body,
    );

    Response res = await _client.call(request);

    return res;
  }

  Stream<Response> subscribe(Map<String, dynamic> body) async* {
    Request request = Request(
      service: 'mq',
      endpoint: 'Subscribe',
      body: body,
    );

    M3OStream st = await _client.stream(request);

    if (st.webS != null) {
      await for (var value in st.webS!) {
        yield Response.fromJson(jsonDecode(value));
      }
    } else {
      yield Response(
        body: null,
        id: 'm3o-dart',
        detail: 'address ${opts.address} unreachable',
        status: 'service unavailable',
      );
    }
  }
}