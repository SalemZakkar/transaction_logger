import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project_zero/GUI/Home/home.dart';
import 'package:project_zero/GUI/SignIn/SignIn.dart';
import 'package:project_zero/GUI/customers/customerDetails.dart';
import 'package:project_zero/GUI/customers/customers.dart';
import 'package:shared_preferences/shared_preferences.dart';
class User {
  static Future<void> login(var context,var user , var pass) async {
    loading(context);
    try{
      var rep = await http.post("https://icrcompany.net/api/public/api/login" , body: {
        "user_name" : user,
        "password" : pass
      });
      print(rep.body);
      if(rep.statusCode == 200){
        var data = jsonDecode(rep.body);
        print(data["access_token"]);
        token = data["access_token"];
        print(lang);
        await Setting(lang: lang , user: user , pass: pass).Save();
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => Home()), (route) => false);
      }
      else{
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(langData[lang]["error1"])));
      }
    }catch(e){
      print(e.toString());
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(langData[lang]["error2"])));
    }
  }
  static Future<void> logout(var context ) async {
    await Setting().deleteAll();
    await Setting(lang: lang , user: "n/a" , pass: "n/a").Save();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => SignIn()), (route) => false);
  }
  static Future<void> updatePassword(context , var password, var old) async {
    loading(context);
    try{
      var rep = await http.post("https://api.icrcompany.net/api/change-password" , body: {"old_pass" : old , "new_pass" : password} , headers: {HttpHeaders.authorizationHeader : "Bearer " + token});
      print(rep.body);
      print(rep.statusCode);
      print(old + "\n"+ password);
      if(rep.statusCode == 200){
        await logout(context);
      }
      else{
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: new Text(langData[lang]["error4"])));
      }
    }catch(e){
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: new Text(langData[lang]["error2"])));

    }
  }
  static void loading(var context){
    showDialog(context: context, useRootNavigator: false,builder: (_){

      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          content: new Container(
            width: 150,
            height: 150,
            alignment: Alignment.center,
            child: new CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.blue[900]),),
          ),
        ),
      );

    },
        barrierDismissible: false);
  }
}
class Operation {
  String id;
  String name;
  String buyPrice;
  String sellPrice;
  String from;
  String to;
  String date;
  String fromId;
  String toId;
  Customer customer;
  Operation({@required this.id , this.buyPrice, this.sellPrice, this.from, this.to, this.date,this.name,this.customer , this.toId , this.fromId});
  // ignore: missing_return
   Future<void> addOperation(var context) async {
   User.loading(context);
   try{
     var rep = await http.post("https://icrcompany.net/api/public/api/transaction" , body: {
       "desc" : name,
       "buy_value" : buyPrice,
       "sell_value" : sellPrice,
       "from_id" : fromId,
       "to_id" : toId,
       "created_at" : date
     } , headers: {
       HttpHeaders.authorizationHeader : "Bearer " + token
     });
     if(rep.statusCode == 200){
       Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (builder) => Home()), (route) => false);
     }else{
       Navigator.pop(context);
     }
   }catch(e){
     Navigator.pop(context);
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(langData[lang]["error2"])));
   }
  }
  Future<void> updateOperation(var context) async {
    User.loading(context);
    try{
      var rep = await http.post("https://icrcompany.net/api/public/api/transaction/update/" + id , body: {
        "desc" : name,
        "buy_value" : buyPrice,
        "sell_value" : sellPrice,
        "from_id" : from,
        "to_id" : to,
      } , headers: {
        HttpHeaders.authorizationHeader : "Bearer " + token
      });
      print(rep.statusCode);
      if(rep.statusCode == 200){
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (builder) => Home()), (route) => false);
      }else{
        Navigator.pop(context);
      }
    }catch(e){
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(langData[lang]["error2"])));
    }
  }
  static Future<void>  getOperation(var context , var date) async {
 //    print("http://api.icrcompany.net/api/transaction?date=" + date);
    try{
      var rep = await http.get("https://icrcompany.net/api/public/api/transactions?date=" + date , headers: {
        HttpHeaders.authorizationHeader : "Bearer " + token
      });
      return jsonDecode(rep.body);
    }catch(e){
      return "error";
    }
  }
  static Future<void>  getOperation1(var context) async {
    try{
      var rep = await http.get("https://icrcompany.net/api/public/api/transactions" , headers: {
        HttpHeaders.authorizationHeader : "Bearer " + token
      });
      return jsonDecode(rep.body);
    }catch(e){
      return "error";
    }
  }
  Future<bool> deleteOp(var context) async {
  User.loading(context);
  try{
    var rep = await http.post("https://icrcompany.net/api/public/api/transaction/delete/" + id , headers: {HttpHeaders.authorizationHeader : "Bearer " + token});
    if(rep.statusCode == 200){
      print(rep.body);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => Home()), (route) => false);
    }

    else{
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(langData[lang]["error2"])));
      print(rep.statusCode);
    }
  }catch(e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(langData[lang]["error2"])));
    Navigator.pop(context);
  }
  }
  Future<bool> deleteOp2(var context , Customer c) async {
    User.loading(context);
    try{
      var rep = await http.post("https://icrcompany.net/api/public/api/transaction/delete/" + id , headers: {HttpHeaders.authorizationHeader : "Bearer " + token} , body: {"agent_id" : c.id});
      if(rep.statusCode == 200){
        print(rep.body);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => CustomerDetail(c)), (route) => false);
      }

      else{
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(langData[lang]["error2"])));
        print(rep.body);
      }
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(langData[lang]["error2"])));
      Navigator.pop(context);
    }
  }
}
class Customer{
  String id;
  String type;
  String name;
  List operations;
  String money;
  Customer({@required this.id ,this.type , this.name , this.operations , this.money});
  Future<void> addCustomer(var context) async{
   User.loading(context);
   try{
     var rep = await http.post("https://icrcompany.net/api/public/api/agent" , body: {
       "name" : name,
       "type" : type
     },
     headers: {
       HttpHeaders.authorizationHeader : "Bearer " + token
     });
     print(rep.body);
     if(rep.statusCode == 200){

       print(rep.body);
       Navigator.pop(context);
       Navigator.pop(context);
     }
     else{
       Navigator.pop(context);
       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(langData[lang]["error4"])));
     }
   }
   catch(e){
     Navigator.pop(context);
     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(langData[lang]["error2"])));
   }
    }
    static Future<dynamic> getCustomer(var t) async {
    try{
      var rep = await http.get("http://icrcompany.net/api/public/api/agents?type=" + t,headers: {HttpHeaders.authorizationHeader : "Bearer " + token});
      if(t == '1'){
        customers1 = jsonDecode(rep.body);
      }
      else{
        customers2 = jsonDecode(rep.body);
      }
      return jsonDecode(rep.body);
    }catch(e){
      return "error";
    }
    }
    Future<bool> deleteCustomer(var context) async {
    User.loading(context);
      try{
        var rep = await http.delete("https://icrcompany.net/api/public/api/agent/" + id,headers: {HttpHeaders.authorizationHeader : "Bearer " + token});
        return true;
      }catch(e){
        return false;
      }
    }
    Future<dynamic> getDetails() async {
    try{
      var rep = await http.get("http://icrcompany.net/api/public/api/agent/" + id.toString() , headers: {HttpHeaders.authorizationHeader : "Bearer " + token});
      return jsonDecode(rep.body);

    }catch(e){
      return "error";
    }
    }
  }
bool moneyChecker(String s){
  try{
    int.parse(s);
    return true;
  }catch(e){
    return false;
  }
}
bool textChecker(String s){
  if(s.isNotEmpty && s!=null && s.contains(" ") == false && s.contains(RegExp("[A-z]"))){
    return true;
  }
  else{
    return false;
  }
}
class Setting {
  String lang;
  String user;
  String pass;
  Setting({@required this.lang , this.user , this.pass });
  Future<void> Save() async {
    var settings = await SharedPreferences.getInstance();
    settings.setString("lang", lang);
    settings.setString("user", user);
    settings.setString("pass", pass);
  }
  Future<void> deleteAll() async {
    var settings = await SharedPreferences.getInstance();
    settings.clear();
  }
  Future<dynamic> get() async {
    var settings = await SharedPreferences.getInstance();
    return {"lang" : settings.get("lang") , "user" : settings.get("user") , "pass" : settings.get("pass")};
  }
}
var token;
String lang;
Map<dynamic,dynamic> langData = {};
var direction;
Map<dynamic , dynamic> customers1 = {};
Map<dynamic , dynamic> customers2 = {};
