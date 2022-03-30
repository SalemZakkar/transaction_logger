import 'package:flutter/material.dart';
import 'package:project_zero/GUI/Home/custom.dart';
import 'package:project_zero/GUI/customers/custom.dart';
import 'package:project_zero/GUI/customers/customers.dart';
import 'package:project_zero/classes/classes.dart';

class CustomerDetail extends StatefulWidget {
  Customer c;
  CustomerDetail(this.c);
  @override
  _CustomerDetailState createState() => _CustomerDetailState(c);
}

class _CustomerDetailState extends State<CustomerDetail> {
  Customer c;
  _CustomerDetailState(this.c);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    c.money = "99";
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (builder) => Customers()), (route) => false);
        return false;
      },
      child: Directionality(
        textDirection: direction,
        child: MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Scaffold(
            appBar: new AppBar(
            backgroundColor: Colors.blue[900],
              title: new Text(langData[lang]["customers"]),

              toolbarHeight: 80,
              leading: new IconButton(
                icon: Icon(Icons.arrow_back , color: Colors.white,),
                onPressed: (){
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (builder) => Customers()), (route) => false);
                },
              ),
              actions: [
                new IconButton(icon: Icon(Icons.delete), onPressed: () async{
                  var st = await c.deleteCustomer(context);
                  if(st == true){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => Customers()), (route) => false);
                  }else{
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: new Text(langData[lang]["error2"])));
                  }
                }),
              ],
            ),
            body: new Container(
              width: width,
              height: height,
              color: Colors.white,
              alignment: Alignment.center,
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: width,
                    height: 215,
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          new Text("\n" , textScaleFactor: 1,),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              cuPar(width,c.name),
                              cuPar(width, langData[lang]["type" + c.type]),
                            ],
                          ),
                          new Text("\n"),
                          new Container(
                            width: width*0.85,
                            alignment: Alignment.centerLeft,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.blue[900],
                                borderRadius: BorderRadius.circular(12.0)
                            ),
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                new SizedBox(
                                  width: width*0.1,

                                ),
                                new Text(langData[lang]["customerBalance"] , textScaleFactor: 1, style: new TextStyle(color: Colors.white),),
                                new SizedBox(
                                  width: width*0.15,
                                ),
                                FutureBuilder(
                                  future: c.getDetails(),
                                  builder: (context,snapshot){
                                    var key3 = (c.type == "1" ? "transaction_to_total" : "transaction_from_total");
                                    if(snapshot.hasData && snapshot.data !="error"){
                                      return new Text(snapshot.data["data"][key3].toString() , textScaleFactor: 1, style: new TextStyle(color: Colors.white),);
                                    }
                                    else{
                                    return new Text("N/A" , textScaleFactor: 1, style: new TextStyle(color: Colors.white),);

                                    }
                                  },
                                )

                              ],
                            )
                          ),
                          new Text("\n"),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: width,
                    height: MediaQuery.of(context).size.height-250-80,
                    color: Colors.white,
                    child: FutureBuilder(future: c.getDetails(),
                    builder: (context,snapshot){
                      var key = (c.type == "1" ? "transactions_to" : "transactions_from");
                      var key2 = (c.type =="1" ? "to_agent" : "from_agent");
                      print(c.money);
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.blue[900]),);
                      }
                      else if(snapshot.data == "error"){
                        return new Icon(Icons.wifi_off,color: Colors.grey,size: 50,);
                      }
                      else if(snapshot.data["data"][key].length == 0){
                        return new Icon(Icons.do_not_disturb , size: 50,color: Colors.grey,);
                      }
                      else{
                        return ListView.builder(
                         itemCount: snapshot.data["data"][key].length,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.all(22.0),
                          itemBuilder: (context , index){
                           if(c.type == "1"){
                             return new Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 opHolder2(width, context,
                                 Operation(
                                   date: snapshot.data["data"][key][index]["created_at"],
                                   name: snapshot.data["data"][key][index]["desc"],
                                   from: snapshot.data["data"][key][index]["from_agent"]["name"].toString(),
                                   to: c.name,
                                   fromId: snapshot.data["data"][key][index]["from_agent"]["id"].toString(),
                                   toId: c.id,
                                   id: snapshot.data["data"][key][index]["id"].toString(),
                                   sellPrice: snapshot.data["data"][key][index]["sell_value"].toString(),
                                   buyPrice: snapshot.data["data"][key][index]["buy_value"].toString(),
                                 ) , c),
                                 new Text("\n")
                               ],
                             );
                           }else{
                             return Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 opHolder2(width, context,
                                 Operation(
                                   date: snapshot.data["data"][key][index]["created_at"],
                                   name: snapshot.data["data"][key][index]["desc"],
                                   to: snapshot.data["data"][key][index]["to_agent"]["name"],
                                   from: c.name,
                                   id: snapshot.data["data"][key][index]["id"].toString(),
                                   sellPrice: snapshot.data["data"][key][index]["sell_value"].toString(),
                                   buyPrice: snapshot.data["data"][key][index]["buy_value"].toString(),
                                 ) , c),
                                 new Text("\n")
                               ],
                             );
                           }
                          },
                        );
                      }

                    },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
