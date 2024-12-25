import 'package:flutter/material.dart';
import 'package:frontend/services/read_list_service.dart';
import '../models/book.dart';
import '../services/api_service.dart';
import 'read_list_screen.dart';


class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  late Future<List<Book>> books;
 int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    books = ApiService().fetchBooks();
  }
void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
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
              title: Text('About App'),
              onTap: () {
                // Handle item tap
    Navigator.push( context, MaterialPageRoute(builder: (context) => AboutScreen()),
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor:Color(0xFF6AD6F7) ,
        title: Text(textAlign: TextAlign.center,'Fantasy Library',
        style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
             // controller: _searchController,
             // onChanged: _onSearchChanged,
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                 suffixIcon:IconButton( onPressed: () {
              //_showSearchResults(context); // Show search results in AlertDialog
            },  icon: Icon(Icons.filter_list)),  
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          Container(
            width: 400,
            height: 700,
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
                   
                    itemCount: books.length,
                    itemBuilder: (context, index)
                     {
                  return  Card(
                 semanticContainer: true,
                 clipBehavior: Clip.antiAliasWithSaveLayer,
                    child:Column(children: [
                    Image.network(books[index].image,fit: BoxFit.fill),
                    Text(books[index].title,style: TextStyle(fontSize:25,color:Color.fromARGB(255, 51, 97, 178) ),),
                    Text(books[index].author,style: TextStyle(fontWeight: FontWeight.bold),),
],),
  shape: RoundedRectangleBorder(
 borderRadius: BorderRadius.circular(10.0),),
  // ),
  elevation: 5,
  margin: EdgeInsets.all(50),
);


                    },
                  );
                } else {
                  return Center(child: Text('No books available.'));
                }
              },
            ),
          ),
        ],
      ),
       bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Colors.white, // Custom background color
        selectedItemColor: Colors.blue, // Custom selected item color
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
        backgroundColor: Color.fromRGBO(130, 205, 239, 1),
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
                  'This app offers a variety of services to help users manage their plant collection. '
                  'From purchasing plants to tracking your plant care, we provide tools to ensure '
                  'your plants thrive. Here are some of the features we offer:',
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
                  '1. Plant Shopping\n'
                  '2. Care Tips and Reminders\n'
                  '3. Plant Growth Tracking\n'
                  '4. Community Sharing and Advice\n',
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