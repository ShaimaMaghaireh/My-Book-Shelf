import 'package:flutter/material.dart';
import 'package:frontend/Splash.dart';
import 'package:frontend/login.dart';
import 'package:frontend/screens/book_Details_Screen.dart';
import 'screens/book_list_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ReadingListProvider(),
      child: MyApp(),
    ),
  );
}
// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
            return BookListScreen();
          }

          else if(Constraints.maxWidth<=1200 && Constraints.maxWidth>=800)//?tablet
          {
            return LoginScreen();
          }
          else //?phone
          {
            return SplashScreen();
          }

        
        },
    ),
    );
  }
}

