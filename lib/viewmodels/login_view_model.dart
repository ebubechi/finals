import 'package:flutter/cupertino.dart';
import 'package:fuelapp/constants/route_names.dart';
import 'package:fuelapp/locator.dart';
import 'package:fuelapp/services/authentication_services.dart';
import 'package:fuelapp/services/dialog_services.dart';
import 'package:fuelapp/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_view_model.dart';

class LoginViewModel extends BaseModel{
  final AuthenticationService _authenticationService =
    locator<AuthenticationService>();

  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future login({
    @required String email,
    @required String password,
  }) async {
    setBusy(true);

    var result = await _authenticationService.loginWithEmail(
      email: email,
      password: password);

    setBusy(false);

    if(result is bool){
      if (result) {
        _navigationService.navigateFrom(GenerateViewRoute);
      }else {
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: 'General login failure. Please try again'
        );
      } 
    }else {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: result,
      );
    }
  }

  void navigateToSignUp() {
    _navigationService.navigateTo(SignUpViewRoute);
  }
}