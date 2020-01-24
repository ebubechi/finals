import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CrudMethods{
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    }else{
      return false;
    }
  }

 Future<void> addData(fuel) async {
   if(isLoggedIn()){
     Firestore.instance.collection('fuelcrud').add(fuel).catchError((e){
       print(e);
     });
   }
 }

  getData() async {
   return  await Firestore.instance.collection('fuelcrud').orderBy('otp', descending: true).limit(1).getDocuments();
 }

}