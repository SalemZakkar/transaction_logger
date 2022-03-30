import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:project_zero/classes/classes.dart';

class MyAccount extends StatefulWidget {
  var user ; var pass;
  MyAccount(this.user,this.pass);
  @override
  _MyAccountState createState() => _MyAccountState(user,pass);
}

class _MyAccountState extends State<MyAccount> {
  var user ; var pass;
  var visible = false;
  var controller = TextEditingController();
  var controller1 = TextEditingController();
  _MyAccountState(this.user,this.pass);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(KeyboardVisibilityNotification().isKeyboardVisible);
    KeyboardVisibilityNotification().addNewListener(
        onChange: (state){
          setState(() {
            visible = !state;
          });

        },
        onHide: (){
          setState(() {
            visible = true;
            print("done");
          });
        }
    );

  }
  @override
  Widget build(BuildContext context) {

    final width= MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: direction,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          appBar: new AppBar(
            title: new Text(langData[lang]["mAccount"]),
            toolbarHeight: 80,
            backgroundColor: Colors.blue[900],
          ),
          body: Container(
            width: width,
            height: height,
            alignment: Alignment.topCenter,
            color: Colors.white,
            child: new SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 new Text("\n"),
                  new Image.asset("assets/person.jpg" ,width: width*0.7,),
                  new Text("\n\n"),
                  new Text(user,style: new TextStyle(color: Colors.blue[900],fontSize: 20),textScaleFactor: 1,),
                  new Text("\n\n\n\n"),
                  new Container(
                    width: width*0.9,
                    alignment: Alignment.center,
                    child: new TextField(
                      obscureText: true,
                      style: new TextStyle(color: Colors.blue[900]),
                      controller: controller,
                      enabled: true,
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                        labelText: langData[lang]["newPassword"],
                        labelStyle: new TextStyle(color: Colors.blue[900]),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue[900]),
                        )
                      ),
                    ),
                  ),
                  new Text("\n"),
                  new Container(
                    width: width*0.9,

                    alignment: Alignment.center,
                    child: new TextField(
                      controller: controller1,
                      obscureText: true,
                      style: new TextStyle(color: Colors.blue[900]),
                      textDirection: TextDirection.ltr,
                      enabled: true,
                      decoration: InputDecoration(
                        labelText: langData[lang]["confirmPassword"],
                          labelStyle: new TextStyle(color: Colors.blue[900]),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue[900]),
                          )
                      ),
                    ),
                  ),
                  new Text("\n"),
                ],
              ),
            ),
          ),
          floatingActionButton: Visibility(
            visible: visible,
            child: FloatingActionButton(
              backgroundColor: Colors.blue[900],
              child: new Icon(Icons.done),
              onPressed: () async {
                FocusScope.of(context).unfocus();
                if(controller.text.contains(" ") == false && controller.text.contains(RegExp("[A-z]")) && controller1.text.contains(" ") == false && controller1.text.contains(RegExp("[A-z]")) ){
                  if(controller.text == controller1.text){
                    await User.updatePassword(context, controller1.text, pass);
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(langData[lang]["error5"])));

                  }
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(langData[lang]["error4"])));
                }
              },
            ),
          )
        ),
      ),
    );
  }
}
