import 'package:cloud_firestore/cloud_firestore.dart';

class DBFuture {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> joinGroup(String groupId, String userUid) async {
    String retVal = "error";
    List<Map> members = List();
    var memberCheckIn = new Map();
    memberCheckIn["UserIn"]=userUid;
    memberCheckIn["time"]=DateTime.now().millisecondsSinceEpoch;
      members.add(memberCheckIn);
      await _firestore.collection("groups").doc(groupId).update({
        'members': FieldValue.arrayUnion(members),
      });
      retVal = "success";
    return retVal;
  }
}
