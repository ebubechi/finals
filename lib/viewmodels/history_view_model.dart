import 'package:fuelapp/constants/route_names.dart';
import 'package:fuelapp/locator.dart';
import 'package:fuelapp/models/voucher.dart';
//import 'package:fuelapp/services/dialog_services.dart';
import 'package:fuelapp/services/firestore_services.dart';
import 'package:fuelapp/services/navigation_service.dart';
import 'package:fuelapp/viewmodels/base_view_model.dart';

class HistoryViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
// final DialogService _dialogService = locator<DialogService>();

  List<Fuel> _fuels;
  List<Fuel> get fuels => _fuels;


 void getToFuels() {
   setBusy(true);

    _firestoreService.getFuelsOnceOff().listen((fuelsData) {
      List<Fuel> updatedfuels = fuelsData;
      if (updatedfuels != null && updatedfuels.length > 0) {
        _fuels = updatedfuels;
        notifyListeners();
      }

      setBusy(false);
    });

   setBusy(false);
 }

  void listenToFuels() {
    setBusy(true);

    _firestoreService.listenToFuelsRealTime().listen((fuelsData) {
      List<Fuel> updatedfuels = fuelsData;
      if (updatedfuels != null && updatedfuels.length > 0) {
        _fuels = updatedfuels;
        notifyListeners();
      }

      setBusy(false);
    });
  }

  // Future deletefuel(int index) async {
  //   var dialogResponse = await _dialogService.showConfirmationDialog(
  //     title: 'Are you sure?',
  //     description: 'Do you really want to delete the fuel?',
  //     confirmationTitle: 'Yes',
  //     cancelTitle: 'No',
  //   );

  //   if (dialogResponse.confirmed) {
  //     setBusy(true);
  //     await _firestoreService.deletefuel(_fuels[index].documentId);
  //     setBusy(false);
  //   }
  // }

  Future navigateToGenerateView() async {
    await _navigationService.navigateTo(GenerateViewRoute);
  }

  // void editfuel(int index) {
  //   _navigationService.navigateTo(CreatefuelViewRoute,
  //       arguments: _fuels[index]);
  // }
}
