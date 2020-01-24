import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/crud.dart';

class GeneratedPage extends StatefulWidget{
     _GeneratedPage createState() => _GeneratedPage();
}

class _GeneratedPage extends State<GeneratedPage>{

  CrudMethods crudObj = CrudMethods();
  
  var otp;

  @override
  void initState(){
    crudObj.getData();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Generated')
        ),

        body: Container(
          width: 150.0,
          child: Center(
              child: Text( otp['otp'] ),
          ),
        ),      

    );
  }
}