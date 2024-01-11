import 'dart:convert';
import 'dart:io';
import 'fliq_request.dart';

/// Represents a GraphQL request made with the Fliq library.
class FliqGraphQLRequest extends FliqRequest {
  /// Constructs a new instance of FliqGraphQLRequest.
  ///
  /// Example:
  /// ```dart
  /// final client = Fliq();
  /// final graphqlRequest = client.graphql('https://example.com/graphql');
  /// ```
  FliqGraphQLRequest(HttpClient client, String url) : super('POST', url, client);

  /// Specifies a GraphQL query for the request.
  ///
  /// Example:
  /// ```dart
  /// final response = await client.graphql('https://example.com/graphql')
  ///     .query('''
  ///       query {
  ///         user(id: 1) {
  ///           id
  ///           name
  ///         }
  ///       }
  ///     ''')
  ///     .go();
  /// ```
  FliqGraphQLRequest query(String query) {
    return _setup('query', query);
  }

  /// Specifies a GraphQL mutation for the request.
  ///
  /// Example:
  /// ```dart
  /// final response = await client.graphql('https://example.com/graphql')
  ///     .mutation('''
  ///       mutation {
  ///         updateUser(id: 1, name: "John") {
  ///           id
  ///           name
  ///         }
  ///       }
  ///     ''')
  ///     .go();
  /// ```
  FliqGraphQLRequest mutation(String mutation) {
    return _setup('mutation', mutation);
  }

  /// Specifies a GraphQL subscription for the request.
  ///
  /// Example:
  /// ```dart
  /// final webSocket = await client.graphql('wss://example.com/graphql')
  ///     .subscription('''
  ///       subscription {
  ///         newMessage
  ///       }
  ///     ''')
  ///     .goWebSocket();
  /// ```
  FliqGraphQLRequest subscription(String subscription) {
    return _setup('subscription', subscription);
  }

  FliqGraphQLRequest _setup(String operationType, String operation) {
    final requestBody = {'query': '$operationType { $operation }'};
    json(requestBody);
    return this;
  }

  /// Executes the GraphQL request and returns a WebSocket for subscription operations.
  ///
  /// For subscription operations, use this method to establish a WebSocket connection.
  ///
  /// Example:
  /// ```dart
  /// final webSocket = await client.graphql('wss://example.com/graphql')
  ///     .subscription('''
  ///       subscription {
  ///         newMessage
  ///       }
  ///     ''')
  ///     .goWebSocket();
  ///
  /// // Handle the subscription using the WebSocket
  /// webSocket.listen((dynamic data) {
  ///   print('Subscription Data: $data');
  /// });
  /// ```
  Future<WebSocket> goWebSocket() async {
    final request = await _client.openUrl('GET', Uri.parse(requestUri()));
    final webSocket = await request.websocket();
    return webSocket;
  }
}
