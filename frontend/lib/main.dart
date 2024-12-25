import 'package:flutter/material.dart';
import 'package:frontend/Splash.dart';
import 'screens/book_list_screen.dart';
import 'package:flutter/material.dart';
import '../models/book.dart';
import '../services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
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
          if(Constraints.maxWidth>1200)
          {
            return BookListScreen();
          }

          else if(Constraints.maxWidth<=1200 && Constraints.maxWidth>=800)
          {
            return BookListScreen();
          }
          else
          {
            return BookListScreen();
          }

        
        },
    ),
    );
  }
}

