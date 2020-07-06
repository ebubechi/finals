import 'package:fuelapp/constants/route_names.dart';
import 'package:fuelapp/locator.dart';
import 'package:fuelapp/services/navigation_service.dart';


import 'base_view_model.dart';

class HomeViewModel extends BaseModel{
  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateTO() async{
   await _navigationService.navigateTo(LoginViewRoute);
  }
}