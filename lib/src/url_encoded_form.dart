// lib/src/url_encoded_form.dart
import 'dart:io';
import 'fliq_request.dart'; // Import FliqRequest

extension UrlEncodedFormExtension on FliqRequest {
  FliqRequest urlEncodedForm(Map<String, String> formData) {
    _request
      ..headers.contentType = ContentType('application', 'x-www-form-urlencoded')
      ..write(Uri(queryParameters: formData).query);
    return this;
  }
}