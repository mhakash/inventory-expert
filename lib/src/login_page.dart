import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



class LoginPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{

  final formKey = GlobalKey<FormState>();
  String _email;
  String _password;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
              loginButton(),
              signUpButton(),
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
      onPressed: validateAndSubmit,
    );
  }

  Widget signUpButton(){
    return RaisedButton(
      child: Text('SignUp'),
      onPressed: moveToSignUp,
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
        FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        print(user.uid);
        Navigator.of(context).pushNamed('/home', arguments: '${user.uid}');
      }
      catch(e){
        print('Error $e');
      }
    }
  }

  void moveToSignUp(){
    Navigator.of(context).pushNamed('/signup', arguments: 'login');
  }

}