// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({ Key? key }) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    inputData();
    getCurrentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.cyanAccent,
            height: MediaQuery.of(context).size.height * .5,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          }, 
                          icon: Icon(Icons.arrow_back_ios)
                      ),
                      Text(
                        currentUserName,
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                      ),
                      IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 80,
                  ),
                ),
              ],
            ),
          ),
          Container(
            //color: Colors.green,
            padding: EdgeInsets.all(30),
            height: MediaQuery.of(context).size.height * .5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Text(
                    'About me',
                    style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(),
                Text(
                  'Name : '+ currentUserName,
                  style: TextStyle(fontSize: 20)
                ),
                Text(
                  'Mobile : '+ currentUserNumber,
                  style: TextStyle(fontSize: 20)
                ),
                Text(
                  'Email : ' + currentEmail,
                  style: TextStyle(fontSize: 20)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
  var currentEmail = '';
  var currentUserName = '';
  var currentUserNumber = '';

  final FirebaseAuth auth = FirebaseAuth.instance;
  void inputData() {
    final User? user = auth.currentUser;
    currentEmail = user!.email.toString();
  }

 FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future getCurrentData() async{
      return await firestore
      .collection('Users')
      .doc(currentEmail)
      .get().then((snapshot) {
        setState(() {
          currentUserName = snapshot.get('Name').toString();
          currentUserNumber = snapshot.get('Mobile').toString();
        });
      });
    }
  
}

