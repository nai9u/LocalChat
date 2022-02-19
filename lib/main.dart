// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:local_chat/screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
  // if(Firebase.apps.isEmpty){
   await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCZR8E0_uFwGB9k71NCT6joj0d_2vJNNRg",
        appId: "1:593137938519:android:9f01e15851ee609964b312",
        authDomain: "local-chat-a188b.firebaseapp.com",
        projectId: "local-chat-a188b",
        databaseURL: "https://{local-chat-a188b}.firebaseio.com",
        messagingSenderId: "593137938519",
      )
    ).whenComplete(() => runApp(MyApp()));
  }
    // .whenComplete(() =>   runApp(MyApp()));
    // runApp(MyApp());
  // }
  else {
    Firebase.initializeApp();
    runApp(MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}