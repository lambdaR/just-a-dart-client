import 'dart:io';

import 'package:m3o/m3o.dart';
import 'package:test/test.dart';

void main() {
  group('#Client call', () {
    test('with valid Token', () async {
      const address = liveAddress;
      final token = Platform.environment['M3O_API_TOKEN']!;
      final opts = Options(token: token, address: address);
      final c = Client(opts);
      final request = Request(
          service: 'helloworld', endpoint: 'Call', body: {'name': 'Zeus'});
      Response res = await c.call(request);
      expect(res.body, {'message': 'Hello Zeus'});
    });

    test('with invalid Token', () async {
      const address = liveAddress;
      final opts = Options(token: 'TOKEN', address: address);
      final c = Client(opts);
      final request = Request(
          service: 'helloworld', endpoint: 'Call', body: {'name': 'Zeus'});
      Response res = await c.call(request);

      expect(res.body, 401);
    });

    // test('with server unavailable', () async {
    //   const address = 'https://hlskjflak';
    //   final opts = Options(token: 'TOKEN', address: address);
    //   final c = Client(opts);
    //   final request = Request(
    //       service: 'helloworld', endpoint: 'Call', body: {'name': 'Zeus'});
    //   Response res = await c.call(request);

    //   expect(res.code, 503);
    // });
  });

  group('Client stream', () {
    // test('with valid token', () async {
    //   const address = liveAddress;
    //   final token = Platform.environment['M3O_API_TOKEN']!;
    //   final opts = Options(token: token, address: address);
    //   final c = Client(opts);
    //   final request = Request(service: 'helloworld', endpoint: 'Stream', body: {
    //     'messages': 1,
    //     'name': 'World',
    //   });

    //   M3OStream st = await c.stream(request);
    //   expect(st.toString(), 'Instance of \'M3OStream\'');
    //   final res = await st.webS!.first;
    //   expect(res, '{"message":"Hello World"}');
    // });

    // test('with invalid token', () async {
    //   const address = liveAddress;
    //   final token = 'jflsakjfalskfj';
    //   final opts = Options(
    //     token: token,
    //     address: address,
    //   );
    //   final c = Client(opts);
    //   final request = Request(service: 'helloworld', endpoint: 'Stream', body: {
    //     'messages': 1,
    //     'name': 'World',
    //   });

    //   M3OStream st = await c.stream(request);
    //   final res = await st.webS!.first;
    //   expect(res,
    //       '{"Id":"v1","Code":401,"Detail":"Unauthorized","Status":"Unauthorized"}');
    // });

    // test('with server unavailable', () async {
    //   const address = 'https://jflksdjflskajfl';
    //   final token = Platform.environment['M3O_API_TOKEN']!;
    //   final opts = Options(
    //     token: token,
    //     address: address,
    //   );
    //   final c = Client(opts);
    //   final request = Request(service: 'helloworld', endpoint: 'Stream', body: {
    //     'messages': 1,
    //     'name': 'World',
    //   });

    //   M3OStream st = await c.stream(request);
    //   expect(st.webS, null);
    // });
  });
}
