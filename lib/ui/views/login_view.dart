import 'package:fuelapp/constants/route_names.dart';
import 'package:fuelapp/ui/shared/ui_helpers.dart';
import 'package:fuelapp/ui/widgets/busy_button.dart';
import 'package:fuelapp/ui/widgets/input_field.dart';
import 'package:fuelapp/ui/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:fuelapp/viewmodels/login_view_model.dart';

class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<LoginViewModel>.withConsumer(
      viewModel: LoginViewModel(),
      builder: (context, model, child) => Scaffold(
          backgroundColor: Color(0xFF1565C0),
          body: SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:70.0, horizontal: 15.0),
                  child: ClipPath(
                  clipper: MyClipperThree(),
                  child: Container( 
                    width: double.infinity,
                    height: 460,
                    color: Color(0xFFFFFFFF),
                 )
               ),
              ),                
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: 190,
                      // child: Image.asset('assets/images/title.png'),
                    ),
                    InputField(
                      textInputType: TextInputType.emailAddress,
                      placeholder: 'Email',
                      controller: emailController,
                    ),
                    verticalSpaceSmall,
                    InputField(
                      placeholder: 'Password',
                      password: true,
                      controller: passwordController,
                    ),
                    verticalSpaceMassive,
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BusyButton(
                          busy: model.busy,
                          onPressed: () {
                            model.login(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                          },
                        )
                      ],
                    ),
                    verticalSpaceExtra,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                      Text('Don\'t have an account?'),
                      FlatButton(
                       child: Text('Sign UP',
                      style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFC107)),
                       ),                      
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpViewRoute);
                      },
                    )])
                  ],
                ),
            ),
             ]),
          )),
    );
  }
}


class MyClipperThree extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    var path = Path();


    path.lineTo(0, size.height-105);
    path.quadraticBezierTo(0, size.height-93, 10, size.height-88);

    path.lineTo(size.width-25, size.height-5);
    path.quadraticBezierTo(size.width, size.height, size.width, size.height-22);

    path.lineTo(size.width, 30);
    path.quadraticBezierTo(size.width, 0, size.width-30, 0);

    path.lineTo(30, 0);
    path.quadraticBezierTo(0, 0, 0, 30);


    


    // path.lineTo(0, size.height-15);
    // path.quadraticBezierTo(0, size.height, 22, size.height-10);

    // path.lineTo(size.width-20, size.height-110);
    // path.quadraticBezierTo(size.width, size.height-120, size.width, size.height-140);

    // path.lineTo(size.width, 50);
    // path.quadraticBezierTo(size.width, 0, size.width-50, 0);

    // path.lineTo(50, 0);
    // path.quadraticBezierTo(0, 0, 0, 50);

    

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {

    return false;
  }

}

