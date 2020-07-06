import 'package:fuelapp/viewmodels/home_view_model.dart';
import 'package:fuelapp/constants/route_names.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<HomeViewModel>.withConsumer(
        viewModel: HomeViewModel(),
        builder: (context, model, child) => Scaffold(
            backgroundColor: Color(0xFF1565C0),
            body: Scaffold(
                body: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 6.0, vertical: 0.0),
              child: Stack(children: [
                ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      width: double.infinity,
                      height: 460,
                      color: Color(0xFF3383CD),
                    )),
                ClipPath(
                    clipper: MyClipperTwo(),
                    child: Container(
                      width: double.infinity,
                      height: 460,
                      color: Color(0xFF0D47A1),
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 100),
                      Text(
                        'Welcome!',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Nice to have you!',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 90),
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          color: Colors.amber,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            model.navigateTO();
                          }),
                      SizedBox(height: 298.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 45.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(fontSize: 15.0),
                            ),
                            FlatButton(
                              padding: EdgeInsets.all(0.0),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0D47A1)),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(context,SignUpViewRoute);
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ]),
            ))));
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height - 100);
    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MyClipperTwo extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 40);
    path.lineTo(size.width, size.height - 140);
    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, 0.0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
