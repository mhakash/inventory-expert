import 'package:flutter/material.dart';

class RootPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              child: Text('Inventory Expert'),
              onPressed: (){
                Navigator.of(context).pushNamed('/login',arguments: 'root');
              },
            ),
            
          ],
        ),
      ),
    );
  }
}