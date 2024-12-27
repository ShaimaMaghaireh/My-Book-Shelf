import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:frontend/login.dart';
import 'package:frontend/signup.dart';

class RegisterChoicePage extends StatefulWidget {
  @override
  _RegisterChoicePageState createState() => _RegisterChoicePageState();
}

class _RegisterChoicePageState extends State<RegisterChoicePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          ),
          // Blurred Overlay
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.3),
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'WELCOME',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 60),
                // Login Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue.withOpacity(0.5),
                    padding: EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                   Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()), // Your next screen
    );
                  },
                  child: Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                
                SizedBox(height: 20),
                // Sign Up Button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue.withOpacity(0.5),
                    padding: EdgeInsets.symmetric(horizontal: 140, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                   Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()), // Your next screen
    );
                  },
                  child: Text(
                    'SIGN UP',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              SizedBox(height: 50),
                IconButton(onPressed: (){
                Navigator.pop(context);
                }, 
                icon: Icon(Icons.arrow_back_ios_new,
                color: Colors.deepPurpleAccent,)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

