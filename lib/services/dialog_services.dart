import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:fuelapp/models/dialog_models.dart';

class DialogService{
  GlobalKey<NavigatorState> _dialogNavigationKey = 
  GlobalKey<NavigatorState>();

  Function(DialogRequest) _showDialogListener;
  Completer<DialogResponse> _dialogCompleter;

  GlobalKey<NavigatorState> get dailogNavigationKey => _dialogNavigationKey;

///Register a callback function. Mainly to show the dialog
  void registerDialogListener(Function(DialogRequest) showDialogListener){
    _showDialogListener = showDialogListener;
  } 

/// Calls the dialog listener and returns a Future that will wait for dialogComplete
  Future<DialogResponse> showDialog({
    String title,
    String description,
    String buttonTitle = 'Ok',
  }) {
    _dialogCompleter = Completer<DialogResponse>();
    _showDialogListener(DialogRequest(
      title: title, 
      description: description, 
      buttonTitle: buttonTitle, 
      ));
      return _dialogCompleter.future;
  }

/// Shows a confirmation dailog
  Future<DialogResponse> showConfirmtionDialog( 
    {String titile,
     String description,
     String confirmationTitle = 'Ok',
     String cancelTitle = 'Cancel',}){
       _dialogCompleter = Completer<DialogResponse>();
       _showDialogListener(DialogRequest(
         title: titile,
         description: description,
         buttonTitle: confirmationTitle,
         cancelTitle: cancelTitle,
       ));
       return _dialogCompleter.future;
     }

/// Competes the _dialogCompleter to resume the Future's execution call
  void dialogComplete(DialogResponse response) {
    _dialogNavigationKey.currentState.pop();
    _dialogCompleter.complete(response);
    _dialogCompleter = null;
  }
}