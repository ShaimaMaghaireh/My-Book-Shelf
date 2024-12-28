import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class ApiService {

final String baseUrl = "http://10.0.2.2:3002/books";  //? url for emulator
 //final String baseUrl='http://127.0.0.1:3001/books';  //?url for windows
 //final String baseUrl='http://10.0.2.2:3001/books'; //? url for chrome
//final String baseUrl='http://192.168.100.114:3001/books'; //? myphone

//? Fetch all books
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


 //todo: Fetch books based on a search query
  Future<List<Book>> searchBooks(String query) async {
    final response = await http.get(Uri.parse(baseUrl));
 //get(Uri.parse('$baseUrl/search-books?title=$query'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
       print('The book is found');
      return data.map((book) => Book.fromJson(book)).toList();
      
    } else {
      throw Exception('Failed to fetch books');
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

