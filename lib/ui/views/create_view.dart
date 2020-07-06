


// import 'package:flutter/material.dart';

// import 'package:otp/otp.dart';


// class OtpGeneratePage extends StatefulWidget {
//   @override
//   _OtpGeneratePage createState() => _OtpGeneratePage();
// }

// class _OtpGeneratePage extends State<OtpGeneratePage>{
 
//  TextEditingController amtController;
//   @override
//   void initState() {
//       amtController = new TextEditingController();
//       super.initState();
//     }

//  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

//  CrudMethods crudObj = new CrudMethods();
 


//  dynamic now = new DateTime.now();


//  String amtValidator(String value){
//    Pattern pattern = r"^[0-9]*$";
//    if(value.length < 0 || !RegExp(pattern).hasMatch(value)){
//      return 'please enter an amount';
//    }else{
//      return null;
//    }
//  }

//  Widget _buildAmountTextField(){
//    return TextFormField(
//        decoration: InputDecoration(
//          labelText: '₦ amount', 
//        ),
//        keyboardType: TextInputType.number ,
//        validator: amtValidator,
//        controller: amtController,
//    );
//  }

//  int _otpcode(){
//    final code = OTP.generateTOTPCode(
//                 "JBSWY3DPEHPK3PXP", DateTime.now().millisecondsSinceEpoch);
//    return code;
//  }

  // Widget _drawer(context){
  //   return Drawer(
  //     child: ListView(
  //       children: <Widget>[
  //         DrawerHeader(child: Text(''),
  //         decoration: BoxDecoration(
  //           color: Colors.green)),

  //           ListTile(
  //             title: Text('Profile'),
  //             onTap: (){},
  //           ),

  //           Divider(),

  //           ListTile(
  //             title: Text('History'),
  //             onTap: (){
  //               Navigator.pushNamed(context, '/history');
  //             },
  //           ),

          
  //       ]
  //     )
  //   );
  // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Buy fuel'),
        
//         // automaticallyImplyLeading: false,
//       ),
//       drawer: _drawer(context),
//       body:Form(
//         key: _formkey,
//       child: Center(child: Container(
//         width: 150.0,
//         child: Column(
//         children:<Widget>[
//          SizedBox(height: 150.0,),

//         _buildAmountTextField(),

//         SizedBox(
//           height: 5.0,),

//         RaisedButton(
//           child: Text('Generate code'),
//           onPressed: () {
             
//              Map<String, dynamic> fuel = {
//                'amt': amtController.text,
//                'otp':  _otpcode(),
//                'timestamp': now,
//              };
//              crudObj.addData(fuel).then((result) {
//                 Navigator.pushNamed(context, '/gened');
//              }).catchError((e) {
//                print(e);
//              });
//           },
//         ),
//         ],

//       ),
//       ),
//       ),)
    
//     );
//   }
// }






// import 'package:fuelapp/models/voucher.dart';
// import 'package:fuelapp/ui/shared/ui_helpers.dart';
// import 'package:fuelapp/ui/widgets/input_field.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:fuelapp/models/user.dart';

import 'package:flutter/services.dart';
import 'package:fuelapp/viewmodels/create_voucher_view_model.dart';
import 'package:flutter/material.dart';
import 'package:fuelapp/constants/route_names.dart';
import 'package:provider_architecture/provider_architecture.dart';

class GenerateView extends StatelessWidget {
  final amtController = TextEditingController();
  GenerateView({Key key}) : super(key: key);

   String amtValidator(String value){
   Pattern pattern = r"^[0-9]*$";
   if(value.length < 0 || !RegExp(pattern).hasMatch(value)){
     return 'please enter an amount';
   }else{
     return null;
   }
 }

 Widget _buildAmountTextField(context, model){
   return Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 300.0, 15.0, 10.0),
          child: Column(
            children: <Widget>[
            Card(
              color: Color(0xFFFFFFFF),
              elevation: 8.0,
              child: Column(
                children: <Widget>[
                  Container(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 12.0),
                    child: TextField(
                      controller: amtController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          hintText: "Enter Amount",
                          labelText: ' amount',
                          labelStyle: TextStyle(
                            color: Color(0xFF1565C0),
                          )),
                    ),
                  )),
                  SizedBox(height: 35.0),
                  RaisedButton(
                      color: Color(0xFF1565C0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Pay',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                            )),
                      ),
                      onPressed: () {
                        if (!model.busy) {
                      model.addFuel(amount: int.parse(amtController.text));
                      }
                      Navigator.pushNamed(context, GeneratedViewRoute);  
                      }),
                  SizedBox(
                    height: 8.0,),                  
                  // RaisedButton(
                  //     color: Color(0xFF1565C0),
                  //     child: Padding(
                  //       padding: const EdgeInsets.all(8.0),
                  //       child: Text('Pay',
                  //           style: TextStyle(
                  //             color: Color(0xFFFFFFFF),
                  //           )),
                  //     ),
                  //     onPressed: () {}),
                  // SizedBox(
                  //   height: 8.0,
                  // )
                ],
              ),
            ),
          ]),
          );



   
  //  TextFormField(
  //      decoration: InputDecoration(
  //        labelText: '₦ amount', 
  //      ),
  //      keyboardType: TextInputType.number ,
  //      validator: amtValidator,
  //      controller: amtController,
  //  );
 }

   
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<CreateFuelViewModel>.withConsumer(
      viewModel: CreateFuelViewModel(),
      onModelReady: (model) {
        amtController.text = '';
      },
       builder: (context, model, child) => Scaffold(  
      // appBar: AppBar(
      //   title: Text('Buy fuel'),
        
      //   // automaticallyImplyLeading: false,
      // ),
      drawer: _drawer(context),
      body: SingleChildScrollView(
                child: Stack(children: <Widget>[
                  Column(children: <Widget>[
                    ClipPath(
                      clipper: Myclipper(),
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5.0,
                                spreadRadius: 1.0,
                                offset: Offset(0.0, 5.0),
                                color: Colors.grey,
                              )
                            ],
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(0xFF3383CD),
                                  Color(0xFF11249F)
                                ])),
                      ),
                    ),
                  ]),
                  Positioned(
                      top: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: AppBar(
                        leading: Builder(
                          builder: (BuildContext context) {
                            return IconButton(
                              color: Colors.amber,
                              icon: const Icon(Icons.menu),
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              tooltip: MaterialLocalizations.of(context)
                                  .openAppDrawerTooltip,
                            );
                          },
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        titleSpacing: 70.0,
                        title: Text('  Buy Fuel'),
                        // actions: <Widget>[
                        //   IconButton(
                        //     icon: Icon(Icons.android),
                        //     tooltip: 'Android',
                        //     onPressed: () {},
                        //   ),
                        // ],
                      )),
        _buildAmountTextField(context, model),



        // RaisedButton(
        //   child: Text('Generate code'),
        //   onPressed: () {
        //     if (!model.busy) {
        //      model.addFuel(amount: int.parse(amtController.text));
        //     }
        //     Navigator.pushNamed(context, GeneratedViewRoute);          
        //   },
        // ),
        
      
                ]))));
  }

 Widget _drawer(context){
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(child: Text(''),
          decoration: BoxDecoration(
            gradient: LinearGradient(  
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color(0xFF3383CD),
              Color(0xFF11249F),              
            ]
          ),
            // color: Colors.green
            )),

            ListTile(
              title: Text('Profile'),
              onTap: (){},
            ),

            Divider(color: Color(0xFF11249F),),

            ListTile(
              title: Text('History'),
              onTap: (){
                Navigator.pushNamed(context, HistoryViewRoute);
              },
            ),

            Divider(color: Color(0xFF11249F),),

            ListTile(
              title: Text('Logout'),
              onTap: (){                
                CreateFuelViewModel().logOut();

              },
            ),
          
        ]
      )
    );
  }
}



class Myclipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}