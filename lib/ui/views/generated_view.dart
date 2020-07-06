// import 'package:fuelapp/ui/shared/ui_helpers.dart';
import 'package:fuelapp/ui/shared/ui_helpers.dart';
import 'package:fuelapp/ui/widgets/voucher_item.dart';
import 'package:fuelapp/viewmodels/history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class GeneratedView extends StatelessWidget {
  const GeneratedView({Key key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HistoryViewModel>.withConsumer(
        viewModel: HistoryViewModel(),
        onModelReady: (model) => model.listenToFuels(),
        builder: (context, model, child) => Scaffold(
          backgroundColor: Color(0xFFFFFFFF),
          // floatingActionButton: FloatingActionButton(
          //   backgroundColor: Color(0xFF283593),
          //   child:
          //       !model.busy ? Icon(Icons.add, color: Colors.white,) : CircularProgressIndicator(),
          //   onPressed: model.navigateToGenerateView,
          // ),
          body: Stack(children: <Widget>[
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
                                Navigator.pop(context);
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
            )
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