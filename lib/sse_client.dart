import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class SSEModel {
  new({required this.data, required this.id, required this.event});

  String data;
  String id;
  String event;
}

Stream<SSEModel> subscribeToSSE() {
  var streamController = StreamController<SSEModel>();

  var client = http.Client();
  final request = http.Request("GET", Uri.parse("http://64.188.66.245:8000/stream"));

  final headers = <String, String>{
      'Accept': 'text/event-stream',
      'Cache-Control': 'no-cache',
    };
  headers.forEach((key, value) {
      request.headers[key] = value;
    });

  var currentSSEModel = SSEModel(data: "", id: "", event: "");

  Future<http.StreamedResponse> response = client.send(request);
  response.asStream().listen((data) {
      data.stream.transform(const Utf8Decoder()).transform(const LineSplitter()).listen((dataLine) {
        if (dataLine.isEmpty) {
          streamController.add(currentSSEModel);
          currentSSEModel = SSEModel(data: "", id: "", event: "");
          return;
        }
        final lineRegex = RegExp(r'^([^:]*)(?::)?(?: )?(.*)?$');
        final match = lineRegex.firstMatch(dataLine)!;
        final field = match.group(1);
        if (field!.isEmpty) {
          return;
        }
        var value = '';
        if (field == 'data') {
          value = dataLine.substring(5);
        } else {
            value = match.group(2)  ?? '';
        }
        switch (field) {
          case 'event':
            currentSSEModel.event = value;
          case 'data':
            currentSSEModel.data = '${currentSSEModel.data}$value\n';
          case 'id':
            currentSSEModel.id = value;
          case 'retry':
            break;
        }
      });
    });
  return streamController.stream;
}
