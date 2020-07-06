import 'package:fuelapp/ui/shared/ui_helpers.dart';
import 'package:fuelapp/ui/widgets/busy_button.dart';
import 'package:fuelapp/ui/widgets/expansion_list.dart';
import 'package:fuelapp/ui/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:fuelapp/constants/route_names.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:fuelapp/viewmodels/signup_view_model.dart';

class SignUpView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final conPasswordController = TextEditingController();  
  final fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<SignUpViewModel>.withConsumer(
      viewModel: SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Color(0xFF1565C0),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: SingleChildScrollView(
              child: Stack(
                children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical:70.0, horizontal: 10.0),
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
                  padding: const EdgeInsets.fromLTRB(20.0, 80.0, 20.0, 0.0),
                  child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Text(
                    //   'Sign Up',
                    //   style: TextStyle(
                    //     fontSize: 30,
                    //   ),
                    // ),
                    // verticalSpaceMedium,
                    InputField(
                      
                      placeholder: 'Full Name',
                      controller: fullNameController,
                    ),
                    verticalSpaceTiny,
                    InputField(
                      textInputType: TextInputType.emailAddress,
                      placeholder: 'Email',
                      controller: emailController,
                    ),
                    verticalSpaceTiny,
                    InputField(
                      placeholder: 'Password',
                      password: true,
                      controller: passwordController,
                      additionalNote: 'Password has to be a minimum of 6 characters.',
                    ),
                    InputField(
                      placeholder: 'Confirm Password',
                      password: true,
                      controller: conPasswordController,
                      additionalNote: 'Password must match with the above.',
                    ),                    
                    // verticalSpaceTiny,
                    ExpansionList<String>(
                        items: ['Buyer', 'Admin'],
                        title: model.selectedRole,
                        onItemSelected: model.setSelectedRole),
                    verticalSpaceMedium,
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      // mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BusyButton(
                          busy: model.busy,
                          onPressed: () {
                            model.signUp(
                                email: emailController.text,
                                password: passwordController.text,
                                conPassword: conPasswordController.text,
                                fullName: fullNameController.text);
                          },
                        ),
                    verticalSpaceExtra,
                    Padding(
                      padding: const EdgeInsets.only(left:45.0),
                      child: Row(
                        children: <Widget>[
                          
                          Text('Already have an account?',
                          style: TextStyle(
                            fontSize: 15.0,                          
                            fontWeight: FontWeight.normal,
                            color: Color(0xFFFFFFFF)
                            ),),
                          FlatButton(
                            padding: EdgeInsets.all(0.0),
                            child: Text('Login',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFFC107)),),
                            onPressed: () {
                              Navigator.pushNamed(context, LoginViewRoute);
                            },
                          )
                        ],
                      ),
                    )                        
                      ],
                    )
                  ],
            ),
                ),
                ]),
          ),
        ),
      ),
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
