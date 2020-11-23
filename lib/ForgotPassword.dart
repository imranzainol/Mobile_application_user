import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ForgotPassword();
        }
}

class _ForgotPassword extends State<ForgotPassword>{
  String email="";
  var _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(title: Text("Password Reset",style:
      TextStyle(color: Colors.white),),backgroundColor: Colors.indigo,),
      body: Center(
        child:Padding(padding: EdgeInsets.only(top: 50,left: 20,right: 20),

          child: Form(
          key: _formKey,
          child:Column(
          children: <Widget>[
            Text("We will mail your link. Enter your Email",
              style: TextStyle(color: Colors.indigo,fontSize: 20),
            ),

            Theme(
              data: ThemeData(
                  hintColor: Colors.blue
              ),
                  child: TextFormField(

                    validator: (value){
                      if(value.isEmpty){
                        return "Please enter Your Email";
                      }else{
                        email=value;
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.indigo,width: 1)
                      ),

                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.indigo,width: 1)
                      ),

                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.indigo,width: 1)
                      ),

                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.indigo,width: 1)
                      ),
                    ),
                  ),
            ),

          Padding(
            padding: EdgeInsets.only(left: 30,right: 30,top: 40) ,
            child:RaisedButton(
              onPressed: () {
                if(_formKey.currentState.validate()){
                    FirebaseAuth.instance.sendPasswordResetEmail(email: email).
                    then((value) => print("Check your email"));
                  }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Color(0xFF039BE5),
              child: Text("Send Email",style: TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold,fontSize: 20),),
              padding: EdgeInsets.all(10),

            )
          )
          ],
          ),
        ),
      ),
      ),
    );
  }
}

