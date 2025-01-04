import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/models/popular.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/models/book.dart';
import 'package:frontend/services/read_list_service.dart';
import '../models/book.dart';
import '../services/api_service.dart';
import 'read_list_screen.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'book_Details_Screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;


String _getFilePath(String title) {
  final directory = Directory('/storage/emulated/0/Download');
  return '${directory.path}/$title.pdf';
}


class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  late Future<List<Book>> books;
  late Future<List<popularBook>> popularBooks;
  TextEditingController _searchController = TextEditingController();
 int _selectedIndex = 0;
 final List<Book> readingList = [];
  @override
  void initState() {
    super.initState();
    books = ApiService().fetchBooks();
    popularBooks = ApiService().fetchPopularBooks(); // Fetch popular books
  }


  void _toggleFavorite(popularBook book) async {
    setState(() {
      book.isFavorite = !book.isFavorite;
    });

    await ApiService().updateFavoriteStatus(book.id, book.isFavorite);
  }

void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; //? Update the selected index in bottom navigation bar
    });
  }

// Modify _onSearchChanged to return only the book you searched for
Future<List<Book>> _onSearchChanged() async {
  if (_searchController.text.isNotEmpty) {
    // Search for the book based on the title
    List<Book> searchResults = await ApiService().searchBooks(_searchController.text);

    // Find the book that exactly matches the title of the search query
    List<Book> matchingBooks = searchResults
        .where((book) => book.title.toLowerCase() == _searchController.text.toLowerCase())
        .toList();

    // Return the matching books (if any) or an empty list if no match is found
    return matchingBooks;
  } else {
    return []; // Return an empty list if search is empty
  }
}



void _showSearchResults(BuildContext context, List<Book> books) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Search Results'),
      content: Container(
        width: 300, // Set the width of the dialog
        height: 300, // Set the height of the dialog
        child: books.isNotEmpty
            ? ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  Book book = books[index];
                  return ListTile(
                    title: Text(book.title),
                    subtitle: Text(book.author),
                    leading: Image.network(book.image),
                  );
                },
              )
            : Center(
                child: Text('No books found.'),
              ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Close'),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
      image:NetworkImage('https://i.etsystatic.com/23519655/r/il/9dfa6d/6145262663/il_fullxfull.6145262663_g2h0.jpg'),fit:BoxFit.cover,opacity:0.5 ),
                color: Color.fromARGB(255, 136, 157, 247),
              ),
              child: Text(
                'More Services',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: Text('About App',style: 
              TextStyle(fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 84, 113, 195),
              letterSpacing: 2),),
              onTap: () {
                // Handle item tap
    Navigator.push( context, MaterialPageRoute(builder: (context) => AboutScreen()),
                );
              },
            ),
           ListTile(
  title: Text('Book Review',style: 
              TextStyle(fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 84, 113, 195),
              letterSpacing: 2)),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookReviewScreen()),
    );
  },
),
ListTile(
              title: Text('Profile',style: 
              TextStyle(fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 84, 113, 195),
              letterSpacing: 2)),
              onTap: () {
                // Handle item tap
    Navigator.push( context, MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              title: Text('Reading List',style: 
              TextStyle(fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 84, 113, 195),
              letterSpacing: 2)),
              onTap: () {
                // Handle item tap
              Navigator.push( context, MaterialPageRoute(builder: (context) => ReadingListPage()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor:Color.fromRGBO(143, 208, 243, 1),
        title: Text(textAlign: TextAlign.center,'Fantasy Library',
        style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        children: [
         Padding(
  padding: const EdgeInsets.all(8.0),
  child: TextField(
    controller: _searchController,
    onChanged: (value) => _onSearchChanged(),
    decoration: InputDecoration(
      labelText: 'Search Books',
      prefixIcon: Icon(Icons.search),
      suffixIcon: IconButton(
        onPressed: () async {
          // Trigger the search and get results
          List<Book> searchResults = await _onSearchChanged(); // Await the search results
          _showSearchResults(context, searchResults); // Show the results in an AlertDialog
        },
        icon: Icon(Icons.filter_list),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
),
       Text(
              'Recomended Books',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          Container(
            width: 150,
            height:480,
            child: FutureBuilder<List<Book>>(
              future: books,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  List<Book> books = snapshot.data!;
                  return ListView.builder(
                   scrollDirection: Axis.horizontal,
                    itemCount: books.length,
                    itemBuilder: (context, index)
                     {
                  return InkWell(
                    onTap: () {
                     Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetailsScreen(book: books[index]),
                          ),
                        );
                  },
                    child: Card(
                     semanticContainer: true,
                     clipBehavior: Clip.antiAliasWithSaveLayer,
                      child:Column(children: [
                      Image.network(books[index].image,fit: BoxFit.fill,width: 280,height: 350,),
                      Text(books[index].title,style: TextStyle(fontSize:25,color:Color.fromARGB(255, 51, 97, 178) ),),
                      Text(books[index].author,style: TextStyle(fontWeight: FontWeight.bold),),
                   
                       
                    ],),
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),),
                      elevation: 5,
                      margin: EdgeInsets.all(20),
                    ),
                  );
                    },
                  );
                } else {
                  return Center(child: Text('No books available.'));
                }
              },
            ),
          ),

Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Popular Books',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder<List<popularBook>>(
            future: popularBooks,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                List<popularBook> popularBooks = snapshot.data!;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: popularBooks.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                            PopularBookDetailsScreen(popularBooks:popularBooks[index]),
                          ),
                        );
                      },
                      child: Card(
                        child: Column(
                          children: [
                            Expanded(
                              child: Image.network(
                                popularBooks[index].image1,
                                fit: BoxFit.cover,
                              ),
                            ),
                            ListTile(
                              title: Text(popularBooks[index].title1),
                              trailing: IconButton(
                                icon: Icon(
                                  popularBooks[index].isFavorite
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: popularBooks[index].isFavorite
                                      ? Colors.yellow
                                      : Colors.grey,
                                ),
                                onPressed: () =>
                        _toggleFavorite(popularBooks[index]
                       ),
                       ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: Text('No popular books available.'));
              }
            },
          ),
        ],
      ),
       bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Color.fromRGBO(143, 208, 243, 1), // Custom background color
        selectedItemColor: Colors.black, // Custom selected item color
        unselectedItemColor: Colors.grey, // Custom unselected item color
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed, // Custom style
        elevation: 10.0, // Add shadow to the navigation bar
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'My List',
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(143, 208, 243, 1),
        title: Text('About the App', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Container(
        decoration: BoxDecoration(
      image: DecorationImage(
      image:NetworkImage('https://t4.ftcdn.net/jpg/03/40/07/85/360_F_340078556_YD52qpLaiTbO5E0OF90FuOaAq3sZr8yF.jpg'),
      fit:BoxFit.cover)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: <Widget>[
              // About Title Container
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'About This App',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 8, 38, 93),
                  ),
                ),
              ),
              SizedBox(height: 20),
        
              // Description Text
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'This app offers a variety of services to help users manage their book collection. '
                  //'From purchasing plants to tracking your plant care, we provide tools to ensure '
                  'You can download the books,add the books to your reading List,and '
                  'search for specific books.Here are some of the features we offer:'
                  //'your plants thrive. Here are some of the features we offer:'
                  ,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
              SizedBox(height: 20),
        
              // Services Header
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'Services We Offer:',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 8, 38, 93),
                  ),
                ),
              ),
              SizedBox(height: 10),
        
              // Services List
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  '1.Search for Books\n'
                  '2.Write a review \n'
                  '3. Download your books\n',
                  //'4. Community Sharing and Advice\n',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
              SizedBox(height: 20),
        
              // Contact Text
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  'For more information or assistance, feel free to contact our support team.',
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookReviewScreen extends StatefulWidget {
  @override
  _BookReviewScreenState createState() => _BookReviewScreenState();
}

class _BookReviewScreenState extends State<BookReviewScreen> {
  late Future<List<Book>> books;
  late Future<List<popularBook>> popularBooks;//todo
  @override
  void initState() {
    super.initState();
    books = ApiService().fetchBooks(); 
    popularBooks = ApiService().fetchPopularBooks();//Fetch the list of books//todo
  }

  // Function to handle the review submission
  void _submitReview(Book book, String review) {
    // Here you can send the review to the backend for saving
    // Example API call can be implemented in your ApiService
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Review for "${book.title}" saved successfully')),
    );
    Navigator.pop(context); // Close the dialog
  }

  // Function to display the review dialog
  void _showReviewDialog(BuildContext context, Book book) {
    final TextEditingController _reviewController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Review: ${book.title}'),
          content: TextField(
            controller: _reviewController,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Write your review',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_reviewController.text.isNotEmpty) {
                  _submitReview(book, _reviewController.text);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Review cannot be empty')),
                  );
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6AD6F7),
        title: Text(
          'Book Reviews',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Book>>(
        future: books,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<Book> books = snapshot.data!;
            return ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(
                    books[index].image,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                  title: Text(books[index].title),
                  subtitle: Text(books[index].author),
                  trailing: Icon(Icons.edit),
                  onTap: () => _showReviewDialog(context, books[index]),
                );
              },
            );
          } else {
            return Center(child: Text('No books available.'));
          }
        },
      ),
    );
  }
}
 
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<User> user; // Future to fetch user data
 
  @override
  void initState() {
    super.initState();
    user = ApiService().fetchUser(); //? Fetch user information from MongoDB
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF6AD6F7),
        elevation: 0,
        title: Text('Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: FutureBuilder<User>(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            User user = snapshot.data!;
            return Column(
              children: [
                _buildHeader(context, user),
                Expanded(child: _buildMenuOptions()),
              ],
            );
          } else {
            return Center(child: Text('No user data found.'));
          }
        },
      ),
    );
  }

  // Header Section
  Widget _buildHeader(BuildContext context, User user) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF6AD6F7),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
        child: Column(
          children: [
            CircleAvatar(child: Image.network(user.profileImage),maxRadius: 80,),
            SizedBox(height: 16),
            Text(
              user.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8),
         
          ],
        ),
      ),
    );
  }

  // Menu Options
  Widget _buildMenuOptions() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildMenuItem(Icons.person, 'Account Information'),
        _buildMenuItem(Icons.lock, 'Password'),
        _buildMenuItem(Icons.settings, 'Settings'),
        _buildMenuItem(Icons.help, 'Help & Support'),
        _buildMenuItem(Icons.logout, 'Log Out', color: Colors.red),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {Color? color}) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: color ?? Colors.black),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        onTap: () {
          // Define actions for menu items here
        },
      ),
    );
  }
}





