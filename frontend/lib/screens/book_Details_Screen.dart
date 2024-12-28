import 'package:flutter/material.dart';
import 'package:frontend/services/api_service.dart';  // Assuming ApiService has a fetchBookByTitle method
import '../models/book.dart';

// class BookDetailsScreen extends StatelessWidget {
//   final Book book;

//   // Constructor to receive the book details
//   BookDetailsScreen({required this.book});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(book.title),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Image.network(book.image), // Book image
//             SizedBox(height: 10),
//             Text(
//               book.title,
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text(
//               'Author: ${book.author}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             Text('Available Copies: ${book.availableCopies}', style: TextStyle(fontSize: 16)),
//             Text('Total Copies: ${book.totalCopies}', style: TextStyle(fontSize: 16)),
//             SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: () {
//                 // Add action to borrow or add to read list, etc.
//               },
//               child: Text('Borrow'),
//             ),
//             // Add other book details like description, etc. if needed
//           ],
//         ),
//       ),
//     );
//   }
// }


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
// class BookDetailsScreen extends StatefulWidget {
// final String bookTitle; // Passing bookTitle to fetch book details

//   BookDetailsScreen({required this.bookTitle});

//   @override
//   _BookDetailsScreenState createState() => _BookDetailsScreenState();
// }

// class _BookDetailsScreenState extends State<BookDetailsScreen> {
//   late Future<Book> bookDetails;

//   @override
//   void initState() {
//     super.initState();
//     //? Fetch book details when the screen is loaded
//     bookDetails = ApiService().fetchBookByTitle(widget.bookTitle);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF6AD6F7),
//         title: Text('Book Details', style: TextStyle(fontWeight: FontWeight.bold)),
//       ),
//       body: FutureBuilder<Book>(
//         future: bookDetails,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             final book = snapshot.data!;
//             return Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Image.network(book.image, fit: BoxFit.cover),
//                   SizedBox(height: 16),
//                   Text(book.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//                   Text('by ${book.author}', style: TextStyle(fontSize: 18)),
//                   SizedBox(height: 16),
//                   Text('Available Copies: ${book.availableCopies}', style: TextStyle(fontSize: 16)),
//                   Text('Total Copies: ${book.totalCopies}', style: TextStyle(fontSize: 16)),
//                   SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () {
//                       // Handle book borrowing or any other actions
//                     },
//                     child: Text('Borrow this Book'),
//                   ),
//                   SizedBox(height: 16),
//                   Text('PDF Link: ${book.pdf}', style: TextStyle(fontSize: 16)),
//                 ],
//               ),
//             );
//           } else {
//             return Center(child: Text('No book data available.'));
//           }
//         },
//       ),
//     );
//   }
// }
