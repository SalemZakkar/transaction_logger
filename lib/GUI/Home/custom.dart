import 'package:flutter/material.dart';
import 'package:project_zero/GUI/Home/dataViewer.dart';
import 'package:project_zero/classes/classes.dart';

Widget opHolder(var width , var context , Operation o){
  var temp = DateTime.parse(o.date);
  String date = temp.year.toString() + "-" + temp.month.toString() + "-" + temp.day.toString();
  return new Container(
    width: width*0.9,
    height: 120,
    child: new ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color.fromRGBO(134,195,73, 1)),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)))
      ),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (builder) => DataViewer (o , false , 0 , Customer())));
      },
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Text(o.name , textScaleFactor: 1,),
          new Text("\n" , textScaleFactor: 1,),
          new Text(date , textScaleFactor: 1,)
        ],
      ),

    ),
  );
}
Widget opHolder2(var width , var context , Operation o , Customer c){
  var temp = DateTime.parse(o.date);
  String date = temp.year.toString() + "-" + temp.month.toString() + "-" + temp.day.toString();
  return new Container(
    width: width*0.9,
    height: 120,
    child: new ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color.fromRGBO(134,195,73, 1)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)))
      ),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (builder) => DataViewer(o , true , int.parse(c.id) , c)));
      },
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Text(o.name , textScaleFactor: 1,),
          new Text("\n" , textScaleFactor: 1,),
          new Text(date , textScaleFactor: 1,)
        ],
      ),

    ),
  );
}
Widget opPar(var width,String o,var k){
  return new Container(
    width: width*0.9,
    height: 100,
    decoration: BoxDecoration(
      color: Color.fromRGBO(134,195,73, 1),
      borderRadius: BorderRadius.circular(22.0)
    ),
    alignment: Alignment.center,
    
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        new Container(
          width: width*0.3,
          alignment: Alignment.center,
          child: new Text(k,textScaleFactor: 1,style: new TextStyle(color: Colors.white),),
        ),
        new Container(
          width: width*0.35,
          alignment: Alignment.center,
          child: new Text(o,textScaleFactor: 1,style: new TextStyle(color: Colors.white),),
        )
              ],
    )
  );
}