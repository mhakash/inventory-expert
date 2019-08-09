import 'package:flutter/material.dart';
import 'asset.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(title: 'Assets'),
      //home: RootPage(),
    );
  }
}

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body : Container(
        color: Color.fromARGB(100, 255, 0, 0),
        child: Text('Inventory Expert'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final userId = '4NcIRQLw7UrorDoxDbAt';
  String _name, _make, _type, _year, _remark;
  double _capacity;
  int _quantity, _totalPrice;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()async{
          //print(asset.toString());
          await showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                content: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      child: Column(
                      //padding: EdgeInsets.symmetric(horizontal: 16),
                      children: <Widget>[
                        Text('Edit the following fields'),
                        nameField(false, null),
                        makeField(false, null),
                        typeField(false, null),
                        yearField(false, null),
                        capacityField(false, null),
                        quantityField(false, null),
                        totalPriceField(false, null),
                        remarkField(false, null),
                        
                      ],
                    ),
                      ),
                  ),
                ),
                actions: <Widget>[  
                  FlatButton(
                    child: Text('add'),
                    //onPressed: (){},
                    onPressed: (){
                      final form = _formKey.currentState;
                      if(form.validate()){
                        form.save();
                        print('done adding');

                        Firestore.instance.collection('users').document(userId).collection('assets')
                        .add({"name":_name,"make":_make,"type":_type, "capacity":_capacity, "quantity":_quantity,"totalPrice":_totalPrice,"remark":_remark,"year":_year})
                        .then((result){
                          Navigator.of(context).pop();
                        })
                        .catchError((err)=>print("error occured look:"+err));
                      }
                      print('name: $_name, make: $_make');
                      //Todo
                    },
                  ),
                  
                  FlatButton(
                    child: Text('cancel'),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }

          );
        },
      ),
          //JsonTable(dummySnapshot)  
    );
  }

  Widget _buildBody(){
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('users').document(userId).collection('assets').snapshots(),
      //stream: Firestore.instance.collection('test').snapshots(),
      builder: (context, snapshot) {
        //if(!snapshot.hasData) return LinearProgressIndicator();
        List<DocumentSnapshot> documetReferences = snapshot.data.documents;
        return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                horizontalMargin: 20,
                columnSpacing: 0,
                columns: [
                  _customDataColum('name'),
                  _customDataColum('make'),
                  _customDataColum('type'),
                  _customDataColum('year'),
                  _customDataColum('capacity'),
                  _customDataColum('quantity'),
                  _customDataColum('totalPrice'),
                  _customDataColum('remark'),
                  _customDataColum(''),
                ],
                rows: documetReferences.map((e){
                  final asset = Asset.fromSnapshot(e); 
                  print(asset);
                  return DataRow(
                    cells: <DataCell>[
                      _customCell(asset.name),
                      _customCell(asset.make),
                      _customCell(asset.type),
                      _customCell(asset.year),
                      _customCell(asset.capacity),
                      _customCell(asset.quantity),
                      _customCell(asset.totalPrice),
                      _customCell(asset.remark),
                      _editButton(asset),
                      ]
                  );
                }).toList() 
              ),
            ),
          );
      }
    );
  }

  DataColumn _customDataColum(dynamic data){
    return DataColumn(
      label:Container(
        padding: EdgeInsets.all(3),
        /*decoration: BoxDecoration(
          border: Border.all(width: .5),
        ),*/
        child: Center(
          child: Text(data.toString()),
        ),
      ),
    );
  }

  DataCell _customCell(dynamic data){
    return DataCell(
      Container(
        padding: EdgeInsets.all(3),
        decoration: BoxDecoration(
          border: Border.all(width: .5),
        ),
        child: Center(
          child: Text(data.toString()),
        ),
      ),
    );
  }

  DataCell _editButton(Asset asset){
    return DataCell(
      FlatButton(
        padding: EdgeInsets.all(0),
        child: Container(
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            //border: Border.all(width: .5),
          ),
          child: Icon(Icons.edit),
        ),
        onPressed: () async{
          print(asset.toString());
          await showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                content: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        child: Column(
                        //padding: EdgeInsets.symmetric(horizontal: 16),
                        children: <Widget>[
                          Text('Edit the following fields'),
                          nameField(true, asset),
                          makeField(true, asset),
                          typeField(true, asset),
                          yearField(true, asset),
                          capacityField(true, asset),
                          quantityField(true, asset),
                          totalPriceField(true, asset),
                          remarkField(true, asset),
                          
                        ],
                    ),
                      ),
                  ),
                ),
                actions: <Widget>[  
                  FlatButton(
                    child: Text('Edit'),
                    //onPressed: (){},
                    onPressed: (){
                      final form = _formKey.currentState;
                      if(form.validate()){
                        form.save();
                        print('done editing');

                        Firestore.instance.collection('users').document(userId).collection('assets').document(asset.reference.documentID)
                        .updateData({"name":_name,"make":_make,"type":_type, "capacity":_capacity, "quantity":_quantity,"totalPrice":_totalPrice,"remark":_remark,"year":_year})
                        .then((result){
                        Navigator.of(context).pop();
                        })
                        .catchError((err)=>print("error occured look:"+err));
                        }
                      print('name: $_name, make: $_make');
                      //Todo
                    },
                  ),
                  FlatButton(
                    child: Text('Delete'),
                    onPressed: (){
                      //Todo
                    },
                  ),
                  FlatButton(
                    child: Text('cancel'),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  )
                ],
              );
            }

          );
        },
      )
    );
  }

  Widget nameField(bool isEdit, Asset asset){
    return TextFormField(
      keyboardType: TextInputType.text,
      //controller: _nameController,
      initialValue: isEdit?asset.name:'',
      decoration: InputDecoration(
        icon: Icon(Icons.input),
        labelText: "*name",
      ),
      validator: (val)=>val.isEmpty?'name is required':null,
      onSaved: (val)=>_name = val,
    );
  }

  Widget makeField(bool isEdit, Asset asset){
    return TextFormField(
      keyboardType: TextInputType.text,
      //controller: _makeController,
      initialValue: isEdit?asset.make:'',
      decoration: InputDecoration(
        icon: Icon(Icons.input),
        labelText: "make",
      ),
      //validator: (val)=>val.isEmpty?'name is required':null,
      onSaved: (val)=>_make = val,
    );
  }

  Widget typeField(bool isEdit, Asset asset){
    return TextFormField(
      keyboardType: TextInputType.text,
      //controller: _typeController,
      initialValue: isEdit?asset.type:'',
      decoration: InputDecoration(
        icon: Icon(Icons.input),
        labelText: "type",
      ),
      onSaved: (val)=>_type= val,
    );
  }

  Widget yearField(bool isEdit, Asset asset){
    return TextFormField(
      keyboardType: TextInputType.datetime,
      //controller: _yearController,
      initialValue: isEdit?asset.year:'',
      decoration: InputDecoration(
        icon: Icon(Icons.input),
        labelText: "year",
      ),
      onSaved: (val)=>_year = val,
    );
  }

  Widget capacityField(bool isEdit, Asset asset){
    return TextFormField(
      keyboardType: TextInputType.number,
      //controller: _capacityController,
      initialValue: isEdit?asset.capacity.toString():'',
      decoration: InputDecoration(
        icon: Icon(Icons.input),
        labelText: "capacity",
      ),
      onSaved: (val)=>_capacity = double.parse(val),
    );
  }

  Widget quantityField(bool isEdit, Asset asset){
    return TextFormField(
      keyboardType: TextInputType.number,
      //controller: _quantityController,
      initialValue: isEdit?asset.quantity.toString():'',
      decoration: InputDecoration(
        icon: Icon(Icons.input),
        labelText: "quantity",
      ),
      onSaved: (val)=>_quantity = int.parse(val),
    );
  }

  Widget totalPriceField(bool isEdit, Asset asset){
    return TextFormField(
      keyboardType: TextInputType.number,
      //controller: _totalPriceController,
      initialValue: isEdit?asset.totalPrice.toString():'',
      decoration: InputDecoration(
        icon: Icon(Icons.input),
        labelText: "total price",
      ),
      onSaved: (val)=>_totalPrice = int.parse(val),
    );

  }

  Widget remarkField(bool isEdit, Asset asset){
    return TextFormField(
      keyboardType: TextInputType.text,
      //controller: _remarkController,
      initialValue: isEdit?asset.remark:'',
      decoration: InputDecoration(
        icon: Icon(Icons.input),
        labelText: "remark",
      ),
      onSaved: (val)=>_remark = val,
    );
  }
}