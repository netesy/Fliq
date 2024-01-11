// lib/src/fliq_lib.dart
import 'dart:io';
import 'fliq_graphql.dart';
import 'fliq_request.dart';


/// The main class for making HTTP requests using the Fliq library.
///
/// Example:
/// ```dart
/// final client = Fliq();
/// final response = await client.get('https://example.com').go();
/// print('Status Code: ${response.statusCode}');
/// client.close();
/// ```
class Fliq {
  late HttpClient _client;

  Fliq() {
    _client = HttpClient();
  }

  /// Initiates a GET request with the specified [url].
  ///
  /// Example:
  /// ```dart
  /// final client = Fliq();
  /// final response = await client.get('https://example.com').go();
  /// print('Status Code: ${response.statusCode}');
  /// client.close();
  /// ```
  FliqRequest get(String url) {
    return FliqRequest('GET', url, _client);
  }

  /// Initiates a POST request with the specified [url].
  ///
  /// Example:
  /// ```dart
  /// final client = Fliq();
  /// final response = await client.post('https://example.com').go();
  /// print('Status Code: ${response.statusCode}');
  /// client.close();
  /// ```
  FliqRequest post(String url) {
    return FliqRequest('POST', url, _client);
  }

  /// Initiates a PUT request with the specified [url].
  ///
  /// Example:
  /// ```dart
  /// final client = Fliq();
  /// final response = await client.put('https://example.com').go();
  /// print('Status Code: ${response.statusCode}');
  /// client.close();
  /// ```
  FliqRequest put(String url) {
    return FliqRequest('PUT', url, _client);
  }

  /// Initiates a DELETE request with the specified [url].
  ///
  /// Example:
  /// ```dart
  /// final client = Fliq();
  /// final response = await client.delete('https://example.com').go();
  /// print('Status Code: ${response.statusCode}');
  /// client.close();
  /// ```
  FliqRequest delete(String url) {
    return FliqRequest('DELETE', url, _client);
  }


  FliqGraphQLRequest graphql(String url) {
    return FliqGraphQLRequest(_client, url);
  }


  /// Closes the underlying HttpClient.
  ///
  /// Example:
  /// ```dart
  /// final client = Fliq();
  /// // ... perform requests ...
  /// client.close();
  /// ```
  void close() {
    _client.close();
  }
}



