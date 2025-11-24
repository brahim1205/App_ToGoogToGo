import 'package:flutter/material.dart';
import 'package:dailycatch/screens/home_screen.dart';
import 'package:dailycatch/screens/login_screen.dart';
import 'package:dailycatch/screens/register_screen.dart';
import 'package:dailycatch/screens/browse_screen.dart';
import 'package:dailycatch/screens/delivery_screen.dart';
import 'package:dailycatch/screens/favourites_screen.dart';
import 'package:dailycatch/screens/profile_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dailycatch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomeScreen(),
        '/browse': (context) => BrowseScreen(),
        '/delivery': (context) => DeliveryScreen(),
        '/favourites': (context) => FavouritesScreen(),
        '/profile': (context) => ProfileScreen(),
      },
    );
  }
}
