import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:contact_tracing/HomePage.dart';
import 'historyUser.dart';
import 'scan.dart';

class GeneratePage extends StatefulWidget {

  final User user;
  final String value;

  const GeneratePage({Key key, this.user, this.value}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState+
    return _GeneratePageState();
  }
}

class _GeneratePageState extends State<GeneratePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth _auth=FirebaseAuth.instance;



  String qrData = "";// already generated qr code when the page opens

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, 
      appBar: AppBar(
        title: Text('Meet Up QR Code'),
        actions: <Widget>[],
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
                  SizedBox(height: 
                  
                  0,),
                  Text(widget.user.displayName,style: TextStyle(color: Colors.indigo),)
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
              title: Text("Scan Check In"),
              leading: Icon(Icons.add_a_photo),
              onTap: () {
                final user1 = _auth.currentUser;
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (BuildContext context) => ScanPage(user: user1,)));
              },

            ),

            ListTile(
              title: Text("Meet Up",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
              ),
              leading: Icon(FontAwesomeIcons.qrcode,color: Colors.blue),
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
            ),
          ],
        ),
      ),

      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            QrImage(
              //place where the QR Image will be shown
              data: qrData,
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              "This not the QR code for meeting, Please press the button",
              style: TextStyle(fontSize: 17.0),
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(40, 20, 40, 0),
              child: FlatButton(
                padding: EdgeInsets.all(15.0),
                onPressed: () async {


                  var doc_ref = await FirebaseFirestore.instance.collection("groups")
                      .where("groupName",isEqualTo:widget.value).get();
                  doc_ref.docs.forEach((result) {
                    print(result.id);

                  if (qrdataFeed.text.isEmpty) {
                    setState(() {
                      qrData = result.id;
                    });
                  } else {
                    setState(() {
                      qrData = qrdataFeed.text;
                    });
                  }
                  });
                },
                child: Text(
                  "Generate QR",
                  style: TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.blue, width: 3.0),
                    borderRadius: BorderRadius.circular(20.0)),
              ),
            )
          ],
        ),
      ),
    );
  }
  final qrdataFeed = TextEditingController();
}
