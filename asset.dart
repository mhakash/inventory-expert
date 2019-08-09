import 'package:cloud_firestore/cloud_firestore.dart';
class Asset{

  final String name;
  final String make;
  final String type;
  final String year;
  final double capacity;
  final int quantity;
  final int totalPrice;
  final String remark;
  final DocumentReference reference; 

  //final Documentreference reference;
  Asset.fromMap(Map<String,dynamic> map, {this.reference})
   :name = map['name'],
    make = map['make'],
    type = map['type'],
    year = map['year'],
    capacity = map['capacity'],
    quantity = map['quantity'],
    totalPrice = map['totalPrice'],
    remark = map['remark'];
    
  Asset.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);
  
  @override
  String toString() {
    return '{name: $name, make: $make, type: $type, year: $year, capacity: $capacity, quantity: $quantity, totalprice: $totalPrice, remark: $remark}';
  }
}

final dummySnapshot = [
  {"name": "Filip", "make": "Germany","type": "sometype", "capacity": 2.5, "quantity": 5,"totalPrice": 30000000,"remark":"ok","year":"2010" },
  {"name": "ablu", "make": "Germab","type": "sometype", "capacity": 2.5, "quantity": 5,"totalPrice": 300000,"remark":"ok","year":"2010" },
  {"name": "kabul", "make": "Germany","type": "sometype", "capacity": 2.5, "quantity": 100,"totalPrice": 3000000,"remark":"ok" ,"year":"2010"},
  {"name": "sabul", "make": "India","type": "sometype", "capacity": 2.0, "quantity": 5,"totalPrice": 300000,"remark":"nice remark","year":"2001" },  
  {"name": "sabul", "make": "India","type": "sometype", "capacity": 2.0, "quantity": 5,"totalPrice": 300000,"remark":"nice remark","year":"2001" },
  {"name": "sabul", "make": "India","type": "sometype", "capacity": 2.0, "quantity": 5,"totalPrice": 300000,"remark":"nice remark","year":"2001" },
  {"name": "sabul", "make": "India","type": "sometype", "capacity": 2.0, "quantity": 5,"totalPrice": 300000,"remark":"nice remark","year":"2001" },
  {"name": "sabul", "make": "India","type": "sometype", "capacity": 2.0, "quantity": 5,"totalPrice": 300000,"remark":"nice remark","year":"2001" },
  {"name": "sabul", "make": "India","type": "sometype", "capacity": 2.0, "quantity": 5,"totalPrice": 300000,"remark":"nice remark","year":"2001" },
  {"name": "sabul", "make": "India","type": "sometype", "capacity": 2.0, "quantity": 5,"totalPrice": 300000,"remark":"nice remark","year":"2001" },
  {"name": "sabul", "make": "India","type": "sometype", "capacity": 2.0, "quantity": 5,"totalPrice": 300000,"remark":"nice remark","year":"2001" },
  {"name": "sabul", "make": "India","type": "sometype", "capacity": 2.0, "quantity": 5,"totalPrice": 300000,"remark":"nice remark","year":"2001" },
  {"name": "sabul", "make": "India","type": "sometype", "capacity": 2.0, "quantity": 5,"totalPrice": 300000,"remark":"nice remark","year":"2001" },
  {"name": "sabul", "make": "India","type": "sometype", "capacity": 2.0, "quantity": 5,"totalPrice": 300000,"remark":"nice remark","year":"2001" },
  {"name": "sabul", "make": "India","type": "sometype", "capacity": 2.0, "quantity": 5,"totalPrice": 300000,"remark":"nice remark","year":"2001" },

];