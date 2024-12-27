import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  String name = '';
  String email = '';
  String password = '';

  Future<void> signUp() async {
    final url = Uri.parse('http://10.0.2.2:3001/signup'); // Replace with your backend URL
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'email': email, 'password': password}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      print('Sign-Up Successful: ${data['message']}');
      // Navigate to the next screen or show success message
    } else {
      final error = jsonDecode(response.body);
      print('Sign-Up Failed: ${error['error']}');
      // Show error message
    }
  }

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
                  image: NetworkImage(
                      'https://i.pinimg.com/736x/82/82/43/8282435ab9387e8b946d23f62eeeeeea.jpg'),
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
            // Sign-Up UI
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
                      'SIGN UP',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        letterSpacing: 5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 40),
                    // Name Field
                    Text(
                      'Name',
                      style: TextStyle(
                          color: Colors.lightGreen,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your name',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Email Field
                    Text(
                      'Email',
                      style: TextStyle(
                          color: Colors.lightGreen,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Password Field
                    Text(
                      'Password',
                      style: TextStyle(
                          color: Colors.lightGreen,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
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
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 40),
                    // Sign-Up Button
                    ElevatedButton(
                      onPressed: () {
                        signUp();
                      },
                      child: Text('Sign Up'),
                    ),
                    SizedBox(height: 40),
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



// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:frontend/screens/book_list_screen.dart';


// class signupScreen extends StatefulWidget {
//   @override
//   _signupScreenState createState() => _signupScreenState();
// }

// class _signupScreenState extends State<signupScreen> {
//   String email = '';
//   String password = '';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Stack(
//           children: [
//             // Background Image
//             Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image:NetworkImage('https://i.pinimg.com/736x/82/82/43/8282435ab9387e8b946d23f62eeeeeea.jpg'), // Replace with your image
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: BackdropFilter(
//                 filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//                 child: Container(
//                  color: Colors.black.withOpacity(0.3),
//                 ),
//               ),
//             ),
//             // Login UI
//             Center(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Spacer(),
//                     // Title
//                     Text(
//                       'SIGN UP',
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 38,
//                         letterSpacing: 5,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 60),
//                     // Username Field
//                     Text(
//                       'email',
//                       style: TextStyle(
//                         color: Colors.lightGreen,
//                         fontSize: 30,fontWeight: FontWeight.bold
//                       ),
//                     ),
//                     Divider(color: Colors.white, thickness: 1),
//                     TextField(
//                       onChanged: (value) {
//                         setState(() {
//                           email = value;
//                         });
//                       },
//                       style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                       ),
//                     ),
//                     SizedBox(height: 30),
//                     // Password Field
//                     Text(
//                       'password',
//                       style: TextStyle(
//                        color: Colors.lightGreen,
//                         fontSize: 30,fontWeight: FontWeight.bold
//                       ),
//                     ),
//                     Divider(color: Colors.white, thickness: 1),
//                     TextField(
//                       obscureText: true,
//                       onChanged: (value) {
//                         setState(() {
//                           password = value;
//                         });
//                       },
//                       style: TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                       ),
//                     ),
//                     SizedBox(height: 40),
//                     // Login Button
//                     Align(
//                       child: GestureDetector(
//                         onTap: () {
//                         // Handle login action here
//                          Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => BookListScreen()), // Your next screen
//     );
//                           print('Email: $email, Password: $password');
//                         },
//                         child: CircleAvatar(
//                           radius: 30,
//                           backgroundColor: Colors.lightBlue,
//                           child: Icon(Icons.arrow_forward, color: Colors.white),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 40),
//                     Spacer(),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }