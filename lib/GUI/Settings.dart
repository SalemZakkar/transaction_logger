import 'package:flutter/material.dart';
import 'package:project_zero/GUI/Home/home.dart';
import 'package:project_zero/classes/classes.dart';
class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: direction,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.blue[900],
          title: new Text(langData[lang]["settings"]),
          centerTitle: true,
          toolbarHeight: 100,
        ),
          backgroundColor: Colors.white,
          body: new Container(
            width: width,
            height: height,
            alignment: Alignment.topCenter,
            child: new SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  new SizedBox(height: 50,),
                  new Container(
                    width: width*0.9,
                    height: 100,
                    color: Colors.white,
                    child: new ElevatedButton(
                      onPressed: (){
                        showModalBottomSheet(context: context, builder: (context){
                          return new Container(
                            width: width,
                            color: Colors.white,
                            alignment: Alignment.center,
                            height: 80,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                new TextButton(onPressed: ()async{
                                  var data = await Setting().get();
                                  var user = data["user"];
                                  var pass = data["pass"];
                                  setState(() {
                                    lang = "en";
                                    direction = TextDirection.ltr;
                                  });
                                  await Setting(lang: lang,user: user,pass: pass).Save();
                                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (builder) => Home()), (route) => false);
                                }, child: new Text("English")),
                                new TextButton(onPressed: ()async{
                                  var data = await Setting().get();
                                  var user = data["user"];
                                  var pass = data["pass"];
                                  setState(() {
                                    lang = "ar";
                                    direction = TextDirection.rtl;
                                  });
                                  await Setting(lang: lang,user: user,pass: pass).Save();
                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => Home()), (route) => false);
                                }, child: new Text("العربية")),
                              ],
                            ),
                          );
                        });
                      },
                      child: new Text(langData[lang]["language"]),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0))),
                        backgroundColor: MaterialStateProperty.all(Colors.green)
                      ),
                    ),
                  ),
                  new SizedBox(height: 50,),
                  new Container(
                    width: width*0.9,
                    height: 100,
                    color: Colors.white,
                    child: new ElevatedButton(
                      onPressed: () async {
                        await User.logout(context);
                      },
                      child: new Text(langData[lang]["logOut"]),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0))),
                          backgroundColor: MaterialStateProperty.all(Colors.green)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
