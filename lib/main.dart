import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project_zero/spalshScreen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  runApp(
   new MaterialApp(
     debugShowCheckedModeBanner: false,
     home: Splash(),
   )
  );
}