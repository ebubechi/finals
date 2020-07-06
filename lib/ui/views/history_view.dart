// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fuelapp/models/voucher.dart';
// import 'package:fuelapp/ui/shared/ui_helpers.dart';
// import 'package:fuelapp/viewmodels/history_view_model.dart';
// import 'package:fuelapp/ui/widgets/voucher_item.dart';
// import 'package:fuelapp/viewmodels/history_view_model.dart';
// import 'package:provider_architecture/provider_architecture.dart';



// class HistoryPage extends StatefulWidget{
//      _HistoryPage createState() => _HistoryPage();
// }

// class _HistoryPage extends State<HistoryPage>{


//   Firestore _db = Firestore.instance;


// @override
// Widget build(BuildContext context){
//   return Scaffold(
//     appBar: AppBar(
//       title:Text('History code'),),
//       body: Container(
//         // decoration: BoxDecoration(color:Colors.red),
//         child: _buildBody(context),
//         )
//       );

// }

// Widget _buildBody(BuildContext context){
//   return StreamBuilder(
//     stream: _db.collection('fuelcrud').orderBy("timestamp", descending:true).snapshots(),
//     builder: (context, snapshot){
//       if(!snapshot.hasData)
//         return LinearProgressIndicator();

//       return _buildList(context, snapshot.data.documents);

//     },);
// }

// Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot){
//   return ListView(
//     padding: const EdgeInsets.only(top: 15.0),
//     children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//   );
// }


// Widget _buildListItem(BuildContext context, DocumentSnapshot data){
//   final fuel = Fuel.fromSnapshot(data);

//   return Padding(
//     key: ValueKey(fuel.amount),
//     padding: const EdgeInsets.symmetric(horizontal:16, vertical: 8.0),
//     child: Container(
//       decoration: BoxDecoration(
//         color: Colors.green,
//         boxShadow: [
//           BoxShadow(
//             color: Colors.green[200],
//             blurRadius: 10.0,
//             spreadRadius: 2.0,
//             offset: Offset(
//               10.0,
//               10.0,
//             )
//           )
//         ],
//         border: Border.all(color: Colors.green),
//         borderRadius: BorderRadius.circular(5.0)
//        ),
//        child: ListTile(
         
//          title: Row(children: <Widget>[
//            Text('Amount'),
//            Expanded(
//              flex: 2,
//              child: Container(width: 30.0)),
//            Text('OTP'),
//            SizedBox(height: 5.0,)]),
//          subtitle: Text(fuel.amount, style: TextStyle(color: Colors.white),),
//          trailing: Text(fuel.otp.toString(), style: TextStyle(color: Colors.white),),
//        ),
//     ),
//     );
// }
// }

// import 'package:fuelapp/models/voucher.dart';
import 'package:fuelapp/constants/route_names.dart';
// import 'package:fuelapp/ui/shared/ui_helpers.dart';
import 'package:fuelapp/ui/widgets/voucher_item.dart';
import 'package:fuelapp/viewmodels/history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HistoryViewModel>.withConsumer(
        viewModel: HistoryViewModel(),
        onModelReady: (model) => model.getToFuels(),
        builder: (context, model, child) => Scaffold(
          backgroundColor: Colors.white,
          // floatingActionButton: FloatingActionButton(
          //   backgroundColor: Colors.amber,
          //   child:
          //       !model.busy ? Icon(Icons.add, color: Color(0xFF11249F),) : CircularProgressIndicator(),
          //   onPressed: model.navigateToGenerateView,
          // ),
          body:Stack(children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 250, 8.0, 25.0),
              child: Container(
                child: model.fuels != null
                    ? ListView.builder(
                      itemCount: model.fuels.length,
                      itemBuilder: (context, index) => 
                       FuelItem(
                          fuel: model.fuels[index],
                        ),
                      )
                      : Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).primaryColor),
                        ),
                      )),
            ),

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
                              icon: const Icon(Icons.arrow_back_ios),
                              onPressed: () {
                                Navigator.pushNamed(context, GenerateViewRoute);
                              },
                              tooltip: MaterialLocalizations.of(context)
                                  .openAppDrawerTooltip,
                            );
                          },
                        ),
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        title: Text(''),
                        // actions: <Widget>[
                        //   IconButton(
                        //     icon: Icon(Icons.android),
                        //     tooltip: 'Android',
                        //     onPressed: () {},
                        //   ),
                        // ],
                      )),
            

              ],
            ),
          ));
        
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