import 'package:firebase_auth/firebase_auth.dart';
import 'package:fuelapp/locator.dart';
import 'package:fuelapp/models/voucher.dart';
import 'package:fuelapp/constants/route_names.dart';
import 'package:fuelapp/services/dialog_services.dart';
import 'package:fuelapp/services/firestore_services.dart';
import 'package:fuelapp/services/authentication_services.dart';
import 'package:fuelapp/services/navigation_service.dart';
import 'package:fuelapp/viewmodels/base_view_model.dart';
import 'package:flutter/foundation.dart';

import 'package:otp/otp.dart';

class CreateFuelViewModel extends BaseModel {
  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  final FirestoreService _firestoreService =
    locator<FirestoreService>();
  
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = 
    locator<NavigationService>();

  dynamic now = new DateTime.now();
  get otpcode => _otpcode();

 int _otpcode(){
   final code = OTP.generateTOTPCode(
                "JBSWY3DPEHPK3PXP", DateTime.now().millisecondsSinceEpoch);
   return code;
 }

  Future addFuel({@required int amount}) async {
    setBusy(true);

    var result;

    result = await _firestoreService.addFuel(
      Fuel(userId: currentUser.id,
          amount: amount,
          otp: otpcode,
          timeStamp: now)
    );

    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
         title: 'Could not generate otp',
         description: result,
      );
    }else {
      await _dialogService.showDialog(
        title: 'Successfully',
        description: 'Your otp has been generated',
      );
    }
    _navigationService.pop();

    _navigationService.navigateTo(GeneratedViewRoute);
  }

  Future logOut() async {
    await _authenticationService.logOutUser();
    _navigationService.pop();
    return _navigationService.navigateFrom(HomeViewRoute);
  }
}