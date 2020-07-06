import 'package:get_it/get_it.dart';
import 'package:fuelapp/services/dialog_services.dart';
import 'package:fuelapp/services/navigation_service.dart';
import 'package:fuelapp/services/authentication_services.dart';
import 'package:fuelapp/services/firestore_services.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
}