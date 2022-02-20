// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_chat/screens/chat_list.dart';

class AllUser extends StatefulWidget {
  const AllUser({Key? key}) : super(key: key);

  @override
  _AllUserState createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {
  String currentEmail='';
  String currentUserName = '';
  String currentUserNumber = '';
  String receiverName = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inputData();
    getCurrentData();
  }
  @override
  Widget build(BuildContext context) {
    var color1 = Colors.yellow[700];
    darkMode == false ? Colors.black87 : Colors.yellow.shade700;
    var color2 = darkMode == false ? Colors.white : Colors.black87;
    FirebaseFirestore firestore3 = FirebaseFirestore.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chats',
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: color1),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: color2,
        height: MediaQuery.of(context).size.height,
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore3.collection('Users').where('Email',isNotEqualTo: currentEmail).snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } 
            else {
              final data = snapshot.data!.docs;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onTap: (){
                      addSender(data[index].get('Email'));
                    },
                    leading: CircleAvatar(
                      radius: 20,
                      // child: Text(currentUserName[0]),
                    ),
                    title: Text(
                      data[index].get('Name'),
                      style: TextStyle(
                          fontSize: 15,
                          color: color1,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      data[index].get('Email'),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        // fontWeight: widget.isMessageRead?FontWeight.bold:FontWeight.normal),
                      ),
                    ),
                  );
                }
              );
            }
          },
        ),
      ),
    );
  }
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  void inputData() {
    final User? user = auth.currentUser;
    currentEmail = user!.email.toString();
  }
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

// var timeformat = DateTime.now().hour.toString() + ':'+ DateTime.now().minute.toString();
// var dateformat = DateTime.now().day.toString() + '/'+ DateTime.now().month.toString()+ '/'+ DateTime.now().year.toString();
  addSender(String receiverEmail) async{
    await firestore
    .collection('Users')
    .doc(receiverEmail)
    .get().then((snapshot) {
      setState(() {
        receiverName = snapshot.get('Name').toString();
      });
    });
    await firestore
    .collection(currentEmail)
    .doc(receiverEmail).set({
      'Name': receiverName,
      'Email':receiverEmail,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
