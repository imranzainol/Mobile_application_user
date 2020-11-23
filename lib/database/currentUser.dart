import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';

class CurrentUser extends ChangeNotifier {

String _uid;
String _email;

String get getUid => _uid;
String get getEmail => _email;


Future<bool> signUpUser (String email,String password)async{
  bool retVal = false;
  try{
    await Firebase.initializeApp();
    UserCredential _authResult =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    if(_authResult.user!=null){
      retVal=true;
    }
  }catch(e){
    print(e);
  }
  return retVal;
}
Future<bool> logInUser (String email,String password)async{
  bool retVal = false;
  try{
    UserCredential _authResult =
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    if(_authResult.user!=null){
      _uid=_authResult.user.uid;
      _email=_authResult.user.email;
      retVal=true;
    }
  }catch(e){
    print(e);
  }
  return retVal;
}
}
