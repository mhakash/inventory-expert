import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:inventory_expert/src/home_page.dart';
import 'package:inventory_expert/src/login_page.dart';
import 'package:inventory_expert/src/root_page.dart';
import 'package:inventory_expert/src/signup_page.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch (settings.name){
      case '/': 
        return CupertinoPageRoute(builder: (_) => RootPage());
      case '/login':
        if(args is String){
          return CupertinoPageRoute(builder: (_) => LoginPage());
        }
        return _errorRoute();
      case '/signup':
         if(args is String){
           return CupertinoPageRoute(builder: (_) => SignUpPage());
         }
        return _errorRoute();
      case '/home':
         if(args is String){
           return CupertinoPageRoute(builder: (_) =>HomePage(userId: args,));
         }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic>  _errorRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        body: Center(
          child: Text('Error'),
        ),
      );
    });
  }
}

