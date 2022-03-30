import 'package:flutter/material.dart';
import 'package:project_zero/GUI/Home/home.dart';
import 'package:project_zero/GUI/customers/addCustomer.dart';
import 'package:project_zero/GUI/customers/custom.dart';
import 'package:project_zero/classes/classes.dart';
 class Customers extends StatefulWidget {
   @override
   _CustomersState createState() => _CustomersState();
 }
var controller ;
 class _CustomersState extends State<Customers> with TickerProviderStateMixin {

   @override
   Widget build(BuildContext context) {
     controller = TabController(length: 2, vsync: this);
     final width = MediaQuery.of(context).size.width;
     final height = MediaQuery.of(context).size.height;
     return WillPopScope(
       onWillPop: () async {
         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (builder) => Home()), (route) => false);
         return false;
       },
       child: Directionality(
         textDirection: direction,
         child: MediaQuery(
           data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
           child: new Scaffold(
             appBar: new AppBar(
               backgroundColor: Colors.blue[900],
               title: new Text(langData[lang]["customers"]),
               leading: new IconButton(icon: Icon(Icons.home_rounded), onPressed: (){Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => Home()) , (route) => false);}),
               actions: [
                 new IconButton(icon: Icon(Icons.add), onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context) => AddCustomer()));
                 })
               ],
               centerTitle: true,
               toolbarHeight: 150,
               bottom: TabBar(
                 controller: controller,
                 tabs: [
                   Tab(child: new Text(langData[lang]["type1"]),),
                   Tab(child: new Text(langData[lang]["type2"]),)
                 ],
               ),
             ),
             body: TabBarView(
               physics: NeverScrollableScrollPhysics(),
               controller: controller,
               children: [
                 new Container(
                   width: width,
                   height: height,
                   alignment: Alignment.center,
                   color: Colors.white,
                   child: FutureBuilder(
                     future: Customer.getCustomer("1"),
                     builder: (context,snapshot){
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
                           valueColor: AlwaysStoppedAnimation(Colors.blue[900]),
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
                   )
             ),


                 new Container(
                   width: width,
                   height: height,
                   alignment: Alignment.center,
                   color: Colors.white,
                   child: FutureBuilder(
                     future: Customer.getCustomer("2"),
                     builder: (context,snapshot){
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
                           valueColor: AlwaysStoppedAnimation(Colors.blue[900]),
                         );
                       }else if(snapshot.data["data"].length == 0){
                         return new Icon(Icons.do_not_disturb , size: 50, color: Colors.grey,);
                       }

                       else{
                         return ListView.builder(itemBuilder: (context,indes){
                           return new Column(mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               customerHolder(width, context, Customer(type: snapshot.data["data"][indes]["type"] , name: snapshot.data["data"][indes]["name"] , id: snapshot.data["data"][indes]["id"].toString() , )),
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
               ],
             ),
             floatingActionButton: FloatingActionButton(
               backgroundColor: Colors.blue[900],
               child: new Icon(Icons.refresh),
               onPressed: (){
                 setState(() {

                 });
               },
             ),
           ),
         )
       ),
     );
   }
 }
