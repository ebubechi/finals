import 'package:fuelapp/models/voucher.dart';
import 'package:flutter/material.dart';


class FuelItem extends StatelessWidget {
  final Fuel fuel;
  const FuelItem({
    Key key,
    this.fuel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
return Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          // gradient: LinearGradient(  
          //   begin: Alignment.bottomLeft,
          //   end: Alignment.topRight,
          //   colors: [
          //     Color(0xFF3383CD),
          //     Color(0xFF11249F),              
          //   ]
          // ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Color(0xFF3383CD),
          //     blurRadius: 10.0,
          //     spreadRadius: 2.0,
          //     offset: Offset(
          //       10.0,
          //       10.0,
          //     )
          //   )
          // ],
          // border: Border.all(color: Color(0xFF3383CD)),
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Center (
          child: Container(
            // color: Colors.green,
            width: 250,
            height: 180.0,
            child: Card(
              
              color: Color(0xFFFF8F00),
              elevation: 15.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                
                SizedBox(height: 50.0),
                Text('Amount: N ${fuel.amount}',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),),

                SizedBox(height: 10.0),

                Text('OTP: ${fuel.otp}',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),),
              ],),
            ),
          )
        ),




        // ListTile(
        //   title: Row(children: <Widget>[
        //     Text('Amount'),
        //     Expanded(
        //       flex: 2,
        //       child: Container(width: 30.0)),
        //     Text('OTP'),
        //     SizedBox(height: 5.0,)]),
        //   subtitle: Text(fuel.amount.toString(), style: TextStyle(color: Colors.white),),
        //   trailing: Text(fuel.otp.toString(), style: TextStyle(color: Colors.white),),
        // ),
      );
  }
}