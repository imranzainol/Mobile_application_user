import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contact_tracing/scan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'HomePage.dart';
import 'contact.dart';
import 'createGroup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'loading.dart';


// ignore: must_be_immutable
class historyUser extends StatefulWidget {
  @override
  _historyUserState createState() => _historyUserState();
}

class _historyUserState extends State<historyUser> {
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


  Future<List<dynamic>> getList() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    var firestore = FirebaseFirestore.instance;
    String userUid = auth.currentUser.uid.toString();
    var doc_ref = await firestore.collection("Users").where("userUid",isEqualTo:userUid).get();
    print(doc_ref.docs[0].get("history"));
    List<dynamic> info = doc_ref.docs[0].get("history");
    return info;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Color(0xFF039BE5),
        title: Text("History"),
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
              title: Text("History",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue),
              ),
              leading: Icon(FontAwesomeIcons.book,color: Colors.blue),
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
            builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Body()
            );
            }
            else if (snapshot.data.length == 0) {
              return Center(
                  child: Text("No history",style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold,))
              );
            }
            else {
              return Container(
                child: ListView.builder(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {

                      return ListTile(
                        title: Text
                          (snapshot.data[index]["groupName"]),

                        trailing: Text(DateFormat("dd-MM-yyyy | hh:mm:ss")
                            .format(DateTime.fromMicrosecondsSinceEpoch(
                            snapshot.data[index]["time"] * 1000))
                            .toString()),
                      );
                    }),
              );
            }

            
          },
        ),
      ),
    );
  }
}
