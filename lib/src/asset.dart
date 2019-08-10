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

