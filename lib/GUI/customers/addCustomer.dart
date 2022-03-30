import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_zero/classes/classes.dart';

class AddCustomer extends StatefulWidget {
  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  bool isChoosen = false;
  String type;
  var controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: direction,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[900],
            title: new Text(langData[lang]["customers"]),
            toolbarHeight: 100,
          ),
          body: new Container(
            width: width,
            height: height,
            alignment: Alignment.center,
            color: Colors.white,
            child: new SingleChildScrollView(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: width,
                    height: 50,
                    color: Colors.transparent,
                  ),
                  new Container(
                    width: width*0.7,
                    child: new Image.asset("assets/newCustomer.jpg"),
                  ),
                  new SizedBox(height: 100,),
                  new Container(
                    alignment: Alignment.center,
                    width: width*0.9,
                    child: new TextField(
                      controller: controller,
                    textDirection: TextDirection.ltr,
                    decoration: InputDecoration(
                      labelText: langData[lang]["cname"],
                      labelStyle: new TextStyle(color: Colors.blue[900]),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue[900],
                        )
                      )
                    ),
                    ),
                  ),
                  new Text("\n",textScaleFactor: 1,),
                  new Container(
                    width: width*0.9,
                    height: 50,
                    child: new ElevatedButton(onPressed: (){
                      showDialog(context: context, builder:(context){
                        return AlertDialog(
                          backgroundColor: Colors.white,
              //            title: new Text("Customer Type" , textScaleFactor: 1,),
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
                                      type = "1";
                                      isChoosen = true;
                                      FocusScope.of(context).unfocus();
                                      Navigator.pop(context);

                                      },
                                      color: Colors.green,
                                      child: new Text(langData[lang]["type1"] , textScaleFactor: 1,style: new TextStyle(color: Colors.white),),
                                    ),
                                  ),
                                  new Text("\n" , textScaleFactor: 1,),
                                  new SizedBox(
                                    width: width*0.7,
                                    height: 80,
                                    // ignore: deprecated_member_use
                                    child: new RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(22.0),

                                      ),
                                      onPressed: (){
                                        type = "2";
                                        isChoosen = true;
                                        FocusScope.of(context).unfocus();
                                        Navigator.pop(context);
                                      },
                                      color: Colors.green,
                                      child: new Text(langData[lang]["type2"] , textScaleFactor: 1,style: new TextStyle(color: Colors.white),),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      } );
                    }, child: new Text(langData[lang]["ctype"]),
                      style: new ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.blue[900])
                      ),
                    ),
                  ),
                  Container(
                  alignment: Alignment.center,
                    width: width,
                    height: height*0.2,
                    color: Colors.transparent,
                  )
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue[900],
            child: new Icon(Icons.add),
            onPressed: () async{
              print(token);
              FocusScope.of(context).unfocus();
              if((controller.text.contains(RegExp("[A-z]")) || controller.text.contains(RegExp("[أ-ي]"))) && isChoosen == true){
              await Customer(name: controller.text , type: type).addCustomer(context);
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
