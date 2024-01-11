// lib/src/fliq_graphql.dart
import 'dart:io';
import 'fliq_request.dart';

class FliqGraphQLRequest extends FliqRequest {
  FliqGraphQLRequest(HttpClient client, String url) : super('POST', url, client);

  FliqGraphQLRequest query(String query) {
    return _setup('query', query);
  }

  FliqGraphQLRequest mutation(String mutation) {
    return _setup('mutation', mutation);
  }

  FliqGraphQLRequest subscription(String subscription) {
    return _setup('subscription', subscription);
  }

  FliqGraphQLRequest _setup(String operationType, String operation) {
    final requestBody = {'query': '$operationType { $operation }'};
    json(requestBody);
    return this;
  }

  Future<WebSocket> goWebSocket() async {
    final request = await _client.openUrl('GET', Uri.parse(requestUri()));
    final webSocket = await request.websocket();
    return webSocket;
  }
}
