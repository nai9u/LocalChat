// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, use_key_in_widget_constructors, sized_box_for_whitespace
//
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:local_chat/UserInfo.dart';
import 'package:local_chat/screens/chat_list.dart';
import 'package:local_chat/screens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // final bool _isVisible = false;
  User? loggedInUser;
  bool data = false ;

  @override
  void initState() {
    super.initState();
    getData();
    Timer(Duration(milliseconds: 3000), () {
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => data == false ? LogInScreen(): ChatList(),
          ),
          (route) => false,
        );
      });
    });
  }

  getData() async{
    UserInformation info = UserInformation();
    await info.getEmail().then((value) {
      setState(() {
        data = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.yellow.shade700,
            ],
            begin: FractionalOffset(0, 0),
            end: FractionalOffset(1, 1),
            stops: [0, 1],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Text(
            'Local Chat',
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}