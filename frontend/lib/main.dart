import 'package:flutter/material.dart';
import 'package:frontend/Splash.dart';
import 'package:frontend/login.dart';
import 'screens/book_list_screen.dart';
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/api_service.dart';
import 'RegisterChoice.dart';
import 'Splash.dart';
import 'login.dart';
import 'signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: newpage(),
    );
  }
}



class newpage extends StatefulWidget
{
 @override
 State <newpage> createState() => _newpagestate();
}

class  _newpagestate extends State <newpage>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
    
      body: LayoutBuilder(
        builder:(context,Constraints)
        {
          if(Constraints.maxWidth>1200) //? descktop
          {
            return SplashScreen();
          }

          else if(Constraints.maxWidth<=1200 && Constraints.maxWidth>=800)//?tablet
          {
            return LoginScreen();
          }
          else //?phone
          {
            return BookListScreen();
          }

        
        },
    ),
    );
  }
}

