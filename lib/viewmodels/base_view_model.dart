import 'package:flutter/cupertino.dart';
import 'package:fuelapp/locator.dart';
import 'package:fuelapp/models/user.dart';
import 'package:fuelapp/services/authentication_services.dart';
import 'package:flutter/widgets.dart';

class BaseModel extends ChangeNotifier {
  final AuthenticationService _authenticationService =
    locator<AuthenticationService>();

  User get currentUser => _authenticationService.currentUser;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}