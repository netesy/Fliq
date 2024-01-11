// lib/src/fliq_request.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class Fliq {
  late HttpClient _client;

  Fliq() {
    _client = HttpClient();
  }

  FliqRequest get(String url) {
    return FliqRequest('GET', url, _client);
  }

  FliqRequest post(String url) {
    return FliqRequest('POST', url, _client);
  }

  FliqRequest put(String url) {
    return FliqRequest('PUT', url, _client);
  }

  FliqRequest delete(String url) {
    return FliqRequest('DELETE', url, _client);
  }

  void close() {
    _client.close();
  }
}

class FliqRequest {
  late HttpClientRequest _request;
  late HttpClient _client;
  late Completer<HttpClientResponse> _responseCompleter;

  FliqRequest(String method, String url, HttpClient client) {
    _responseCompleter = Completer<HttpClientResponse>();
    client.openUrl(method, Uri.parse(url)).then((request) {
      _client = client;
      _request = request;
    });
  }

  FliqRequest path(String pathSegment) {
    var newUri = Uri.parse('${_request.uri}$pathSegment');
    _client.openUrl(_request.method, newUri).then((request) {
      _request = request;
    });
    return this;
  }

  FliqRequest query(String key, String value) {
    var separator = _request.uri.query.isEmpty ? '?' : '&';
    var newUri = Uri.parse('${_request.uri}$separator$key=$value');
    _client.openUrl(_request.method, newUri).then((request) {
      _request = request;
    });
    return this;
  }

  FliqRequest header(String key, String value) {
    _request.headers.add(key, value);
    return this;
  }

  FliqRequest json(Map<String, dynamic> data) {
    _request
      ..headers.contentType = ContentType.json
      ..write(jsonEncode(data));
    return this;
  }

  Future<HttpClientResponse> go() async {
    await _request.close().then((HttpClientResponse response) {
      _responseCompleter.complete(response);
    });

    return _responseCompleter.future;
  }

  Future<T> readOne<T>(T Function(Map<String, dynamic>) fromMap) async {
    final response = await go();

    if (response.statusCode == HttpStatus.ok) {
      final jsonData = await response.transform(utf8.decoder).join();
      return fromMap(jsonDecode(jsonData));
    } else {
      throw Exception('Request failed with status: ${response.statusCode}');
    }
  }
}