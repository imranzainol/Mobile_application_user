
import 'package:contact_tracing/widgets/Container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'database/dbFuture.dart';
import 'database/userModel.dart';

class JoinGroup extends StatefulWidget {
  final UserModel userModel;

  JoinGroup({this.userModel});
  @override
  _JoinGroupState createState() => _JoinGroupState();
}

class _JoinGroupState extends State<JoinGroup> {
  void _joinGroup(BuildContext context, String groupId) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String userUid = auth.currentUser.uid.toString();
    String _returnString = await DBFuture().joinGroup(groupId, userUid);
    if (_returnString == "success") {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
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



  TextEditingController _groupIdController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[BackButton()],
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ShadowContainer(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _groupIdController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      hintText: "Group Id",
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  RaisedButton(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 100),
                      child: Text(
                        "Join",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      _joinGroup(context, _groupIdController.text);
                    },
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
