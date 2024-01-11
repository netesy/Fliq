// lib/src/multipart_form.dart
import 'dart:io';

import 'fliq_request.dart'; // Import FliqRequest

extension MultipartFormExtension on FliqRequest {
  FliqRequest multipartForm(List<FormFile> files) {
    for (var file in files) {
      _request.add(file.toRequest(_request));
    }
    return this;
  }
}

class FormFile {
  late String fieldName;
  late String fileName;
  late List<int> fileBytes;
  late String contentType;

  FormFile({
    required this.fieldName,
    required this.fileName,
    required this.fileBytes,
    this.contentType = 'application/octet-stream',
  });

  List<dynamic> toRequest(HttpClientRequest request) {
    var boundary = '---boundary---';
    var body = <dynamic>[
      ...'--$boundary\r\n'
          'Content-Disposition: form-data; name="$fieldName"; filename="$fileName"\r\n'
          'Content-Type: $contentType\r\n'
          '\r\n',
      ...fileBytes,
      ...'\r\n--$boundary--\r\n',
    ].expand((e) => e is int ? [e] : e.codeUnits).toList();

    return body;
  }
}
