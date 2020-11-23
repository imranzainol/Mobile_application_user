import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'database/firebase.dart';
import 'routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInUser extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SignInUser();
  }
}

class _SignInUser extends State<SignInUser> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneNoUser = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();


  void _signInUser(String email, String password, BuildContext context) async {
    try {
      await Firebase.initializeApp();
      UserCredential user =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User updateUser = FirebaseAuth.instance.currentUser;
      updateUser.updateProfile(displayName: _usernameController.text);
      userSetup(_usernameController.text,_emailController.text,_phoneNoUser.text);

      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('email', email);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('displayName',_usernameController.text);

      Navigator.of(context).pushNamed(AppRoutes.menu);

    }  catch (e) {
      print(e);
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFFFFFFFF),
      body:Form(
        child:ListView(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 180,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  BackButton(color: Colors.white,),

                  Text("Sign Up",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold,
                        fontSize: 35),),

                  Text("User Sign Up Menu",
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
            child: Padding(
                padding: EdgeInsets.only(top: 40, right: 20, left: 20),
                child: TextFormField(
                  controller: _usernameController,
                  validator: (value){
                    if(value.isEmpty){
                      return "Please enter Your name";
                    }
                    return null;
                  },

                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.indigo, width: 1)
                    ),

                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.indigo, width: 1)
                    ),

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.indigo, width: 1)
                    ),

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.indigo, width: 1)

                    ),
                  ),
                )
            ),
          ),

          Text(
            "        *Name According in Identification Card",
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,color: Colors.grey),
          ),

          Theme(
            data: ThemeData(
                hintColor: Colors.blue
            ),
            child: Padding(
                padding: EdgeInsets.only(top: 15, right: 20, left: 20),
                child: TextFormField(
                  controller: _phoneNoUser,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  ],
                  validator: (value){
                    if(value.isEmpty){
                      return "Please enter Your Phone Number";
                    }
                    return null;
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.indigo, width: 1)
                    ),

                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.indigo, width: 1)
                    ),

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.indigo, width: 1)
                    ),

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.indigo, width: 1)

                    ),
                  ),
                )
            ),
          ),

          Text(
            "        *Please enter Your Phone Number",
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,color: Colors.grey),
          ),



          Theme(
            data: ThemeData(
                hintColor: Colors.blue
            ),
            child: Padding(
                padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
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
                        borderSide: BorderSide(color: Colors.indigo, width: 1)
                    ),

                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.indigo, width: 1)
                    ),

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.indigo, width: 1)
                    ),

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.indigo, width: 1)

                    ),
                  ),
                )
            ),
          ),

          Text(
            "        *Please enter Your Email",
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,color: Colors.grey),
          ),

          Theme(
            data: ThemeData(
                hintColor: Colors.blue
            ),
            child: Padding(
                padding: EdgeInsets.only(top: 20, right: 20, left: 20),
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
                        borderSide: BorderSide(color: Colors.indigo, width: 1)
                    ),

                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.indigo, width: 1)
                    ),

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.indigo, width: 1)
                    ),

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.indigo, width: 1)

                    ),
                  ),
                )
            ),
          ),

          Text(
            "        *Password must more than 6 words",
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,color: Colors.grey),
          ),


          Theme(
            data: ThemeData(
                hintColor: Colors.blue
            ),
            child: Padding(
                padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                child: TextFormField(
                  controller: _confirmPasswordController,
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
                    labelText: "Confirm Password",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.indigo, width: 1)
                    ),

                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.indigo, width: 1)
                    ),

                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.indigo, width: 1)
                    ),

                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(color: Colors.indigo, width: 1)

                    ),
                  ),
                )
            ),
          ),

          Text(
            "        *Please Re-enter Your Password",
            style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold,color: Colors.grey),
          ),

          SizedBox(height: 10,),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top:20),
              child: RaisedButton(
                onPressed: () {
                    if(_usernameController.text == ""){
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Enter your full name"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                    else if(_usernameController.text == ""){
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Enter your Phone Number"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }

                    else if(_emailController.text == ""){
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Enter your email"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }

                    else if(_emailController.text == ""){
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Enter your email"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }

                    else if(_passwordController.text == ""){
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Enter your password"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }

                    else if(_passwordController.text.length < 6){
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Password is too short"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }

                    else if(_passwordController.text != _confirmPasswordController.text){
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Passwords do not match"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                    else {
                      _signInUser(_emailController.text,_passwordController.text, context);
                    }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Color(0xFF039BE5),
                child: Text("Sign Up", style: TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold, fontSize: 20),),
                padding: EdgeInsets.all(10),
              )
          ),

          SizedBox(height: 20),
        ],
      ),
      ),
    );
  }

}