import 'package:flutter/material.dart';
import 'package:project_zero/GUI/Home/addOperation.dart';
import 'package:project_zero/GUI/Home/custom.dart';
import 'package:project_zero/GUI/Home/myAccount.dart';
import 'package:project_zero/GUI/Home/viewByDate.dart';
import 'package:project_zero/GUI/Settings.dart';
import 'package:project_zero/GUI/customers/customers.dart';
import 'package:project_zero/classes/classes.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<Home> {
  String date = "2000-01-01";
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: direction,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          drawer: new Drawer(
            child: new Container(
              height: height,
              color: Colors.white,
              alignment: Alignment.center,
              width: width,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Container(
                    width: width,
                    height: 120,
                    color: Colors.blue[900],
                    alignment: Alignment.center,
                    child: new Text("\n" + langData[lang]["menu"] , style: new TextStyle(color: Colors.white,fontSize: 20),textScaleFactor: 1,),

                  ),
                  new Container(
                    width: width,
                    height: height-120,
                    alignment: Alignment.topCenter,
                    child: new SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          new Text("\n",textScaleFactor: 1,)
                          ,new Container(
                            width: width*0.65,
                            height: 90,
                            color: Colors.white,
                            //                      alignment: Alignment.center,
                            child: new ElevatedButton(
                              onPressed: () async {
                                var data = await Setting().get();
                                var user = data["user"];
                                var pass = data["pass"];
                                Navigator.push(context, MaterialPageRoute(builder: (b) => MyAccount(user, pass)));
                              },
                              child: new Row(mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  new Text("\t" , textScaleFactor: 1,),
                                  new Icon(Icons.account_box_rounded),
                                  new SizedBox(
                                    width: width*0.1,
                                  ),
                                  new Text(langData[lang]["mAccount"] ,textScaleFactor: 1,),
                                ],
                              ),

                              style: new ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0))),
                                  backgroundColor: MaterialStateProperty.all(Colors.green)
                              ),
                            ),

                          ),
                          new Text("\n",textScaleFactor: 1,)
                          ,new Container(
                            width: width*0.65,
                            height: 90,
                            color: Colors.white,
                            //                      alignment: Alignment.center,
                            child: new ElevatedButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (b) => Customers()));
                              },
                              child: new Row(mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  new Text("\t" , textScaleFactor: 1,),
                                  new Icon(Icons.person),
                                  new SizedBox(
                                    width: width*0.1,
                                  ),
                                  new Text(langData[lang]["customers"] ,textScaleFactor: 1,),
                                ],
                              ),

                              style: new ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0))),
                                  backgroundColor: MaterialStateProperty.all(Colors.green)
                              ),
                            ),

                          ),
                          new Text("\n",textScaleFactor: 1,)
                          ,new Container(
                            width: width*0.65,
                            height: 90,
                            color: Colors.white,
                            //                      alignment: Alignment.center,
                            child: new ElevatedButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (b) => Settings()));
                              },
                              child: new Row(mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  new Text("\t" , textScaleFactor: 1,),
                                  new Icon(Icons.settings),
                                  new SizedBox(
                                    width: width*0.1,
                                  ),
                                  new Text(langData[lang]["settings"] ,textScaleFactor: 1,),
                                ],
                              ),

                              style: new ButtonStyle(
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0))),
                                  backgroundColor: MaterialStateProperty.all(Colors.green)
                              ),
                            ),

                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ),
          ),
          appBar: new AppBar(
            backgroundColor: Colors.blue[900],
            toolbarHeight: 80,
            title: new Text(langData[lang]["operations"]),
           // centerTitle: true,
 //       leading: new IconButton(icon: Icon(Icons.settings), onPressed: (){
  //        Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
            actions: [
//          new   IconButton(icon: Icon(Icons.person), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (builder) => Customers()))),
              new IconButton(icon: Icon(Icons.search), onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeDate()));
              }),
              new IconButton(icon: Icon(Icons.add), onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder) => AddOperation()));
              }),


            ],
          ),
          backgroundColor: Colors.white,
          body: new Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            child: FutureBuilder(
              future: Operation.getOperation1(context),
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.blue[900]),
                  );
                }
                  else if(snapshot.data == "error"){
                   return new Icon(Icons.wifi_off , color: Colors.grey, size: 50,);
                 }
                else if(snapshot.data["transactions"].length == 0){
                  return new Icon(Icons.do_not_disturb , color: Colors.grey, size: 50,);

                }
                else{
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all( 22),
                    itemCount: snapshot.data["transactions"].length,

                    itemBuilder: (c,i){
                      return new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          opHolder(width, context, Operation(id: snapshot.data["transactions"][i]["id"].toString() , name: snapshot.data["transactions"][i]["desc"] , to: snapshot.data["transactions"][i]["to_agent"]["name"] , from: snapshot.data["transactions"][i]["from_agent"]["name"], buyPrice: snapshot.data["transactions"][i]["buy_value"].toString() , sellPrice: snapshot.data["transactions"][i]["sell_value"].toString() , date: snapshot.data["transactions"][i]["created_at"] , toId: snapshot.data["transactions"][i]["to_id"].toString() , fromId: snapshot.data["transactions"][i]["from_id"].toString())),
                          new Text("\n")
                        ],
                      );
                    },
                  );
                }
                }
              ,
            ),
          ),
        ),
      ),
    );
  }
}
