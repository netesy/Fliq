import 'dart:convert';
import 'dart:typed_data';
import 'package:fliq/fliq.dart';
// Example usage to send either form data, file data, or both
void main() async {
  try {
    final client = Fliq();

    // Example 1: Send only form data
    final response1 = await client
        .post('http://localhost:8080/api/data')
        .form(fields: {'key1': 'value1', 'key2': 'value2'})
        .go();
    print('Example 1: ${response1.statusCode}');

    // Example 2: Send only file data
    final fileBytes = Uint8List.fromList(utf8.encode('File contents'));
    final response2 = await client
        .post('http://localhost:8080/api/data')
        .form(files: [FormFile('file1', 'example.txt', fileBytes)])
        .go();
    print('Example 2: ${response2.statusCode}');

    // Example 3: Send both form data and file data
    final response3 = await client
        .post('http://localhost:8080/api/data')
        .form(
          fields: {'key1': 'value1', 'key2': 'value2'},
          files: [FormFile('file1', 'example.txt', fileBytes)],
        )
        .go();
    print('Example 3: ${response3.statusCode}');

    client.close();
  } catch (e) {
    print('Error: $e');
  }
}