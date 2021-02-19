import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'HomePage.dart';
import 'LogInUser.dart';
import 'createGroup.dart';
import 'historyUser.dart';
import 'scan.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: must_be_immutable
class ContactDev extends StatefulWidget {
  @override
  _ContactDevState createState() => _ContactDevState();
}

class _ContactDevState extends State<ContactDev> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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

  Future<void> logOut() async {
    _auth.signOut().then((value) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => LogInUser()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Color(0xFF039BE5),
        title: Text("Contact"),
        actions: <Widget>[
        ],
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
              title: Text("Scan Check In"),
              leading: Icon(Icons.add_a_photo),
              onTap: () {
                final user1 = _auth.currentUser;
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (BuildContext context) => ScanPage(user: user1,)));
              },
            ),

            ListTile(
              title: Text("Meet Up"),
              leading: Icon(FontAwesomeIcons.qrcode),
              trailing: Image(image: AssetImage("image/new.gif"),),
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
              title: Text("Contact Us",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue)),
              leading: Icon(Icons.email,color: Colors.blue),
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

            Image(image: AssetImage("image/unikl.png"),height:150,width:150,),

            SizedBox(
              height: 40.0,
            ),

            ListTile(
              title: Text(
                "mimran.zainol@s.unikl.edu.my",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              leading: Icon(Icons.email),
            ),

            SizedBox(
              height: 20.0,
            ),

            ListTile(
              title: Text(
                "fadzil@unikl.edu.my",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              leading: Icon(Icons.email),
            ),

            SizedBox(
              height: 20.0,
            ),

            ListTile(
              title: Text(
                "019-424 5693",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              leading: Icon(Icons.phone_android),
            ),

          ],
        ),
      ),
    );
  }
}
