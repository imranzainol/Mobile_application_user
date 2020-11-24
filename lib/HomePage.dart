import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_tracing/scan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'LogInUser.dart';
import 'contact.dart';
import 'createGroup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'historyUser.dart';
import 'loading.dart';


// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String displayName = "";
  int riskData;

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

Future getList() async {
    var docRef = await FirebaseFirestore.instance.collection("Users")
      .where("fullName",isEqualTo:displayName).get();
    docRef.docs.forEach((result) {
    setState(() {
    riskData = result.data()['riskLevel'];
    });
    print(riskData);
  });
    return riskData;
  }  
  Future<void> logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
    preferences.remove('displayName');
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
        title: Text("Home"),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: (){
                logOut();
              },
              icon: Icon(Icons.person,color:Color(0xffffffff),),
              label: Text("Log Out",style: TextStyle(color: Colors.white)))
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
              title: Text("Home",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
                  ),
              leading: Icon(Icons.home,color: Colors.blue),
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
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (BuildContext context) => CreateGroup()));
              },
            ),

            ListTile(
              title: Text("History"),
              leading: Icon(FontAwesomeIcons.book),
              onTap: () {

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
        child: FutureBuilder(
          future: getList(),
          // ignore: missing_return
          builder: (context, snapshot) {
            print("-----------------------------------------");
            print(riskData);
            Icon(Icons.person,color:Colors.indigo,size:250,);
            Text(
              "User Status",
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            );
            SizedBox(
              height: 20.0,
            );
            if (riskData == 0){
            return Center(
              child: 
            Text(
            "No Risk",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.green),
            textAlign: TextAlign.center,
              ),
            );
            }
            else if (riskData == 1){
            return Center(
              child: 
              
            Text(
            "Low Risk",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.yellow),
            textAlign: TextAlign.center,
              ),
            );
            }
            else if (riskData == 2){
            return Center(
              child: 
              
            Text(
            "Medium Risk",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.orange),
            textAlign: TextAlign.center,
              ),
            );
            }
            else if (riskData == 3){
            return Center(
              child: 
              
            Text(
            "High Risk",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.red),
            textAlign: TextAlign.center,
              ),
            );
            }
            else if (riskData == 4){
            return Center(
              child: 
              Text(
            "Infected",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,color: Colors.black),
            textAlign: TextAlign.center,
              ),
            );
            }
          },
        ),
      ),
    );
  }
}
