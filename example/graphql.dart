import 'dart:convert';
import 'dart:io';
import 'package:fliq/fliq.dart';

void main() async {
  final client = Fliq();

  // GraphQL Query (GET request)
  final query = '''
    query {
      user(id: 1) {
        id
        name
        email
      }
    }
  ''';

  final getResponse = await client.graphql('https://example.com/graphql')
      .query(query)
      .header('Authorization', 'Bearer token')
      .go();

  print('GraphQL GET Response:');
  await _printResponse(getResponse);

  // GraphQL Mutation (POST request)
  final mutation = '''
    mutation {
      updateUser(id: 1, name: "John") {
        id
        name
      }
    }
  ''';

  final postResponse = await client.graphql('https://example.com/graphql')
      .mutation(mutation)
      .header('Authorization', 'Bearer token')
      .go();

  print('\nGraphQL POST Response:');
  await _printResponse(postResponse);

  // GraphQL Mutation (PUT request)
  final putMutation = '''
    mutation {
      createUser(name: "Alice", email: "alice@example.com") {
        id
        name
        email
      }
    }
  ''';

  final putResponse = await client.graphql('https://example.com/graphql')
      .mutation(putMutation)
      .header('Authorization', 'Bearer token')
      .go();

  print('\nGraphQL PUT Response:');
  await _printResponse(putResponse);

  // GraphQL Mutation (DELETE request)
  final deleteMutation = '''
    mutation {
      deleteUser(id: 1) {
        id
        name
      }
    }
  ''';

  final deleteResponse = await client.graphql('https://example.com/graphql')
      .mutation(deleteMutation)
      .header('Authorization', 'Bearer token')
      .go();

  print('\nGraphQL DELETE Response:');
  await _printResponse(deleteResponse);

  client.close();
}

Future<void> _printResponse(HttpClientResponse response) async {
  final statusCode = response.statusCode;
  print('Status Code: $statusCode');

  if (statusCode == HttpStatus.ok) {
    final jsonData = await response.transform(utf8.decoder).join();
    print('Response Data: $jsonData');
  } else {
    print('Request failed with status: $statusCode');
  }
}
