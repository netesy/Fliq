// lib/src/fliq_request.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';



/// Represents an HTTP request made with the Fliq library.
///
/// Example:
/// ```dart
/// final client = Fliq();
/// final response = await client.get('https://example.com').go();
/// print('Status Code: ${response.statusCode}');
/// client.close();
/// ```
class FliqRequest {
  late HttpClientRequest _request;
  late HttpClient _client;
  late Completer<HttpClientResponse> _responseCompleter;

  HttpClientRequest get request => _request;

  /// Constructs a new instance of FliqRequest.
  ///
  /// Example:
  /// ```dart
  /// final client = Fliq();
  /// final request = client.get('https://example.com');
  /// ```
  FliqRequest(String method, String url, HttpClient client) {
    _responseCompleter = Completer<HttpClientResponse>();
    client.openUrl(method, Uri.parse(url)).then((request) {
      _client = client;
      _request = request;
    });
  }

  /// Appends a path segment to the request's URL.
  ///
  /// Example:
  /// ```dart
  /// final response = await client.get('https://example.com').path('/api').go();
  /// ```
  FliqRequest path(String pathSegment) {
    var newUri = Uri.parse('${_request.uri}$pathSegment');
    _client.openUrl(_request.method, newUri).then((request) {
      _request = request;
    });
    return this;
  }

  /// Appends a query parameter to the request's URL.
  ///
  /// Example:
  /// ```dart
  /// final response = await client.get('https://example.com').query('page', '2').go();
  /// ```
  FliqRequest query(String key, String value, String query) {
    var separator = _request.uri.query.isEmpty ? '?' : '&';
    var newUri = Uri.parse('${_request.uri}$separator$key=$value');
    _client.openUrl(_request.method, newUri).then((request) {
      _request = request;
    });
    return this;
  }

  /// Adds a header to the request.
  ///
  /// Example:
  /// ```dart
  /// final response = await client.get('https://example.com').header('Authorization', 'Bearer token').go();
  /// ```
  FliqRequest header(String key, String value) {
    _request.headers.add(key, value);
    return this;
  }

  /// Sets the request body to the JSON-encoded [data].
  ///
  /// Example:
  /// ```dart
  /// final response = await client.post('https://example.com').json({'key': 'value'}).go();
  /// ```
  FliqRequest json(Map<String, dynamic> data) {
    _request
      ..headers.contentType = ContentType.json
      ..write(jsonEncode(data));
    return this;
  }

  /// Executes the HTTP request and returns a Future with the response.
  ///
  /// Example:
  /// ```dart
  /// final response = await client.get('https://example.com').go();
  /// print('Status Code: ${response.statusCode}');
  /// ```
  Future<HttpClientResponse> go() async {
    await _request.close().then((HttpClientResponse response) {
      _responseCompleter.complete(response);
    });

    return _responseCompleter.future;
  }

  /// Reads the response body as JSON and applies the [fromMap] function to create an object.
  ///
  /// Example:
  /// ```dart
  /// final data = await client.get('https://example.com').readOne((json) => MyObject.fromMap(json));
  /// ```
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
