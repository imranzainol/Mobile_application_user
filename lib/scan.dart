import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:contact_tracing/HomePage.dart';
import 'package:contact_tracing/search.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'contact.dart';
import 'createGroup.dart';
import 'database/dbFuture.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'database/history.dart';
import 'historyUser.dart';

class ScanPage extends StatefulWidget {
  final User user;
  final String value;

  const ScanPage({Key key, this.user, this.value}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ScanPageState();
  }
}
class _ScanPageState extends State<ScanPage> {

  String displayName = "";

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = prefs.getString('displayName');
    });
  }

  void _joinGroup(BuildContext context, String groupId) async {

    FirebaseAuth auth = FirebaseAuth.instance;
    String userUid = auth.currentUser.uid.toString();
    String _returnString = await DBFuture().joinGroup(groupId, userUid);
    if (_returnString == "error") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ScanPage(),
          ),
              (route) => false);
    } else {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          content: Text(_returnString),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
  void _userHistory(BuildContext context, String groupName) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String userUid = auth.currentUser.uid.toString();
    var doc_ref = await FirebaseFirestore.instance.collection("Users")
        .where("userUid",isEqualTo:userUid).get();
    doc_ref.docs.forEach((result) {
    History().userHistory(result.id, groupName);
    });
  }


  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String qrCodeResult = "Not Yet Scanned";

  // ignore: non_constant_identifier_names
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("User Check In"),
        centerTitle: true,
      ),

      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 170,
              color: Color(0xffffffff),
              child:Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 30)),
                  Image(image: AssetImage("image/logo.png"),height:90,width:90,),
                  SizedBox(height: 10,),
                  Text(displayName,style: TextStyle(color: Colors.indigo),)
                ],
              ),
            ),
            ListTile(
              title: Text("Home"),
              leading: Icon(Icons.home),
              onTap: () {
                final user1 = _auth.currentUser;
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));
              },
            ),

            ListTile(
              title: Text("Scan Check In",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
              ),
              leading: Icon(Icons.add_a_photo,color: Colors.blue),
            ),

            ListTile(
              title: Text("Meet Up"),
              leading: Icon(FontAwesomeIcons.qrcode),
              onTap: () {
                final user1 = _auth.currentUser;
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (BuildContext context) => CreateGroup()));
              },
            ),

            ListTile(
              title: Text("History"),
              leading: Icon(FontAwesomeIcons.book),
              onTap: () {
                final user1 = _auth.currentUser;
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (BuildContext context) => historyUser()));
              },
            ),

            Divider(),

            ListTile(
              title: Text("Contact Us"),
              leading: Icon(Icons.email),
              onTap: () {
                final user1 = _auth.currentUser;
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (BuildContext context) => ContactDev()));
              },
            ),
          ],
        ),
      ),

      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Result",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Text(
              qrCodeResult,
              style: TextStyle(
                fontSize: 20.0,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20.0,
            ),
            FlatButton(
              padding: EdgeInsets.all(15.0),
              onPressed: () async {
                String codeScanner = await BarcodeScanner.scan();    //barcode scanner
                final DocumentSnapshot getuserdoc =
                await FirebaseFirestore.instance.collection('groups').doc(codeScanner).get();
                String groupName = getuserdoc.data()['groupName'];

                setState(() {
                  qrCodeResult = "Check in"+" "+groupName;
                  _joinGroup(context, codeScanner);
                  _userHistory(context, groupName);
                });
              },
              child: Text(
                "Check In",
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.blue, width: 3.0),
                  borderRadius: BorderRadius.circular(20.0)),
            )
          ],
        ),
      ),
    );
  }

}
