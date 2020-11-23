import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

List<String> members = List();
Future<void> groupSetup(String groupName)async{
  CollectionReference group =FirebaseFirestore.instance.collection('groups');
  FirebaseAuth auth = FirebaseAuth.instance;
  String groupId = auth.currentUser.uid.toString();
  group.add({'groupName':groupName,'leader':groupId,'members': members,});
  return;
}