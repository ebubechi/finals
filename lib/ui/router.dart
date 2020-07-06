import 'package:flutter/material.dart';
import 'package:fuelapp/ui/views/history_view.dart';
import 'package:fuelapp/constants/route_names.dart';
import 'package:fuelapp/ui/views/login_view.dart';
import 'package:fuelapp/ui/views/signup_view.dart';
import 'package:fuelapp/ui/views/home_view.dart';
import 'package:fuelapp/ui/views/create_view.dart';
import 'package:fuelapp/ui/views/generated_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );    
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
      );
    case SignUpViewRoute:
      return _getPageRoute( 
        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    case GenerateViewRoute:
      return _getPageRoute( 
        routeName: settings.name,
        viewToShow: GenerateView(),
      );
    case GeneratedViewRoute:
      return _getPageRoute( 
        routeName: settings.name,
        viewToShow: GeneratedView(),
      );
    case HistoryViewRoute:
      return _getPageRoute( 
        routeName: settings.name,
        viewToShow: HistoryView(),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(  
          body: Center( 
            child: Text('No route defined for ${settings.name}')
          ),
        ));
    
  }
}


PageRoute _getPageRoute({String routeName, Widget viewToShow}){
  return MaterialPageRoute(  
    settings: RouteSettings( 
      name: routeName,
    ),
    builder: (_) => viewToShow,
  );
}












