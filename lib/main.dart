import 'package:flutter/material.dart';
import 'locator.dart';
import 'ui/router.dart';
import 'package:fuelapp/managers/dialog_manager.dart';
import 'package:fuelapp/services/dialog_services.dart';
import 'package:fuelapp/services/navigation_service.dart';
import 'package:fuelapp/ui/views/startup_view.dart';
import 'package:flutter/services.dart';


// void main(){
//   //Register all the models and services before the app starts
//   setupLocator();

//   runApp(MyApp());
// } 


void main() async => {
      WidgetsFlutterBinding.ensureInitialized(),
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp]),
      
      setupLocator(),
      runApp(MyApp())
    };




class MyApp extends StatefulWidget {
  @override
    _MyAppState createState() => _MyAppState();
  }


class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context){
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     title: 'FillUp',
     builder: (context, child) => Navigator(
       key: locator<DialogService>().dailogNavigationKey,
       onGenerateRoute: (settings) => MaterialPageRoute(
         builder: (context) => DialogManager(child: child,),
       )),
     navigatorKey: locator<NavigationService>().navigationKey,
     theme: ThemeData(
       brightness: Brightness.light,
       primarySwatch: Colors.blue,
       accentColor: Colors.white,
       textTheme: Theme.of(context).textTheme.apply(
         fontFamily: 'Open Sans',
       )
      //  buttonColor: Colors.white,
     ),
     home: StartUpView(),
     onGenerateRoute: generateRoute,
    );
  }
}