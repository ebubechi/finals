import 'package:fuelapp/constants/route_names.dart';
import 'package:fuelapp/locator.dart';
import 'package:fuelapp/services/authentication_services.dart';
import 'package:fuelapp/services/navigation_service.dart';
import 'package:fuelapp/viewmodels/base_view_model.dart';

class StartUpViewModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      _navigationService.navigateTo(GenerateViewRoute);
    } else {
      _navigationService.navigateTo(HomeViewRoute);
    }
  }
}
