import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart' as inn;
import 'package:project_zero/GUI/customers/custom.dart';
import 'package:project_zero/classes/classes.dart';

class DataViewer extends StatefulWidget {
  Operation o;
  bool x;
  int id;
  Customer customer;
  DataViewer(this.o , this.x , this.id , this.customer);
  @override
  _AddOperationState createState() => _AddOperationState(o , x , id , customer);
}

class _AddOperationState extends State<DataViewer> {
  Operation o;
  Customer customer;
  bool x;
  int id;
  _AddOperationState(this.o,this.x , this.id , this.customer);
  String from = " ";
  String to = " ";
  String t,f;
  var controller = TextEditingController();
  var controller2 = TextEditingController();
  var controller3 = TextEditingController();
  bool one = false;
  bool two = false;
  bool three = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    from = o.from;
    to = o.to;
    t = o.toId;
    f = o.fromId;
    controller = TextEditingController(text: o.name);
    controller2 = TextEditingController(text: o.sellPrice);
    controller3 = TextEditingController(text: o.buyPrice);
  }
  @override
  Widget build(BuildContext context) {
    String date = inn.DateFormat("yyyy-MM-dd").format(DateTime.parse(o.date));

    Widget customerHolder(var width , var context , Customer c){
      return new Container(
        width: width*0.9,
        height: 100,
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
            title: new Text(langData[lang]["operations"]),
            centerTitle: true,
            actions: [
              new IconButton(icon: Icon(Icons.delete), onPressed: () async {
                if(x){
                  await o.deleteOp2(context, customer);
                }else{
                  await o.deleteOp(context);
                }
              })
            ],
          ),
          body: new Container(
            width: width,
            height: height,
            alignment: Alignment.topCenter,
            color: Color.fromRGBO(4,160,128, 1),
            child: new SingleChildScrollView(
              physics: BouncingScrollPhysics(

              ),
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  new SizedBox(
                    height: 30,
                  ),
                  new Container(
                    width: width*0.9,
                    alignment: Alignment.center,
                    child: new TextField(
                      controller: controller,
                      textDirection: TextDirection.ltr,
                      maxLines: 15,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: (BorderSide(color: Colors.white)),

                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: (BorderSide(color: Colors.white))),
                        enabledBorder: OutlineInputBorder(
                          borderSide: (BorderSide(color: Colors.white))),
                        labelText: langData[lang]["operationName"],
                        labelStyle: new TextStyle(color: Colors.white),
                      ),
                      cursorColor: Colors.white,
                      style: new TextStyle(
                          color: Colors.white
                      ),
                    ),

                  ),
                  new SizedBox(height: height*0.1,),
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
                                              new Text("\n",textScaleFactor: 1,)
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
                                              new Text("\n",textScaleFactor: 1,)
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
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.green),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)))
                      ),
                      child: new Text(date),
                    ),
                  ),

                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            child: new Icon(Icons.save),
            onPressed: () async {
              FocusScope.of(context).unfocus();
//            print(token);
                if((controller.text.contains(RegExp("[A-z]")) || controller.text.contains(RegExp("[أ-ي]"))) && moneyChecker(controller2.text) && moneyChecker(controller3.text)){
                await Operation(name: controller.text , date: date , sellPrice: controller2.text , buyPrice: controller3.text , from: f , to: t ,id: o.id ).updateOperation(context);
            }else{
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(langData[lang]["error4"])));
                }
                },
          ),
        ),
      ),
    );
  }
}
