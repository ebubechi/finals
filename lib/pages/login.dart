
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:fuel/pages/display.dart';
import '../main.dart';
import 'package:fuelapp/pages/signup.dart';



class LoginPage extends StatefulWidget {
  LoginPage({Key key}): super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  final GlobalKey<FormState> _loginFormkey = GlobalKey<FormState>();
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
 
  @override
  initState(){
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    super.initState();
  }




  

  String emailValidator(String value){
    Pattern pattern = 
         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

      RegExp regex = new RegExp(pattern);
      if(!regex.hasMatch(value)){
        return 'Please enter a valid email';
      }else{
        return null;
      }
  }

  String pwdValidator(String value){
    if(value.length < 8){
      return "Password must be longer than 8 characters";
    }else{
      return null;
    }
  }




  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),        
          labelText: 'E-mail', filled: true, fillColor: Colors.white30),
      controller: emailInputController,
      keyboardType: TextInputType.emailAddress,
      validator: emailValidator,
    );
  }


    Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25.0)),        
          labelText: 'Password', filled: true, fillColor: Colors.white30),
      controller: pwdInputController,
      obscureText: true,
      validator: pwdValidator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(

            padding: EdgeInsets.all(10.0),
            child: Center(
                child: SingleChildScrollView(
              child: Container(
                  // width: targetWidth,
                  child: Form(
                key: _loginFormkey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 50.0),
                    ),
                    _buildEmailTextField(),
                    SizedBox(
                      height: 10.0,
                    ),
                    _buildPasswordTextField(),
                    // _LoginMode == LoginMode.Signup ? _bui
                    SizedBox(
                      height: 30.0,
                    ),
                      Text('Forgot password'
                      ),
                  SizedBox(
                      height: 30.0,
                    ),
                    Container(
                      height: 40.0,
                      width: 300.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0 ),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 7.0,
                        child: GestureDetector(
                          onTap: (){

                            if(_loginFormkey.currentState.validate()){
                              FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                email: emailInputController.text,
                                password: pwdInputController.text,
                              ).then((currentUser) => Firestore.instance
                                .collection("users")
                                .document(currentUser.user.uid)
                                .get()
                                .then((DocumentSnapshot result) =>
                              Navigator.pushReplacementNamed(context, '/Otp')
                                )
                                .catchError((err) => print(err)))
                                .catchError((err) => print(err));
                            }
                           
                          },
                          child: Center(
                            child: Text('LOGIN',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              
                            ),),
                            ),
                        ),
                      ),
                    ),


                    SizedBox(
                      height: 30.0,
                    ),

                    Text("don't have an accout yet? signup now!"),
                    
                    Container(
                      height: 40.0,
                      width: 300.0,
                      child: Material(
                        
                        borderRadius: BorderRadius.circular(20.0 ),
                        shadowColor: Colors.white,
                        
                        color: Colors.white,
                        elevation: 10.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    SignUpPage()));
                          },
                          child: Center(
                            child: Text('SIGNUP',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              
                            ),),
                            ),                          
                        ),
                      ),
                    ),

              SizedBox(
                  height: 5.0,
                ),

                  ],
                ),
              )
            ),
          )
        )
    ));
  }
}
