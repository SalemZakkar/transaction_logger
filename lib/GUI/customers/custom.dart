import 'package:flutter/material.dart';
import 'package:project_zero/GUI/customers/customerDetails.dart';
import 'package:project_zero/classes/classes.dart';
Widget customerHolder(var width , var context , Customer c){
  return new Container(
    width: width*0.9,
    height: 120,
    child: new ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color.fromRGBO(134,195,73, 1)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)))
      ),
      onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (builder) => CustomerDetail(c)));
      },
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new Text(c.name , textScaleFactor: 1,),
        ],
      ),

    ),
  );
}
Widget cuPar(var width,String o){
  return new Container(
      width: width*0.4,
      height: 100,
      decoration: BoxDecoration(
          color: Color.fromRGBO(134,195,73, 1),
          borderRadius: BorderRadius.circular(22.0)
      ),
      alignment: Alignment.center,

      child: new Text(o , textScaleFactor: 1, style: new TextStyle(color: Colors.white , fontSize: 14),)
  );
}