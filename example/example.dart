import 'package:fliq/fliq.dart';

// Example usage:
void main() async {
  try {
    final client = Fliq();

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

    client.close();
  } catch (e) {
    print('Error: $e');
  }
}
