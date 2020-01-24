import '../services/crud.dart';


import 'package:flutter/material.dart';

import 'package:otp/otp.dart';


class OtpGeneratePage extends StatefulWidget {
  @override
  _OtpGeneratePage createState() => _OtpGeneratePage();
}

class _OtpGeneratePage extends State<OtpGeneratePage>{
 
 TextEditingController amtController;
  @override
  void initState() {
      amtController = new TextEditingController();
      super.initState();
    }

 final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

 CrudMethods crudObj = new CrudMethods();

 String amtValidator(String value){
   Pattern pattern = r"^[0-9]*$";
   if(value.length < 0 || !RegExp(pattern).hasMatch(value)){
     return 'please enter an amount';
   }else{
     return null;
   }
 }

 Widget _buildAmountTextField(){
   return TextFormField(
       decoration: InputDecoration(
         labelText: '₦ amount', 
       ),
       keyboardType: TextInputType.number ,
       validator: amtValidator,
       controller: amtController,

  

   );
 }

 int _otpcode(){
   final code = OTP.generateTOTPCode(
                "JBSWY3DPEHPK3PXP", DateTime.now().millisecondsSinceEpoch);
   return code;
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy fuel'),
      ),
      body:Form(
        key: _formkey,
      child: Center(child: Container(
        width: 150.0,
        child: Column(
        children:<Widget>[
         SizedBox(height: 150.0,),

        _buildAmountTextField(),

        SizedBox(
          height: 5.0,),

        RaisedButton(
          child: Text('Generate code'),
          onPressed: () {
             
             Map<String, dynamic> fuel = {
               'amt': amtController.text,
               'otp':  _otpcode(),
             };
             crudObj.addData(fuel).then((result) {
                Navigator.pushNamed(context, '/gened');
             }).catchError((e) {
               print(e);
             });
          },
        ),
        ],

      ),
      ),
      ),)
    
    );
  }
}
