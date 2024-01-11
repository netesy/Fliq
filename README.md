# Fliq - Flutter Rest Client Library

Fliq is a simple and fluent Flutter library for building Restful clients with a focus on ease of use and readability. It provides a clean and concise API for making HTTP requests, GraphQL queries, supporting features such as hierarchical paths, query parameters, headers, and JSON request encoding.

## Getting Started

1. **Install the Package:**

   Add the following to your `pubspec.yaml` file:

   ```yaml
   dependencies:
     fliq: ^1.0.0
   ```

   Then run:

   ```bash
   flutter pub get
   ```

2. **Import Fliq:**

   ```dart
   import 'package:fliq/fliq.dart';
   ```

3. **Create an Instance:**

   ```dart
   final client = Fliq();
   ```

4. **Make REST Requests:**

   ```dart
   // Example 1: Hierarchical paths
   final response1 = await client
       .get('http://localhost:8080/api/book/1')
       .go();
   print('Example 1: ${response1.statusCode}');

   // Example 2: Hierarchical paths with path() method
   final response2 = await client
       .get('http://localhost:8080/api')
       .path('book')
       .path('1')
       .go();
   print('Example 2: ${response2.statusCode}');

   // Example 3: Query parameters
   final response3 = await client
       .get('/books')
       .query('page', '2')
       .go();
   print('Example 3: ${response3.statusCode}');

   // Example 4: Headers
   final response4 = await client
       .get('/book')
       .header('page', '2')
       .go();
   print('Example 4: ${response4.statusCode}');

   // Example 5: JSON request encoding
   final response5 = await client
       .post('/book')
       .json({'id': '1', 'title': 'Harry Potter'})
       .go();
   print('Example 5: ${response5.statusCode}');

   // Example 6: GraphQL Query
   final graphqlQuery = '''
     query {
       user(id: 1) {
         id
         name
         email
       }
     }
   ''';

   final graphqlResponse = await client.graphql('https://example.com/graphql')
       .query(graphqlQuery)
       .header('Authorization', 'Bearer token')
       .go();
   print('GraphQL Query Response: ${graphqlResponse.statusCode}');

   // Example 7: GraphQL Mutation
   final graphqlMutation = '''
     mutation {
       updateUser(id: 1, name: "John") {
         id
         name
       }
     }
   ''';

   final graphqlMutationResponse = await client.graphql('https://example.com/graphql')
       .mutation(graphqlMutation)
       .header('Authorization', 'Bearer token')
       .go();
   print('GraphQL Mutation Response: ${graphqlMutationResponse.statusCode}');

   // Example 8: GraphQL Subscription
   final graphqlSubscription = '''
     subscription {
       newMessage
     }
   ''';

   final webSocket = await client.graphql('wss://example.com/graphql')
       .subscription(graphqlSubscription)
       .header('Authorization', 'Bearer token')
       .goWebSocket();
   print('GraphQL Subscription (WebSocket opened)');

   // Handle the subscription using the WebSocket
   webSocket.listen((dynamic data) {
     print('Subscription Data: $data');
   });

   client.close();
   ```

   ```dart
   // Send either form data, file data, or both
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
   ```

## Methods

### Fliq

- `get(String url)`
- `post(String url)`
- `put(String url)`
- `delete(String url)`
- `graphql(String url)`
- `close()`

### FliqRequest

- `path(String pathSegment)`
- `query(String key, String value)`
- `header(String key, String value)`
- `json(Map<String, dynamic> data)`
- `form({Map<String, String> fields = const {}, List<FormFile> files = const []})`
- `go()`
- `readOne<T>(T Function(Map<String, dynamic>) fromMap)`


## Features

- **Hierarchical Paths:** Easily build hierarchical paths for your RESTful endpoints.

- **Query Parameters:** Add query parameters to your requests with a fluent API.

- **Headers:** Include custom headers in your requests for authentication or other purposes.

- **JSON Request Encoding:** Send JSON-encoded request bodies effortlessly.

- **GraphQL Support:** Make GraphQL requests seamlessly with a dedicated `graphql` method.

- **Form Data Support:** Send form data, file data, or both using the `form` method.

- **JSON Response Decoding:** Decode JSON responses into Dart objects using a provided mapping function.

- **Multiple HTTP Methods:** Support for various HTTP methods including GET, POST, PUT, and DELETE.

## Examples

Check the `example.dart` file for a comprehensive set of usage examples showcasing different features.

## Contributing

Contributions are welcome! Feel free to open issues, submit pull requests, or suggest improvements. Let's build a robust and user-friendly Flutter Rest Client library together!
