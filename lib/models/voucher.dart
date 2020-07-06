// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/cupertino.dart';

// class Fuel{
//   final amount;
//   final otp;
//   final DocumentReference reference;

//   // Fuel (this.amount, this.otp, {this.reference});

//   Fuel.fromMap(Map<String, dynamic> map, {this.reference})
//   :assert(map['amt'] != null),
//   // assert(map['otp'] != null),
//   amount = map['amt'],
//   otp = map['otp'];

//   Fuel.fromSnapshot(DocumentSnapshot snapshot)
//   :this.fromMap(snapshot.data, reference: snapshot.reference);



// }
// import 'package:fuelapp/viewmodels/history_view_model.dart';
import 'package:flutter/foundation.dart';

class Fuel {
  final int amount;
  final int otp;
  final dynamic timeStamp;
  final String userId;
  final String documentId;

  Fuel({
    @required this.userId,
    @required this.amount,
    @required this.timeStamp,
    @required this.otp,
    this.documentId
  });


  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'amount': amount,
      'timestamp': timeStamp,
      'otp': otp,
    };
  }

  static Fuel fromMap(Map<String, dynamic>map, String documentId){
    if (map == null) return null;

    return Fuel (  
      amount: map['amount'],
      otp: map['otp'],
      userId: map['userId'],
      timeStamp: map['timeStamp'],
      documentId: map['documentId']
    );
  }
}