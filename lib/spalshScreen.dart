import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_zero/GUI/SignIn/SignIn.dart';
import 'package:project_zero/classes/classes.dart';
import 'package:http/http.dart' as http;

import 'GUI/Home/home.dart';
class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}
String user;
String pass;
Future<bool> login(var context,var user , var pass) async {
//  print(user + pass);
  try{
    var rep = await http.post("https://icrcompany.net/api/public/api/login" , body: {
      "user_name" : user,
      "password" : pass
    });
    print(rep.body);
    if(rep.statusCode == 200){
      var data = jsonDecode(rep.body);
      //print(data["access_token"]);
      token = data["access_token"];
      //print(lang);
      if(user == null){
        user = pass = 'n/a';
      }
      await Setting(lang: lang , user: user , pass: pass).Save();
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => Home()), (route) => false);
      return true;
    }
    else{
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => SignIn()), (route) => false);
      return true;
    }
  } on SocketException{
        SystemNavigator.pop(animated: true);
  }
}
void loader(var context) async {
  var data = await Setting().get();
  user = data["user"];
  pass = data["pass"];
  lang = data["lang"];
  print(data);
  if(lang == null){
    lang = "en";
    direction = TextDirection.ltr;
  }
  if(lang == "en"){
    direction = TextDirection.ltr;
  }
  if(lang == "ar"){
    direction = TextDirection.rtl;
  }
  if(user == null){
    user = pass = 'n/a';
  }
  langData = jsonDecode(
    await DefaultAssetBundle.of(context).loadString("assets/loc.json")
  );
//  print(langData);
//  print(lang);
}
class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loader(context);
  }
  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    Timer(Duration(milliseconds: 1000), (){
      if(isLoaded == false){
        setState(() {

        });
        isLoaded = true;
      }
    });
    return new Scaffold(
      body: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        color: Color.fromRGBO(3, 3, 114, 1),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/icon.png" , width: width*0.5,height: height*0.3,),
            new Text("\n\n Powered By ICR Company\n\n" , style: new TextStyle(color: Colors.white),textScaleFactor: 1,),
            FutureBuilder(future: login(context, user, pass) ,builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return new CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                );}
                else{
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  );
              }
              }
            )
          ],
        ),
      ),
    );
  }
}
