import 'package:flutter/material.dart';
import 'package:frontend/RegisterChoice.dart';
import 'package:frontend/screens/book_list_screen.dart'; // Replace with your home screen file
import 'login.dart';
import 'RegisterChoice.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextPage();
  }

  // Navigate to the next page after 10 seconds
  void _navigateToNextPage() async {
    await Future.delayed(Duration(seconds: 10));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RegisterChoicePage()), // Your next screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Image
          Image.network('https://images.pexels.com/photos/1907784/pexels-photo-1907784.jpeg?cs=srgb&dl=pexels-rickyrecap-1907784.jpg&fm=jpg',
          fit: BoxFit.cover,),
          // Blue Overlay
          Container(
            color: Colors.blue.withOpacity(0.6),
          ),
          // App Title and Icon
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.library_books,
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                'Library App',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
