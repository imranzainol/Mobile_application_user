import 'package:contact_tracing/scan.dart';
import 'package:contact_tracing/widgets/Container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'database/groupdatabase.dart';
import 'generate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'historyUser.dart';
import 'package:contact_tracing/HomePage.dart';

class CreateGroup extends StatefulWidget {

  final User user;

  const CreateGroup({Key key, this.user}) : super(key: key);
  @override
  _CreateGroupState createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String displayName = "";
  FirebaseAuth _auth=FirebaseAuth.instance;

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

  TextEditingController _groupNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        title: Text("Meet Up Name"),
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

      body: Column(
        children: <Widget>[
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ShadowContainer(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _groupNameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      hintText: "Name Your Meeting",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 80),
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      final user1 = _auth.currentUser;
                      groupSetup(_groupNameController.text);
                      Navigator.of(context).pushReplacement(

                          MaterialPageRoute(builder: (BuildContext context)=> GeneratePage(user: user1,value: _groupNameController.text))
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
