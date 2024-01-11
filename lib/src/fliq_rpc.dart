// import 'dart:convert';
// import 'fliq_request.dart';

// extension FliqRPC on FliqRequest {
//   Future<dynamic> rpcMethod(String method, [Map<String, dynamic>? params]) async {
//     final response = await post(_baseUrl)
//         .json({'jsonrpc': '2.0', 'method': method, 'params': params ?? {}, 'id': 1})
//         .go();

//     final jsonData = await response.transform(utf8.decoder).join();
//     final dynamic parsedResponse = json.decode(jsonData);

//     // Handle RPC response or error
//     if (parsedResponse.containsKey('result')) {
//       return parsedResponse['result'];
//     } else if (parsedResponse.containsKey('error')) {
//       throw Exception('RPC error: ${parsedResponse['error']}');
//     } else {
//       throw Exception('Invalid RPC response');
//     }
//   }

//   Future<void> rpcProcedure(String procedure, [Map<String, dynamic>? params]) async {
//     final response = await post(_baseUrl)
//         .json({'jsonrpc': '2.0', 'method': procedure, 'params': params ?? {}, 'id': 1})
//         .go();

//     final jsonData = await response.transform(utf8.decoder).join();
//     final dynamic parsedResponse = json.decode(jsonData);

//     // Handle RPC response or error
//     if (parsedResponse.containsKey('error')) {
//       throw Exception('RPC error: ${parsedResponse['error']}');
//     } else if (parsedResponse.containsKey('result')) {
//       // You may choose to do something with the result, or simply ignore it for procedures
//     } else {
//       throw Exception('Invalid RPC response');
//     }
//   }
// }