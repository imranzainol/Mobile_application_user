import 'dart:async';
import 'package:flutter/material.dart';
import 'LogInUser.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _SplashScreen();
  }

}

class _SplashScreen extends State<SplashScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),

      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyImage(),
                    Text("Contact Tracing",style: TextStyle(fontSize:30
                        ,color: Color(0xFF039BE5),fontWeight: FontWeight.bold),
                    )
                  ],
                ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text("Covid-19 Contact Tracing",style: TextStyle(fontSize:20
                      ,fontStyle: FontStyle.italic,color: Color(0xFF039BE5))
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
void NavigateToLogin(){
    Timer(Duration(seconds: 3),()=> Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context)=> LogInUser())
    ));


}

  @override
  void initState() {
    super.initState();
    NavigateToLogin();

  }
}

class MyImage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    AssetImage image=new AssetImage('image/logo.png');
    Image logo=new Image(image: image,width: 250,height: 250,);
    return logo;
  }
}