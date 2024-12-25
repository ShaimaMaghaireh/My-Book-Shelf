// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ReadListService {
//   final String baseUrl = "http://10.0.2.2:3001";

//   Future<bool> addToReadList(String userId, String bookId) async {
//     try {
//       final response = await http.post(
//         Uri.parse("$baseUrl/read-list"),
//         headers: {"Content-Type": "application/json"},
//         body: json.encode({"userId": userId, "bookId": bookId}),
//       );

//       if (response.statusCode == 200) {
//         return true; // Successfully added
//       } else {
//         return false; // Failed to add
//       }
//     } catch (e) {
//       print("Error: $e");
//       return false;
//     }
//   }

//   Future<List<dynamic>> fetchReadList(String userId) async {
//     try {
//       final response = await http.get(Uri.parse("$baseUrl/users/$userId"));

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         return data['readList'] ?? [];
//       } else {
//         throw Exception("Failed to fetch read list");
//       }
//     } catch (e) {
//       print("Error: $e");
//       return [];
//     }
//   }
// }
