// import 'package:flutter/material.dart';

// class HomePage extends StatefulWidget{
//   final String data;

//   HomePage({@required this.data,}){
//     print('homepage');
//   }

//   @override
//   State<StatefulWidget> createState() {
//     return HomePageState(data: data);
//   }
// }

// class HomePageState extends State<HomePage>{
//   String data;

//   HomePageState({
//     @required this.data,
//   }) ;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('HomePage'),
//       ),
//       body: Center(
//         child: Text('data of user $data'),
//       ),
//     );
//   }
// }