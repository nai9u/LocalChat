// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, use_key_in_widget_constructors, sized_box_for_whitespace


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_chat/UserInfo.dart';
import 'package:local_chat/screens/AllUser.dart';
import 'package:local_chat/screens/ChatDetails.dart';
import 'package:local_chat/screens/drawer_screen/profile_page.dart';
import 'package:local_chat/screens/login_screen.dart';
import 'drawer_screen/about_us.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}
bool darkMode = true;

class _ChatListState extends State<ChatList> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  UserInformation user = UserInformation();
  FirebaseAuth auth = FirebaseAuth.instance;
  var currentUserName = '';
  var currentEmail = '';
  var currentUserNumber = '';
  @override
  void initState() {
    super.initState();
    inputData();
    getCurrentData();
  }

  @override
  Widget build(BuildContext context) {
    var color1 = Colors.yellow[700];
    var drawerColor = darkMode == false ? Colors.yellow[700] : Colors.black;
    var drawerColor2 = darkMode == false ? Colors.black : Colors.blue;
    var color2 = darkMode == false ? Colors.white : Colors.black87;
    var textFieldColor = darkMode == false ? Colors.grey[300] : Colors.white12;
    FirebaseFirestore firestore2 = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chats'),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: color1,
      ),
      drawer: Drawer(
        elevation: 20,
        child: Column(
          children: [
            DrawerHeader(
                padding: EdgeInsets.only(bottom: 10, top: 10),
                decoration: BoxDecoration(color: drawerColor),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      CircleAvatar(
                        foregroundColor: Colors.red,
                        maxRadius: 40,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        currentUserName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: drawerColor2),
                      ),
                      Text(
                        currentEmail == "" ? "":
                        currentEmail,
                        style: TextStyle(
                            color: darkMode == false
                                ? Colors.black54
                                : Colors.white54),
                      )
                    ],
                  ),
                )),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfilePage()));
              },
              leading: Icon(Icons.person),
              title: Text(
                'My Profile',
              ),
            ),
            Divider(),
            ListTile(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AboutApp()));
              },
              leading: Icon(Icons.info),
              title: Text(
                'About us',
              ),
            ),
            Divider(),
            ListTile(
              onTap: (){
                UserInformation user = UserInformation();
                user.deleteLogInDataToSharedPreference();
                auth.signOut();
                Navigator.pushReplacement(
                  context, 
                  MaterialPageRoute(builder: (context)=>LogInScreen())
                );
              },
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
            ),
            Divider(),
            SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Row(
                children: [
                  Icon(Icons.dark_mode, size: 30, color: Colors.black54),
                  SizedBox(width: 30,),
                  Text(
                    'Dark Mode',
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Switch(
                    value: darkMode,
                    onChanged: (value) {
                      setState(() {
                        darkMode = value;
                      });
                    },
                    activeTrackColor: color1,
                    activeColor: Colors.yellow,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      key: scaffoldKey,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: color2,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey[600]),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: textFieldColor,
                    contentPadding: EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                        BorderSide(color: Colors.transparent)),
                  )
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height*0.75,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: firestore2.collection(currentEmail).orderBy('timestamp',descending: true).snapshots(),
                      builder: (context,snapshot){
                        if(snapshot.hasError){
                          return Text('Something went wrong');
                        }
                        if (!snapshot.hasData){
                          return Center(child: CircularProgressIndicator());
                        }
                        else{
                          final data = snapshot.data!.docs;
                          return Expanded(
                            child: ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context,index){
                                return ListTile(
                                  onTap: (){
                                    Navigator.push(
                                      context, 
                                      MaterialPageRoute(builder: (context)=>
                                        ChatDetails(
                                          receiverName: data[index].get("Name"),
                                          receiverEmail: data[index].get("Email"),
                                        )
                                      )
                                    );
                                  },
                                  leading: CircleAvatar(
                                    radius: 20,
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
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  
                  Positioned(
                    bottom: 40,
                    right: 40,
                    child: FloatingActionButton(
                      backgroundColor: color1,
                      child: Icon(
                        Icons.add,
                        color: color2,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context, 
                          MaterialPageRoute(builder: (context)=>AllUser())
                        );
                      },
                    ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

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
