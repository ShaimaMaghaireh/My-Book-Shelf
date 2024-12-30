import 'package:flutter/material.dart';
import 'package:frontend/models/popular.dart';
import 'package:frontend/services/api_service.dart';  // Assuming ApiService has a fetchBookByTitle method
import '../models/book.dart';
import '../models/popular.dart';
class BookDetailsScreen extends StatefulWidget {
  final Book book;

  // Constructor to receive the book details
  BookDetailsScreen({required this.book});

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  late Book book;

  @override
  void initState() {
    super.initState();
    book = widget.book;  // Initialize with the book passed from the list
  }

  // Update book availability when borrowed
  void _borrowBook() {
    setState(() {
      if (book.availableCopies > 0) {
        book.availableCopies;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(book.image), // Book image
                SizedBox(height: 10),
                Text(
                  book.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Author: ${book.author}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text('Available Copies: ${book.availableCopies}', style: TextStyle(fontSize: 16)),
                Text('Total Copies: ${book.totalCopies}', style: TextStyle(fontSize: 16)),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _borrowBook,
                  child: Text('Borrow'),
                ),
                // Add other book details like description, etc. if needed
              ],
            ),
          ),
        ],
      ),
    );
  }
}
// Import your PopularBook model

class PopularBookDetailsScreen extends StatefulWidget {
  final popularBook popularBooks;

  const PopularBookDetailsScreen({Key? key, required this.popularBooks}) : super(key: key);

  @override
  _PopularBookDetailsScreenState createState() => _PopularBookDetailsScreenState();
}

class _PopularBookDetailsScreenState extends State<PopularBookDetailsScreen> {
  bool isFavorite = false; // Example of a dynamic state variable

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.popularBooks.title1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(widget.popularBooks.image1), // Display the book's image
            const SizedBox(height: 16),
            Text(
              widget.popularBooks.title1,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Rating: ${widget.popularBooks.rating}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              widget.popularBooks.description ?? "No description available.",
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
              child: Text(isFavorite ? 'Remove from Favorites' : 'Add to Favorites'),
            ),
          ],
        ),
      ),
    );
  }
}