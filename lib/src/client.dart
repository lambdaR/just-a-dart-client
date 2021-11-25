import 'dart:async';
import 'dart:io';
import 'dart:convert';

// local address for api
const localAddress = 'http://localhost:8080';
// public address for api
const liveAddress = 'https://api.m3o.com';

class M3OStream {
  final WebSocket? webS;
  final String service;
  final String endpoint;

  M3OStream(this.webS, this.service, this.endpoint);
}

class Options {
  // Token for authentication
  final String token;
  // Address of the micro platform.
  // By default it connects to live. Change it or use the local flag
  // to connect to your local installation.
  final String address;
  // set a timeout
  final Duration? timeout;

  Options({required this.token, required this.address, this.timeout = null});
}

class Client {
  Client(Options options)
      : _token = options.token,
        _address = options.address,
        _timeout = options.timeout;

  // Token for authentication
  final String _token;
  // Address of the micro platform.
  final String _address;
  // set a timeout
  final Duration? _timeout;

  String get token => _token;
  String get address => _address;
  Duration? get timeout => _timeout;

  // Call enables you to access any endpoint of any service on Micro
  Future<Response> call(Request request) async {
    final uri = '$address/v1/${request.service}/${request.endpoint}';

    HttpClient c = new HttpClient();
    // When this is null, the OS default timeout is used
    c.connectionTimeout = timeout;

    try {
      final httpRequest = await c.postUrl(Uri.parse(uri));

      httpRequest.headers.add('Authorization', 'Bearer $token');
      httpRequest.headers.add('Content-Type', 'application/json');

      final payload = jsonEncode(request.body);

      httpRequest.add(utf8.encode(payload));
      final httpResponse = await httpRequest.close();

      if (!(httpResponse.statusCode >= 200 && httpResponse.statusCode < 300)) {
        final responseBody = await httpResponse.transform(Utf8Decoder()).join();

        return Response.fromJson(jsonDecode(responseBody));
      }

      final responseBody = await httpResponse.transform(Utf8Decoder()).join();

      return Response.fromJson(jsonDecode(responseBody));
    } catch (e) {
      return Response(
        body: null,
        id: 'm3o-dart',
        code: 503,
        detail: e.toString(),
        status: 'service unavailable',
      );
    } finally {
      c.close();
    }
  }

  Future<M3OStream> stream(Request request) async {
    var uri = '$address/v1/${request.service}/${request.endpoint}';
    uri = uri.replaceFirst('http', 'ws');

    Map<String, dynamic> headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    final payload = jsonEncode(request.body);

    try {
      final _ = Uri.tryParse(uri);
      final webS = await WebSocket.connect(uri, headers: headers);
    
      webS.add(payload);

      return M3OStream(webS, request.service, request.endpoint);
    } catch (_) {
      return M3OStream(null, request.service, request.endpoint);
    }
  }
}

/// Request is the request of the generic `api-client` call
class Request {
  Request({required this.service, required this.endpoint, required this.body});

  final String service;
  final String endpoint;
  final Map<String, dynamic> body;
}

/// Response is the response of the generic `api-client` call.
class Response {
  // json and base64 encoded response body
  Response({this.body, this.code, this.id, this.detail, this.status});

  final Map<String, dynamic>? body;
  // error fields. Error json example
  // {"id":"go.micro.client","code":500,"detail":"malformed method name: \"\"","status":"Internal Server Error"}
  final int? code;
  final String? id;
  final String? detail;
  final String? status;

  factory Response.fromJson(Map<String, dynamic> json) {
    if (json['Code'] != null) {
      return Response(
          body: null,
          id: json['Id'],
          detail: json['Detail'],
          code: json['Code'],
          status: json['Status']);
    }

    return Response(
        body: json, id: null, detail: null, code: null, status: null);
  }

  @override
  String toString() {
    if (body != null) {
      return body.toString();
    } else {
      return '{id: $id, code: $code, detail: $detail, status: $status}';
    }
  }
}
