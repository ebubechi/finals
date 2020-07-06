import 'package:fuelapp/constants/route_names.dart';
import 'package:fuelapp/locator.dart';
import 'package:fuelapp/services/authentication_services.dart';
import 'package:fuelapp/services/dialog_services.dart';
import 'package:fuelapp/services/navigation_service.dart';
import 'package:flutter/foundation.dart';

import 'base_view_model.dart';

class SignUpViewModel extends BaseModel{
  final AuthenticationService _authenticationService =
    locator<AuthenticationService>();

  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String _selectedRole = 'Select a User Role';
  String get selectedRole => _selectedRole;

  void setSelectedRole(dynamic role) {
    _selectedRole = role;
    notifyListeners();
  }

  Future signUp ({
    @required String email,
    @required String password,
    @required String fullName,
    @required String conPassword
  }) async {
    setBusy(true);
   if (password == conPassword){
    var result = await _authenticationService.signUpWithEmail(
      email: email,
      password: password,
      fullName: fullName,
      role: _selectedRole,
    );

    setBusy(false);

    if (result is bool) {
      if (result) {
        _navigationService.navigateFrom(GenerateViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: result,
      );
    }
  }
  }
}