import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


List<String> history = List();
int riskLevel=0;

Future<void> userSetup(String fullName,String email,String phoneNo)async{
  List<String> indexList = [];
  List<String> splitList = fullName.split(',');
  for (int i = 0; i < splitList.length; i++){
    for(int j = 1 ; j < splitList[i].length + i + 1; j++){
      indexList.add(splitList[i].substring(0, j).toLowerCase());
    }
  }

  CollectionReference users =FirebaseFirestore.instance.collection('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String userUid = auth.currentUser.uid.toString();

  users.add({'fullName':fullName,'email':email,'userUid':userUid,'history':history,'riskLevel':riskLevel,'phoneNo':phoneNo,'searchKeywords':indexList});
  return;
}