import 'dart:convert';

import 'package:m3o/m3o.dart';

class HelloWorldService {
  final Options opts;
  var _client;

  HelloWorldService(this.opts) {
    _client = Client(opts);
  }

  Future<CallResponse> call(CallRequest req) async {
    Request request = Request(
      service: 'helloworld',
      endpoint: 'Call',
      body: req.toJson(),
    );

    Response res = await _client.call(request);
    
    return CallResponse.fromResponse(res);
  }

  Stream<StreamResponse> stream(StreamRequest req) async* {
    Request request = Request(
      service: 'helloworld',
      endpoint: 'Stream',
      body: req.toJson(),
    );

    
    M3OStream st = await _client.stream(request);

   if (st.webS != null) {
      await for (var value in st.webS!) {
        yield StreamResponse.fromResponse(Response.fromJson(jsonDecode(value)));
      }
    } else {
      yield StreamResponse.fromResponse(Response(
        body: null,
        id: 'm3o-dart',
        detail: 'address ${opts.address} unreachable',
        status: 'service unavailable',
      )
      );
    }
  }
}
class CallRequest {
  final String name;

  CallRequest({required this.name});

  Map<String, dynamic> toJson() {
    return {
      'name': this.name
    };
  }
}

class CallResponse {
  final String? message;
  final int? code;
  final String? id;
  final String? detail;
  final String? status;

  CallResponse({this.message, this.code, this.id, this.detail, this.status});

  factory CallResponse.fromResponse(Response res) {
    if (res.body != null) {
      return CallResponse(message: res.body.toString());
    } else {
      return CallResponse(id: res.id, code: res.code, detail: res.detail, status: res.status);
    }
  }

  @override
  String toString() {
    if (message != null) {
      return message.toString();
    } else {
      return '{id: $id, code: $code, detail: $detail, status: $status}';
    }
  }
}

class StreamRequest {
  final int messages;
  final String name;

  StreamRequest({required this.messages, required this.name});
  
  Map<String, dynamic> toJson() {
    return {
      'messages': messages,
      'name': name,
    };
  }
}

class StreamResponse {
  final String? message;
  final int? code;
  final String? id;
  final String? detail;
  final String? status;

  StreamResponse({this.message, this.code, this.id, this.detail, this.status});

  factory StreamResponse.fromResponse(Response res) {
    if (res.body != null) {
      return StreamResponse(message: res.body.toString());
    } else {
      return StreamResponse(id: res.id, code: res.code, detail: res.detail, status: res.status);
    }
  }

  @override
  String toString() {
    if (message != null) {
      return message.toString();
    } else {
      return '{id: $id, code: $code, detail: $detail, status: $status}';
    }
  }
}
