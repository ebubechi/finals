import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuelapp/pages/generate.dart';
import 'package:fuelapp/pages/login.dart';


class SignUpPage extends StatefulWidget{
  SignUpPage({Key key}): super(key: key);


  @override
  _SignUpPageState createState() => _SignUpPageState();

}

class _SignUpPageState extends State<SignUpPage>{

  final  GlobalKey<FormState> _signupFormKey = GlobalKey<FormState>();
  TextEditingController firstNameInputController;
  TextEditingController lastNameInputController;
  TextEditingController emailInputController;
  TextEditingController pwdInputController;
  TextEditingController confirmpwdInputController;



  @override
  void initState() {
    firstNameInputController = new TextEditingController();
    lastNameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmpwdInputController = new TextEditingController();

    super.initState();
  }

   String emailValidator(String value){
     Pattern pattern = 
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

        RegExp regex = new RegExp(pattern);
        if(!regex.hasMatch(value)){
          return "Email format is invalid";
        }else {
          return null;
        }
   }

  String pwdValidator(String value){
    if (value.length < 8){
      return "Password must be lager than 8 characters";
    }else{
      return null;

    }
  }


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('SignUp')
      ),
      
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _signupFormKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'First Name*',
                  
                  ),

                  controller: firstNameInputController,
                  validator: (value){
                    if(value.length < 3 ){
                      return 'Please enter a valid first name.';
                    }
                  },
                ),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Last Name*',
                  ),
                  controller: lastNameInputController,
                  validator: (value){
                    if(value.length < 3){
                      return 'Please enter a valid last neme.';
                    }
                  },
                ),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email*', hintText: 'example.dd@gmail.com'
                  ),
                  controller: emailInputController,
                  keyboardType: TextInputType.emailAddress,
                  validator: emailValidator,
                ),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Password'
                  ),
                  controller: pwdInputController,
                  obscureText: true,
                  validator: pwdValidator,
                ),

                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Confirm password'
                  ),
                  controller: confirmpwdInputController,
                  obscureText: true,
                  validator: pwdValidator,
                ),


                SizedBox(
                  height: 5.0,
                ),

          Container(
                      height: 40.0,
                      width: 300.0,
                      child: Material(
                        borderRadius: BorderRadius.circular(20.0),
                        shadowColor: Colors.greenAccent,
                        color: Colors.green,
                        elevation: 10.0,
                        child: GestureDetector(
                          onTap: () {
                            if(_signupFormKey.currentState.validate()){
                              if(pwdInputController.text == confirmpwdInputController.text){
                                FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                  email: emailInputController.text,
                                  password: pwdInputController.text,
                                )
                                .then((currentUser) => Firestore.instance
                                .collection("users")
                                .document(currentUser.user.uid)
                                .setData({
                                  "uid": currentUser.user.uid,
                                  "fname": firstNameInputController.text,
                                  "lname": lastNameInputController.text,
                                  "email": emailInputController.text,
                                })
                                .then((result) => {
                                  Navigator.pushAndRemoveUntil(
                                    context, 
                                    MaterialPageRoute(
                                      builder: (context) => OtpGeneratePage( )),
                                      (_) => false ),
                                        firstNameInputController.clear(),
                                        lastNameInputController.clear(),
                                        emailInputController.clear(),
                                        pwdInputController.clear(),
                                        confirmpwdInputController.clear(),                                              
                                })
                                .catchError((err) => print(err))
                                )
                                .catchError((err) => print(err));
                              }else{
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      title: Text('Error'),
                                      content: Text('the passwords do not match'),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Close'),
                                          onPressed: (){
                                            Navigator.of(context).pop();
                                          },
                                        )
                                      ],
                                    );
                                  }
                                );
                              }
                            }

                               },
                                  child: Center(
                                    child: Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                SizedBox(
                  height: 5.0,
                ),

                Text('Already have an account?'),

                SizedBox(
                  height: 5.0,
                ),

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
                                    LoginPage()));
                          },
                          child: Center(
                            child: Text('Login here!',
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
            ),),
        )
      ),
      );
  }


  } 