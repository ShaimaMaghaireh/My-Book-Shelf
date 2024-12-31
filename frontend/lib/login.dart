import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/screens/book_list_screen.dart';
import 'RegisterChoice.dart';
import 'package:http/http.dart' as http;
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image:NetworkImage('https://i.pinimg.com/736x/82/82/43/8282435ab9387e8b946d23f62eeeeeea.jpg'), // Replace with your image
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                 color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
            // Login UI
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Spacer(),
                    // Title
                    Text(
                      'LOGIN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        letterSpacing: 5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 60),
                    // Username Field
                    Text(
                      'EMAIL',
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 30,fontWeight: FontWeight.bold
                      ),
                    ),
                    Divider(color: Colors.white, thickness: 1),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(height: 30),
                    // Password Field
                    Text(
                      'PASSWORD',
                      style: TextStyle(
                       color: Colors.lightBlue,
                        fontSize: 30,fontWeight: FontWeight.bold
                      ),
                    ),
                    Divider(color: Colors.white, thickness: 1),
                    TextField(
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(height: 40),
                    // Login Button
                    Align(
                      child: GestureDetector(
                        onTap: () async{
                        // Handle login action here
                       // Replace with your backend URL
       const String url = 'http://192.168.243.213:3001/login';

  // Create request body
  final body = jsonEncode({
    'email': email,
    'password': password,
  });

  try {
   final url = Uri.parse('http://192.168.243.213:3001/login');
final response = await http.post(
  url,
  headers: {'Content-Type': 'application/json'},
  body: jsonEncode({'email': email, 'password': password}),
);

if (response.statusCode == 200) {
  final responseData = jsonDecode(response.body);
  print('Login successful: ${responseData['name']}');
   Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BookListScreen()),
      );
} else {
 //! print('OBEJCT OBEJCT OBEJCT');
  print('Login failed: ${response.body}');
}
    
  } catch (e) {
    print('Error occurred: $e');
  }
    print('Email: $email, Password: $password');
},
                        child: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.lightBlue,
                          child: Icon(Icons.arrow_forward, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                     IconButton(onPressed: (){
                Navigator.pop(context);
                }, 
                icon: Icon(Icons.arrow_back_ios_new,
                color: Colors.deepPurpleAccent,)),
                    Spacer(),
                    
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