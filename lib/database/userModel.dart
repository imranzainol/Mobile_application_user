import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String email;
  String fullName;
  String groupId;


  UserModel({
    this.uid,
    this.email,
    this.fullName,
    this.groupId,
  });

  UserModel.fromDocumentSnapshot({DocumentSnapshot doc}) {
    uid = doc.id;
    email = doc.data()['email'];
    fullName = doc.data()['fullName'];
    groupId = doc.data()['groupId'];
  }
}
