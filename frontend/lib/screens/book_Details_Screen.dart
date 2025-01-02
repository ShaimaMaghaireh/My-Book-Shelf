import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/popular.dart';
import 'package:frontend/services/api_service.dart';  // Assuming ApiService has a fetchBookByTitle method
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../models/popular.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'reading_list_provider.dart';


class ReadingListProvider with ChangeNotifier {
  final List<dynamic> _readingList = []; // Store both `Book` and `popularBook` objects

  List<dynamic> get readingList => _readingList;

  void addToReadingList(dynamic book) {
    if (!_readingList.contains(book)) {
      _readingList.add(book);
      notifyListeners();
    }
  }

  void removeFromReadingList(dynamic book) {
    _readingList.remove(book);
    notifyListeners();
  }
}

// class ReadingListManager {
//   static final ReadingListManager _instance = ReadingListManager._internal();

//   factory ReadingListManager() {
//     return _instance;
//   }

//   ReadingListManager._internal();

//   final List<Book> _readingList = [];

//   List<Book> get readingList => _readingList;

//   void addBook(Book book) {
//     if (!_readingList.contains(book)) {
//       _readingList.add(book);
//     }
//   }

//   void removeBook(Book book) {
//     _readingList.remove(book);
//   }
// }

String _getFilePath(String title) {
  final directory = Directory('/storage/emulated/0/Download');
  return '${directory.path}/$title.pdf ';
}
class BookDetailsScreen extends StatefulWidget {
  final Book book;

  // Constructor to receive the book details
  BookDetailsScreen({required this.book});

  @override
  _BookDetailsScreenState createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
late Book book;
 int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; //? Update the selected index in bottom navigation bar
    });
  }
// //todo
//   Future<String> getUniqueFilePath(String basePath) async {
//   var filePath = basePath;
//   int counter = 1;

//   // Loop to find a unique file name if the file already exists
//   while (await File(filePath).exists()) {
//     filePath = basePath.replaceFirst('.pdf', '($counter).pdf');
//     counter++;
//   }
//   return filePath;
// }

// Future<void> saveFile(String basePath, List<int> fileBytes) async {
//   final filePath = await getUniqueFilePath(basePath);
//   final file = File(filePath);

//   try {
//     await file.writeAsBytes(fileBytes);
//     print('File saved at $filePath');
//   } catch (e) {
//     print('Error saving file: $e');
//   }
// }

//   final String fileName = 'Ekadolli.pdf';
//   final String downloadPath = '/storage/emulated/0/Download';

  

//   Future<void> downloadFile() async {
//   if (await Permission.storage.request().isGranted) {
//     final List<int> fileBytes = [0x25, 0x50, 0x44, 0x46];
//     final String basePath = '$downloadPath/$fileName';

//     try {
//       await saveFile(basePath, fileBytes);
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('File downloaded successfully.'),
//       ));
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//         content: Text('Failed to download file: $e'),
//       ));
//     }
//   } else {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text('Storage permission denied.'),
//     ));
//   }
// }


//todo

// String _getFilePath(String title) {
//   final directory = Directory('/storage/emulated/0/Download');
//   return '${directory.path}/$title.pdf ';
// }
Future<void> _downloadPDF(String url, String title) async {
  final dio = Dio();

  try {
    // Request storage permission
    bool hasPermission = await _requestStoragePermission();
    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission is required')),
      );
      return;
    }

    // Define save path
    String savePath = _getFilePath(title);

    // Download file
    await dio.download(url, savePath);

    // Notify user of success
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloaded $title to Downloads folder')),
    );
  } catch (e) {
    // Notify user of failure
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to download file: $e')),
    );
  }
}
void checkpermissions() async { 
  var status = await Permission.camera.status;
   if (!status.isGranted)
    { await Permission.camera.request(); }
     }

 Future<bool> _requestStoragePermission() async {
  var status = await Permission.storage.request();
  print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
  print(status.isGranted);
  if (!status.isGranted) {
    status = await Permission.storage.request();
  }
  return true;
}

  @override
  void initState() {
    super.initState();
    book = widget.book;  //? Initialize with the book passed from the list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
     body: SafeArea(
        child: ListView(
          children: [
            // Book Image and Actions
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.network(book.image,
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //? Book Information
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                     book.title,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      book.author,
                      style: TextStyle(
                        fontSize: 22,fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Icon(Icons.star_half, color: Colors.amber, size: 20),
                        Icon(Icons.star_border, color: Colors.amber, size: 20),
                        SizedBox(width: 5),
                        Text(
                          '4.0 / 5.0',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text('Total Copies', style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            Text('${book.totalCopies}', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        Column(
                          children: [
                            Text('Available', style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            Text('${book.availableCopies}', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                SizedBox(height: 30),
              
  //                   ElevatedButton(
  //                     style: ElevatedButton.styleFrom(
  //                       backgroundColor: Color.fromARGB(255, 151, 185, 248), // Orange button color
  //                       shape: RoundedRectangleBorder(
  //                         borderRadius: BorderRadius.circular(30),
  //                       ),
  //                     ),
  //                     onPressed: () {

  //                      // Add book to the reading list
  //  setState(() {
  //                       ReadingListManager().removeBook(book);
  //                     });
  //                     ScaffoldMessenger.of(context).showSnackBar(
  //                       SnackBar(content: Text('${book.title} removed from your Reading List.')),
  //                     );
  //                     },
  //                     child: Center(
  //                       child: Padding(
  //                         padding: const EdgeInsets.symmetric(vertical: 15),
  //                         child: Text(
  //                           'Borrow',
  //                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 171, 196, 247), // Orange button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      // onPressed:downloadFile,
                      onPressed: () async {
                        print('object');
                        String bookId =book.id;//? fetch the id of the book
                       await _downloadPDF('http://192.168.100.90:3003/books/$bookId/download', 
                       book.title);
                      //   await _downloadPDF('http://192.168.100.114:3001/books/676ba0c357ba2eeb0308f246/download', 
                      //  books[index].title); 
                       },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Download',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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

  late popularBook popularBooks;

Future<void> _downloadPDF(String url, String title) async {
  final dio = Dio();

  try {
    // Request storage permission
    bool hasPermission = await _requestStoragePermission();
    if (!hasPermission) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Storage permission is required')),
      );
      return;
    }

    // Define save path
    String savePath = _getFilePath(title);

    // Download file
    await dio.download(url, savePath);

    // Notify user of success
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Downloaded $title to Downloads folder')),
    );
  } catch (e) {
    // Notify user of failure
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to download file: $e')),
    );
  }
}
void checkpermissions() async { 
  var status = await Permission.camera.status;
   if (!status.isGranted)
    { await Permission.camera.request(); }
     }

     Future<bool> _requestStoragePermission() async {
  var status = await Permission.storage.request();
  print('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
  print(status.isGranted);
  if (!status.isGranted) {
    status = await Permission.storage.request();
  }
  return true;
}

  @override
  void initState() {
    super.initState();
    popularBooks = widget.popularBooks;  //? Initialize with the book passed from the list
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(popularBooks.title1),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            // Book Image and Actions
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image.network(popularBooks.image1,
                          fit: BoxFit.cover,
                          height: 200,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //? Book Information
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                   popularBooks.title1,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      popularBooks.author,
                      style: TextStyle(
                        fontSize: 22,fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Icon(Icons.star_half, color: Colors.amber, size: 20),
                        Icon(Icons.star_border, color: Colors.amber, size: 20),
                        SizedBox(width: 5),
                        Text(
                          '4.0 / 5.0',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text('Rates', style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold)),
                            SizedBox(height: 5),
                            Text('${popularBooks.rating}', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        // Column(
                        //   children: [
                        //     Text('Available', style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold)),
                        //     SizedBox(height: 5),
                        //     Text('${book.availableCopies}', style: TextStyle(fontWeight: FontWeight.bold)),
                        //   ],
                        // ),
                      ],
                    ),
                SizedBox(height: 30),
              
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 151, 185, 248), // Orange button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      onPressed: () {
                          // Add book to the reading list
    Provider.of<ReadingListProvider>(context, listen: false)
        .addToReadingList(popularBooks);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${popularBooks.title1} added to Reading List!')),
    );
                      },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Borrow',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 171, 196, 247), // Orange button color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      //onPressed: () {},
                      onPressed: () async {
                        print('object');
                        String bookId1 = popularBooks.id;//? fetch the id of the book
                       await _downloadPDF('http://192.168.100.90:3003/popular/$bookId1/download', 
                       popularBooks.title1);
                       },
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            'Download',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ReadingListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final readingList = Provider.of<ReadingListProvider>(context).readingList;
    return Scaffold(
      appBar: AppBar(title: Text("Reading List")),
      body: readingList.isEmpty
          ? Center(child: Text("No books in the reading list"))
          : ListView.builder(
              itemCount: readingList.length,
              itemBuilder: (context, index) {
                final book = readingList[index];
                return ListTile(
                  leading: Image.network(book.image1 ?? book.image),
                  title: Text(book.title1 ?? book.title),
                  subtitle: Text(book.author),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      Provider.of<ReadingListProvider>(context, listen: false)
                          .removeFromReadingList(book);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('${book.title1 ?? book.title} removed')),
                      );
                    },
                  ),
                );
              },
            ),
            
    );
  }
}