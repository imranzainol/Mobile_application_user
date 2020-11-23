import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> userHistory(String userUid, String groupName) async {
    List<Map> history = List();
    var historydetail = new Map();
    historydetail["groupName"]=groupName;
    historydetail["time"]=DateTime.now().millisecondsSinceEpoch;
      history.add(historydetail);
      await _firestore.collection("Users").doc(userUid).update({
        'history': FieldValue.arrayUnion(history),

      });
  }
}
