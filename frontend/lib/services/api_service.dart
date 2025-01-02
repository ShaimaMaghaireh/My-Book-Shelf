import 'dart:convert';
import 'package:frontend/models/popular.dart';
import 'package:frontend/models/user.dart';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class ApiService {

//final String baseUrl = "http://10.0.2.2:3001/books";  //? url for emulator
//final String baseUrl='http://127.0.0.1:3001/books';  //?url for windows
//final String baseUrl='http://10.0.2.2:3001/books'; //? url for chrome
// final String baseUrl='http://192.168.100.114:3001/books'; //? myphone
final String baseUrl='http://192.168.243.213:3003/books'; //? myphone

//? Fetch all books
  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse(baseUrl));
   // print('shaima?????');
     print(baseUrl);

    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((book) => Book.fromJson(book)).toList();
    } else {
      throw Exception("Failed to load books");
    }
  }
//todo: Fetch popular books
   final String baseUrl3 = "http://192.168.243.213:3003/popular";
    //final String baseUrl3 = "http://10.0.2.2:3001/popular";//?for emulator
  Future<List<popularBook>> fetchPopularBooks() async {
    print ('object');
    final response = await http.get(Uri.parse(baseUrl3));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => popularBook.fromJson(json)).toList();
    } else {
      print('object');
      throw Exception('Failed to fetch popular book');
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


   Future<Book> fetchBookByTitle(String bookTitle) async {
    final response = await http.get(Uri.parse(baseUrl));
    //('$baseUrl/books/title/$bookTitle')
    if (response.statusCode == 200) {
      return Book.fromJson(json.decode(response.body));  // Assuming your Book model has a fromJson method
    } else {
      throw Exception('Failed to load book details');
    }
  }

//todo: Fetch user 
 final String baseUrl2 = "http://192.168.243.213:3003/users"; // Replace with your API URL
//final String baseUrl2 = "http://10.0.2.2:3001/users";//?for emulator
 Future<User> fetchUser() async {
  final response = await http.get(Uri.parse(baseUrl2));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    if (data.isNotEmpty) {
      return User.fromJson(data[1]); // Use the first user in the list
    } else {
      throw Exception('No user data found');
    }
  } else {
    throw Exception('Failed to load user data');
  }
}

  //? Update favorite status of a popular book
  Future<void> updateFavoriteStatus(String id, bool isFavorite) async {
    final response = await http.put(
      Uri.parse('$baseUrl/popular/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'isFavorite': isFavorite}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update favorite status');
    }
  }


}

