import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:project_zero/GUI/Home/addOperation.dart';
import 'package:project_zero/GUI/Home/custom.dart';
import 'package:project_zero/GUI/Home/myAccount.dart';
import 'package:project_zero/GUI/Settings.dart';
import 'package:project_zero/GUI/customers/customers.dart';
import 'package:project_zero/classes/classes.dart';

class HomeDate extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}
class _HomeState extends State<HomeDate> {
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
          appBar: new AppBar(
            backgroundColor: Colors.blue[900],
            toolbarHeight: 80,
            title: new Text(langData[lang]["operations"]),
            // centerTitle: true,
            //       leading: new IconButton(icon: Icon(Icons.settings), onPressed: (){
            //        Navigator.push(context, MaterialPageRoute(builder: (context) => Settings()));
            actions: [
//          new   IconButton(icon: Icon(Icons.person), onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (builder) => Customers()))),
              new IconButton(icon: Icon(Icons.date_range), onPressed: (){
                DatePicker.showDatePicker(context,maxTime: DateTime.now(),minTime: DateTime(2000,1,1),onConfirm: (date){
                  setState(() {
                    this.date = DateFormat("yyyy-MM-dd").format(date);
                  });
                },theme: DatePickerTheme(
                  backgroundColor: Colors.white,
                ));
              }),
            ],
          ),
          backgroundColor: Colors.white,
          body: new Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            child: FutureBuilder(
              future: Operation.getOperation(context,date),
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
