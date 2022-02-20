// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, prefer_final_fields, unused_field, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_chat/UserInfo.dart';
import 'package:local_chat/screens/chat_list.dart';
import 'package:local_chat/screens/signUp_screen.dart';
import '../authentication/authentication.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;
  var color1 = Colors.yellow[700];
  var formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool visibility = true;
  var emailController = TextEditingController();
  var passController = TextEditingController();
  UserInformation user = UserInformation();

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 1), vsync: this);
    //animation = CurvedAnimation(parent: animationController, curve: Curves.decelerate);
    animation = ColorTween(begin: Colors.white, end: Colors.yellow[700])
        .animate(animationController);
    animationController.forward();
    animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: animation.value,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Hero(
              tag: 'title',
              child: Material(
                color: Colors.transparent,
                child: Text('Local Chat',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Card(
                elevation: 100,
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          'Log In',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Email',
                          ),
                          controller: emailController,
                          validator: (value) {
                            if (value!.length > 5 &&
                                RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                    .hasMatch(value)) {
                              return null;
                            } else {
                              return 'Enter a valid Email';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          obscureText: visibility,
                          controller: passController,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visibility = !visibility;
                                });
                              },
                              icon: Icon(visibility == true
                                  ? Icons.visibility
                                  : Icons.visibility_off)
                              )
                            ),
                          validator: (value) {
                            if (value!.length < 8) {
                              return 'Invalid password';
                            } else {
                              return null;
                            }
                          },
                        ),
                        // SizedBox(height: 30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked = value!;
                                    });
                                  },
                                ),
                                Text('Remember me'),
                              ],
                            ),
                            TextButton(
                                onPressed: () {},
                                child: Text('Forgot password?'))
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              Authenication.signIn(
                                      email: emailController.text,
                                      password: passController.text)
                                  .then((result) {
                                if (result == null) {
                                  if(isChecked){
                                    user.saveUserEmailDataToSharedPreference(emailController.text);
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChatList()
                                    )
                                  );
                                } 
                                else {
                                  Fluttertoast.showToast(
                                      msg: result, timeInSecForIosWeb: 3);
                                }
                              });
                            }
                          },
                          color: color1,
                          height: 40,
                          minWidth: 100,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Text('Log In'),
                        ),
                        SizedBox(height: 30,),
                        Row(
                          children: [
                            Text('Dont\' have an account?'),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                                },
                                child: Text('Create acccount'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }
}
