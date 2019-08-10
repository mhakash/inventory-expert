import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SignUpPageState();
  }
}

class SignUpPageState extends State<SignUpPage>{

  final formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              emailField(),
              passwordField(),
              signUpButton(),
              loginButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailField(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'email',
      ),
      validator: (value) => value.isEmpty ? 'ERROR' : null,
      onSaved: (value) => _email = value,
    );
  }

  Widget passwordField(){
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
      ),
      obscureText: true,
      validator: (value) => value.isEmpty ? 'ERROR' : null,
      onSaved: (value) => _password = value,
    );
  }

  Widget loginButton(){
    return RaisedButton(
      
      child: Text('Login'),
      onPressed: moveToLogin,
    );
  }

  Widget signUpButton(){
    return RaisedButton(
      child: Text('SignUp'),
      onPressed: validateAndSubmit,
    );
  }

  
  bool validateAndSave(){
    final form = formKey.currentState;
    if(form.validate()){
      form.save();
      return true;
    }
    else return false;
  }

  void validateAndSubmit() async{
    if(validateAndSave()){
      try{
        final FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        print(user.uid);
        Navigator.of(context).pushNamed('/login',arguments: 'signUp');
      }
      catch(e){
        print('Error $e');
      }
    }
  }

  void moveToLogin(){
    Navigator.of(context).pushNamed('/login', arguments: 'signup');
  }
}