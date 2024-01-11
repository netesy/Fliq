// lib/src/fliq_form.dart
import 'dart:convert';
import 'fliq_request.dart'; // Import FliqRequest


extension FormExtension on FliqRequest {
  /// Appends form data and/or files to the request as part of a multipart form.
  ///
  /// Example:
  /// ```dart
  /// final response = await client.post('https://example.com/upload')
  ///     .form(
  ///       fields: {'key1': 'value1', 'key2': 'value2'},
  ///       files: [FormFile('file1', 'example.txt', [/* file bytes */])],
  ///     )
  ///     .go();
  /// ```
  FliqRequest form({Map<String, String> fields = const {}, List<FormFile> files = const []}) {
    if (fields.isNotEmpty) {
      for (var entry in fields.entries) {
        request.add(utf8.encode('--boundary\r\n'
            'Content-Disposition: form-data; name="${entry.key}"\r\n\r\n'
            '${entry.value}\r\n'));
      }
    }

    if (files.isNotEmpty) {
      for (var file in files) {
        request.add(file.toRequest());
      }
    }

    request.add(utf8.encode('--boundary--\r\n'));

    return this;
  }
}

/// Represents a file in a multipart form data request.
class FormFile {
  late String fieldName;
  late String fileName;
  late List<int> fileBytes;

  /// Constructs a new instance of MultipartFile.
  FormFile(this.fieldName, this.fileName, this.fileBytes);

  /// Converts the file data to a format suitable for a multipart form data request.
  List<int> toRequest() {
    var header = '--boundary\r\n'
        'Content-Disposition: form-data; name="$fieldName"; filename="$fileName"\r\n'
        'Content-Type: application/octet-stream\r\n\r\n';
    var footer = '\r\n';

    return [
      ...utf8.encode(header),
      ...fileBytes,
      ...utf8.encode(footer),
    ];
  }
}