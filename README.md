# M3O Dart Client

This is the Dart client to access APIs on the M3O Platform

## What is M3O

[M3O](https://m3o.com/) is an attempt to build a new public cloud platform with higher level building blocks for the Next generation of developers. M3O is powered by the open source [Micro](https://github.com/micro/micro) platform and programmable real world [Micro Services](https://github.com/micro/services).

M3O APIs includes DB, Cache, Stream, MQ, Events, Functions, SMS and more.

## Usage
Call a service using the generated client. Populate the `M3O_API_TOKEN` environment variable. 

Import the package and initialise the service with your API token.

```dart
import 'dart:io';

import 'package:M3O/m3o.dart';

void main() async {
  final token = Platform.environment['M3O_API_TOKEN']!;
  final hwservice = HelloWorldService(
    Options(
      token: token,
      address: liveAddress,
    ),
  );

  final request = {
    'name': 'John',
  };

  Response res = await hwservice.call(request);

  print(res);

  exit(0);
}
```
## Generic Client

The generic client enables you to call any endpoint by name.

```dart
import 'dart:io';

import 'package:M3O/m3o.dart';

void main() async {

    final token = Platform.environment['M3O_API_TOKEN']!;

    final client = Client(
        Options(
            token: token,
            address: liveAddress,
        ),
    );

    Request request = Request(
        service: 'helloworld',
        endpoint: 'Call',
        body: {
        'name': 'John',
        },
    );

    Response res = await client.call(request);

    print(res);

    exit(0);
}
```