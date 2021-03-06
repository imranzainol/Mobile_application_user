import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_tracing/scan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
  FirebaseMessaging fm = FirebaseMessaging();
  
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String displayName = "";
  int riskData;

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {

    getData();
    fm.configure();
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
              trailing: Image(image: AssetImage("image/new.gif"),),
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

      body: new Builder(
          builder: (BuildContext context) {
        return Column(
            children: <Widget>[

              Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Column(
                    children: [
                      Text(
                        "*This Application will alert you if has contact with person that contact close in every level. Please alert notification from this application, it may save many life.",
                        style: TextStyle(fontSize: 16.0,),
                        textAlign: TextAlign.left,
                      )

                    ],
                  ),
                ),
              ),

              Expanded(
                flex: 6,
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Icon(Icons.person,color:Colors.indigo,size:300,)
                    ],
                  ),
                ),
              ),

              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Column(
                    children: [
                      Text(
                        "User Status",
                        style: TextStyle(fontSize: 27.0, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )

                    ],
                  ),
                ),
              ),


              Expanded(
                flex: 1,

                child: FutureBuilder(
                  future: getList(),
                  // ignore: missing_return
                  builder: (context, snapshot) {

                    print(riskData);

                    if (riskData == 0){
                    return Center(
                      child:
                      Text(
                    "No Risk",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.green),
                    textAlign: TextAlign.center,
                      ),
                    );
                    }
                    else if (riskData == 1){
                    return Center(
                      child:

                      Text(
                    "Low Risk",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.yellow),
                    textAlign: TextAlign.center,
                      ),
                    );
                    }
                    else if (riskData == 2){
                    return Center(
                      child:

                      Text(
                    "Medium Risk",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.orange),
                    textAlign: TextAlign.center,
                      ),
                    );
                    }
                    else if (riskData == 3){
                    return Center(
                      child:

                      Text(
                    "High Risk",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.red),
                    textAlign: TextAlign.center,
                      ),
                    );
                    }
                    else if (riskData == 4){
                    return Center(
                      child:
                      Text(
                    "Infected",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.black),
                    textAlign: TextAlign.center,
                      ),
                    );
                    }
                    else {
                      return Center(
                          child: Body()
                      );
                    }
                  },
                ),
              ),

              Expanded(
                flex: 2,

                child: FutureBuilder(
                  future: getList(),
                  // ignore: missing_return
                  builder: (context, snapshot) {

                    print(riskData);

                    if (riskData == 0){
                      return Center(
                        child:
                        Text(
                          "You has no risk, Please wear mask when go out.",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    else if (riskData == 1){
                      return Center(
                        child:

                        Text(
                          "You is the third layer contact tracing. Please quarantine 14 days.",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    else if (riskData == 2){
                      return Center(
                        child:

                        Text(
                          "You may contact to 2nd level of COVID-19 suspects, perform swab test",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    else if (riskData == 3){
                      return Center(
                        child:

                        Text(
                          "You high possible may contact COVID-19 patient. Go near Hospital for COVID-19 test",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    else if (riskData == 4){
                      return Center(
                        child:
                        Text(
                          "You has infected",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    else {
                      return Center(
                          child: Body()
                      );
                    }
                  },
                ),
              ),


            ],
            );
        }
      ),
    );
  }
}
