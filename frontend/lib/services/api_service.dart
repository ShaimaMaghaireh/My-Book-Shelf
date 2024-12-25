import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class ApiService {
  final String baseUrl = "http://10.0.2.2:3001/books"; // Use the appropriate backend URL

  // Fetch all books
  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse(baseUrl));
    print('shaima?????');
     print(baseUrl);

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((book) => Book.fromJson(book)).toList();
    } else {
      throw Exception("Failed to load books");
    }
  }

  // Add a new book
  Future<void> addBook(Book book) async {
    final response = await http.post(
      Uri.parse("$baseUrl/books"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(book.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception("Failed to add book");
    }
  }
}

