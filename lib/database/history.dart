import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ignore: missing_return
  Future<String> userHistory(String userUid, String groupName,String groupId) async {
    List<Map> history = List();
    var historydetail = new Map();
    historydetail["groupName"]=groupName;
    historydetail["time"]=DateTime.now().millisecondsSinceEpoch;
      history.add(historydetail);
      await _firestore.collection("Users").doc(userUid).update({
        'history': FieldValue.arrayUnion(history),
      });

    List<Map> premise = List();
    var premiseCheckIn = new Map();
    premiseCheckIn["groupId"]=groupId;
    premiseCheckIn["time"]=DateTime.now().millisecondsSinceEpoch;
    premise.add(premiseCheckIn);
    await _firestore.collection("Users").doc(userUid).update({
      'CheckIn': FieldValue.arrayUnion(premise),
    });
  }
}
