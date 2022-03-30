import 'package:flutter/material.dart';
import 'package:project_zero/classes/classes.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  FocusNode x = new FocusNode();
  var user = TextEditingController(),pass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: direction,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(appBar: new AppBar(
          backgroundColor: Colors.blue[900],
          toolbarHeight: 80,
          title: new Text(langData[lang]["signIn"],textScaleFactor: 1.0),
          centerTitle: true,
        ),
          backgroundColor: Colors.white,
          body: Container(
            width: width,
            height: height,
            color: Color.fromRGBO(255,254,234, 1),
            alignment: Alignment.center,
            child: new SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Container(
                    width: width*0.65,
                    height: 200,
                    alignment: Alignment.center,
                    child: Image.asset("assets/signIn.jpg"),
                  ),
                  new Text("\n",textScaleFactor: 1,),
                 Form(child: new Column(
                   children: [
                     new Container(width: width*0.9,
                       alignment: Alignment.center,
                       height: 50,
                       child: new TextFormField(
                         controller: user,
                         //focusNode: x,
                         onEditingComplete: (){
                           FocusScope.of(context).requestFocus(x);
                         },
                         textDirection: TextDirection.ltr,
                         decoration: InputDecoration(
                             labelText: langData[lang]["userName"],
                             labelStyle: new TextStyle(color: Colors.black),


                         ),
                       ),
                     ),
                     new Container(width: width*0.9,
                       height: 50,
                       alignment: Alignment.center,
                       child: new TextFormField(
                         controller: pass,
                         focusNode: x,
                         obscureText: true,
                         textDirection: TextDirection.ltr,
                         decoration: InputDecoration(
                             labelText: langData[lang]["password"],
                             labelStyle: new TextStyle(color: Colors.black)

                         ),
                       ),
                     ),
                     new Text("\n" , textScaleFactor: 1,),

                     Container(
                       width: width*0.9,
                       height: 50,
                       child: new ElevatedButton(
                         style: ButtonStyle(
                           backgroundColor: MaterialStateProperty.all(Colors.blue[900])
                         ),
                         onPressed:(){
                          User.login(context, user.text, pass.text);
                       },
                       child: new Text(langData[lang]["signIn"]),

                       ),
                     )
                   ],
                 ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
