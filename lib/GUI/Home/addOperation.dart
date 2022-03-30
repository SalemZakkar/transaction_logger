import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart' as inn;
import 'package:project_zero/GUI/customers/custom.dart';
import 'package:project_zero/classes/classes.dart';

class AddOperation extends StatefulWidget {
  @override
  _AddOperationState createState() => _AddOperationState();
}

class _AddOperationState extends State<AddOperation> {
  String from = " ";
  String to = " ";
  String t = "" , f = "";
  var controller = TextEditingController();
  var controller2 = TextEditingController();
  var controller3 = TextEditingController();
  bool one = false;
  bool two = false;
  bool three = false;
  String date = inn.DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    print(date);
    Widget customerHolder(var width , var context , Customer c){
      return new Container(
        width: width,
        height: 90,
        child: new ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color.fromRGBO(134,195,73, 1)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)))
          ),
          onPressed: (){
            setState(() {
              if(c.type == "2"){
                from = c.name;
                one = true;
                f = c.id;
                Navigator.pop(context);
              }
              else{
                to = c.name;
                two = true;
                t = c.id;
                Navigator.pop(context);
              }
            });

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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: direction,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: new Scaffold(
          appBar: new AppBar(
            backgroundColor: Colors.green,
            toolbarHeight: 80,
            title: new Text(langData[lang]["addOperation"]),
            centerTitle: true,
          ),
          body: new Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            color: Color.fromRGBO(4,160,128, 1),
            child: new SingleChildScrollView(
              physics: BouncingScrollPhysics(

              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                new SizedBox(
                  height: 40,
                ),
                  new Container(
                    width: width*0.65,
                    alignment: Alignment.center,
                    child: new Image.asset("assets/newItem.jpg"),
                  ),
                  new Container(
                    width: width*0.9,
                    alignment: Alignment.center,
                    child: new TextField(
                      controller: controller,
                      textDirection: TextDirection.ltr,
                      maxLines: 5,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: (BorderSide(color: Colors.white))
                        ),
                        labelText: langData[lang]["operationName"],
                        labelStyle: new TextStyle(color: Colors.white),
                      ),
                      cursorColor: Colors.white,
                      style: new TextStyle(
                        color: Colors.white
                      ),
                    ),

                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      new Container(
                        width: width*0.4,
                        alignment: Alignment.center,
                        child: new TextField(
                          keyboardType: TextInputType.number,
                          textDirection: TextDirection.ltr,
                          controller: controller2,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: (BorderSide(color: Colors.white))
                            ),
                            labelText: langData[lang]["sell"],
                            labelStyle: new TextStyle(color: Colors.white),
                          ),
                          cursorColor: Colors.white,
                          style: new TextStyle(
                              color: Colors.white
                          ),
                        ),

                      ), new Container(
                        width: width*0.4,
                        alignment: Alignment.center,
                        child: new TextField(
                          keyboardType: TextInputType.number,
                          textDirection: TextDirection.ltr,
                          controller: controller3,
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                                borderSide: (BorderSide(color: Colors.white))
                            ),
                            labelText: langData[lang]["buy"],
                            labelStyle: new TextStyle(color: Colors.white),
                          ),
                          cursorColor: Colors.white,
                          style: new TextStyle(
                              color: Colors.white
                          ),
                        ),

                      ),
                    ],
                  ),
                  new Text("\n",textScaleFactor: 1,),
                  new Container(
                    width: width*0.9,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                        FocusScope.of(context).unfocus();
                        showDialog(context: context,
                            barrierDismissible: false,
                            builder: (context){
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                contentPadding: EdgeInsets.all(10),
                                title: new Text("Choose Customer"),
                                content: new Container(
                                  width: width*0.8,
                                  height: 300,
                                  alignment: Alignment.center,
                                  child: FutureBuilder(
                                    future: Customer.getCustomer("2"),
                                    builder: (context,snapshot){
                                      print(snapshot.data);
                                      if(snapshot.data == "error"){
                                        return new Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            new Icon(Icons.wifi_off , size: 50,color: Colors.grey,),
                                            new Text(langData[lang]["error2"])
                                          ],
                                        );
                                      }
                                      else if(snapshot.connectionState == ConnectionState.waiting){
                                        return CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(Colors.green),
                                        );
                                      }else if(snapshot.data["data"].length == 0){
                                        return new Icon(Icons.do_not_disturb , size: 50, color: Colors.grey,);
                                      }
                                      else{
                                        return ListView.builder(itemBuilder: (context,indes){
                                          return new Column(mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              customerHolder(width, context, Customer(type: snapshot.data["data"][indes]["type"] , name: snapshot.data["data"][indes]["name"] , id: snapshot.data["data"][indes]["id"].toString())),
                                              new Text("\n",textScaleFactor: 0.5,)
                                            ],
                                          );
                                        }
                                          ,itemCount: snapshot.data["data"].length,
                                          physics: BouncingScrollPhysics(),
                                          padding: EdgeInsets.all(22.0),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              );
                            }
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)))
                      ),
                      child: new Text(langData[lang]["from"]+ " -> " + from),
                    ),
                  ),
                  new Text("\n",textScaleFactor: 1,),
                  new Container(
                    width: width*0.9,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                        FocusScope.of(context).unfocus();
                        showDialog(context: context,
                            barrierDismissible: false,
                            
                            builder: (context){
                              return AlertDialog(
                                contentPadding: EdgeInsets.all(10),
                                backgroundColor: Colors.white,
                                title: new Text("Choose Customer"),
                                content: new Container(
                                  width: width*0.8,
                                  height: 300,
                                  alignment: Alignment.center,
                                  child: FutureBuilder(
                                    future: Customer.getCustomer("1"),
                                    builder: (context,snapshot){
                                      print(snapshot.data);
                                      if(snapshot.data == "error"){
                                        return new Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            new Icon(Icons.wifi_off , size: 50,color: Colors.grey,),
                                            new Text(langData[lang]["error2"])
                                          ],
                                        );
                                      }
                                      else if(snapshot.connectionState == ConnectionState.waiting){
                                        return CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation(Colors.green),
                                        );
                                      }else if(snapshot.data["data"].length == 0){
                                        return new Icon(Icons.do_not_disturb , size: 50, color: Colors.grey,);
                                      }

                                      else{
                                        return ListView.builder(itemBuilder: (context,indes){
                                          return new Column(mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              customerHolder(width, context, Customer(type: snapshot.data["data"][indes]["type"] , name: snapshot.data["data"][indes]["name"] , id: snapshot.data["data"][indes]["id"].toString())),
                                              new Text("\n",textScaleFactor: 0.5,)
                                            ],
                                          );
                                        }
                                          ,itemCount: snapshot.data["data"].length,
                                          physics: BouncingScrollPhysics(),
                                          padding: EdgeInsets.all(22.0),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              );
                            }
                        );
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.green),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)))
                      ),
                      child: new Text(langData[lang]["to"] + " -> " + to),
                    ),
                  ),
                  new Text("\n",textScaleFactor: 1,),
                  new Container(
                    width: width*0.9,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: (){
                        showDialog(context: context,
                        barrierDismissible: false,
                        builder: (context){
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            title: new Text("Pick Date"),
                            content: new Container(
                              width: width*0.8,
                              height: 300,
                              alignment: Alignment.center,
                              child: new SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    new SizedBox(
                                      width: width*0.7,
                                      height: 80,
                                      // ignore: deprecated_member_use
                                      child: new RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(22.0),
                                        ),
                                        onPressed: (){
                                          date = inn.DateFormat("yyyy-MM-dd hh:mm:ss").format(DateTime.now());
                                          print(date);
                                              Navigator.pop(context);
                                        },
                                        color: Colors.green,
                                        child: new Text(langData[lang]["today"] , textScaleFactor: 1,style: new TextStyle(color: Colors.white),),
                                      ),
                                    ),
                                    new Text("\n",textScaleFactor: 1,),

                                    new SizedBox(
                                      width: width*0.7,
                                      height: 80,
                                      // ignore: deprecated_member_use
                                      child: new RaisedButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(22.0),

                                        ),
                                        onPressed: (){
                                          DatePicker.showDatePicker(context,minTime: DateTime(2000,1,1) , maxTime: DateTime.now() , onConfirm: (date){
                                            this.date = inn.DateFormat("yyyy-MM-dd hh:mm:ss").format(date);
                                            print(this.date);
                                            Navigator.pop(context);
                                          });
                                        },
                                        color: Colors.green,
                                        child: new Text(langData[lang]["chooseDate"] , textScaleFactor: 1,style: new TextStyle(color: Colors.white),),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        );
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.green),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)))
                      ),
                      child: new Text("Date"),
                    ),
                  ),

                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            child: new Icon(Icons.add),
            onPressed: () async {
              FocusScope.of(context).unfocus();
            if(one&&two &&controller.text.isNotEmpty && (controller.text.contains(RegExp("[أ-ي]")) || controller.text.contains(RegExp("[A-z]")))  && moneyChecker(controller2.text) && moneyChecker(controller3.text)) {
              print(f + " " + t);
              await Operation(name: controller.text , date: date , sellPrice: controller2.text , buyPrice: controller3.text , fromId: f , toId: t ).addOperation(context);
              print(token);
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(langData[lang]["error4"])));
            }
            },
          ),
        ),
      ),
    );
  }
}
