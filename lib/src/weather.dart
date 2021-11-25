import 'package:m3o/m3o.dart';

class WeatherService {
  final Options opts;
  var _client;

  WeatherService(this.opts) {
    _client = Client(opts);
  }

  Future<Response> forecast(Map<String, dynamic> body) async {
    Request request = Request(
      service: 'weather',
      endpoint: 'Forecast',
      body: body,
    );

    Response res = await _client.call(request);

    return res;
  }

  Future<Response> now(Map<String, dynamic> body) async {
    Request request = Request(
      service: 'weather',
      endpoint: 'now',
      body: body,
    );

    Response res = await _client.call(request);

    return res;
  }
}
