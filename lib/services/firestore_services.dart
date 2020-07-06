import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fuelapp/models/user.dart';
import 'package:fuelapp/models/voucher.dart';
import 'package:flutter/services.dart';


class FirestoreService {
  final CollectionReference _usersCollectionReference =
    Firestore.instance.collection('users');

  final CollectionReference _fuelCollectionReference = 
    Firestore.instance.collection('fuelcrud');

  final StreamController<List<Fuel>> _fuelController =
    StreamController<List<Fuel>>.broadcast();



  Future createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.id)
      .setData(user.toJson());
    }catch(e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference
      .document(uid).get();
      return User.fromData(userData.data);
    }catch(e) {
      if(e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future addFuel(Fuel fuel) async {
    try {
      await _fuelCollectionReference.add(fuel.toMap());
    }catch(e) {
      if(e is PlatformException){
        return e.message;
      }
      return e.toString();
    }
  }
  
  // Future getFuelsOnceOff() async {
  //   try{
  //     var fuelDocumentSnapshot = await _fuelCollectionReference.orderBy('timestamp', descending: true).getDocuments();
  //     if (fuelDocumentSnapshot.documents.isNotEmpty) {
  //       return fuelDocumentSnapshot.documents
  //           .map((snapshot) => Fuel.fromMap(snapshot.data, snapshot.documentID))
  //           .where((mappedItem) => mappedItem.amount != null)
  //           .toList();
  //     }
  //   }catch (e) {
  //     if (e is PlatformException) {
  //       return e.message;
  //     }
  //     return e.toString();
  //   }
  // }

  Stream getFuelsOnceOff() {
    _fuelCollectionReference.orderBy("timestamp", descending:true).snapshots().listen ((fuelSnapshot) {
      if (fuelSnapshot.documents.isNotEmpty) {
        var fuel = fuelSnapshot.documents
            .map((snapshot) => Fuel.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.amount != null)
            .toList();

        _fuelController.add(fuel);
      }

    });
    return _fuelController.stream;
  }


  Stream listenToFuelsRealTime() {
    _fuelCollectionReference.orderBy("timestamp", descending:true).limit(1).snapshots().listen ((fuelSnapshot) {
      if (fuelSnapshot.documents.isNotEmpty) {
        var fuel = fuelSnapshot.documents
            .map((snapshot) => Fuel.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.amount != null)
            .toList();

        _fuelController.add(fuel);
      }

    });
    return _fuelController.stream;
  }

}