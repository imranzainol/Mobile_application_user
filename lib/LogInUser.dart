
import 'package:contact_tracing/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'ForgotPassword.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LogInUser extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LogInUser();
  }
}

class _LogInUser extends State<LogInUser>{
  String displayName = "";

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFFFFFFF),
      body:Form(
      key: _formKey,
      child: ListView(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 180,
          child:Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              SizedBox(height: 50,),

              Text("Log in",
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                fontSize: 35),),

              Text("User Log In Menu",
              style: TextStyle(color: Colors.white),)

            ],
          ),
          ),

          decoration: BoxDecoration(borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(150)),
            color: Color(0xFF039BE5),

          ),
        ),

        Theme(
          data: ThemeData(
            hintColor: Colors.blue
          ),
          child:Padding(padding: EdgeInsets.only(top: 100,right: 20,left: 20),
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            validator: (value){
              if(value.isEmpty){
                return "Please enter Your Email";
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
          )
        ),
        ),


        Theme(
          data: ThemeData(
              hintColor: Colors.blue
          ),
          child:Padding(padding: EdgeInsets.only(top: 20,right: 20,left: 20),
              child: TextFormField(
                controller: _passwordController,
                obscureText: true,
                autocorrect: false,
                validator: (value){
                  if(value.isEmpty){
                    return "Please enter Your Password";
                  }else if (value.length<6){
                    return "Too Short";
                  }
                  return null;
                },

                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: "Password",
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
              )
          ),
        ),

      Padding(padding: EdgeInsets.only(right: 20,top: 10),
      child: Container(
          width: double.infinity,
          child:InkWell(
            onTap:(){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>ForgotPassword()));},
          child: Text("Forgot password?",style: TextStyle(color: Color(0xFF039BE5)),
          textAlign: TextAlign.right,),
          ),
      ),
    ),


        SizedBox(height: 20,),
        Padding(
          padding: EdgeInsets.only(left: 20,right: 20,top: 50),
          child:RaisedButton(
            onPressed: () async {
              try {
                await Firebase.initializeApp();
                UserCredential user =
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
                SharedPreferences preferences = await SharedPreferences.getInstance();
                preferences.setString('email', _emailController.text);

                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('displayName', user.user.displayName);

                Navigator.of(context).pushNamed(AppRoutes.menu);
              } on FirebaseAuthException catch (e) {
                if (e.code == 'weak-password') {
                  print('The password provided is too weak.');
                } else if (e.code == 'email-already-in-use') {
                  print('The account already exists for that email.');
                }
              } catch (e) {
                print(e.toString());
              }
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            color: Color(0xFF039BE5),
            child: Text("Log In",
            style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.bold,fontSize: 20),),
          padding: EdgeInsets.all(10),
        )
        ),


        SizedBox(height: 20),

        Center(
          child:Column(
            children: <Widget>[
              Text("Don't have an account",style: TextStyle(
                  color: Colors.indigo
              ),),

              SizedBox(height: 5),

              FlatButton(onPressed: (){
                Navigator.of(context).pushNamed(AppRoutes.authRegister);
                },
              child: Text("Sign In Here",style: TextStyle(color: Colors.blue),),
              ),
            ],
          )
        )
      ],
    )
    ),
    );
  }

}