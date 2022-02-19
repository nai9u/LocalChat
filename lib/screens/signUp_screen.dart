// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_final_fields, unused_field, sized_box_for_whitespace, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../authentication/authentication.dart';
import 'login_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({ Key? key }) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var color1= Colors.yellow[700];
  var _formKey = GlobalKey<FormState>();
  bool _visibility = true;
  var _nameController = TextEditingController();
  var _emailController = TextEditingController();
  var _mobileController = TextEditingController();
  var _passController = TextEditingController();
  var _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    timeDilation = 2;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: color1,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Hero(
                tag: 'title',
                child: Material(
                  color: Colors.transparent,
                  child: Text('Chatting App',
                    style:TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold
                        ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Card(
                  elevation: 100,
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(height: 20,),
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            controller: _nameController,
                            validator: (value) {
                              if (value!.length>3 && RegExp(r'^[A-Za-z]').hasMatch(value)){
                                return null;
                              } else {
                                return 'Enter a valid name';
                              }
                            },
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            controller: _emailController,
                            validator: (value) {
                              if (value!.length > 5 &&
                              RegExp(
                                  r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$"
                              ).hasMatch(value)) {
                                return null;
                              }
                              else {
                                return 'Enter a valid Email';
                              }
                            },
              
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: _mobileController,
                            decoration: InputDecoration(
                              hintText: 'Mobile No.',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              )
                            ),
                            validator: (value){
                              if (value!.length<11){
                                return 'Invalid mobile no.';
                              }
                              else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            obscureText: _visibility,
                            controller: _passController,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              suffixIcon: IconButton(
                                onPressed: (){
                                  setState(() {
                                    _visibility = !_visibility;
                                  });
                                }, 
                                icon: Icon(_visibility==true? Icons.visibility:Icons.visibility_off)
                              )
                            ),
                            validator: (value){
                              if (value!.length<8){
                                return 'Your password must be at least 8 digit';
                              }
                              else{
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 30,),
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            color: color1,
                            height: 40,
                            minWidth: 150,
                            onPressed: (){
                              if(_formKey.currentState!.validate()){
                                Authenication.signUp(_emailController.text, _passController.text)
                                .then((result) {
                                  if (result == null){
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                      msg: 'Sign up complete. Please login to continue',
                                      timeInSecForIosWeb: 3
                                    );
                                    addUserData(
                                      _nameController.text,
                                      _emailController.text,
                                      _mobileController.text
                                    );
                                  }
                                  else{
                                    Fluttertoast.showToast(msg: result,timeInSecForIosWeb: 3);
                                  }
                                });
                                //   phone: _mobileController.text, 
                                //   verifyComplete: Navigator.push(
                                //     context, 
                                //     MaterialPageRoute(builder: (context)=>LogInScreen())
                                //   ), 
                                //   codeSent: (String verificationId, int resendToken){
                                //     showDialog(
                                //       context: context, 
                                //       builder: (context){
                                //         return AlertDialog(
                                //           title: Text('Enter the OTP code'),
                                //           content: Column(
                                //             children: [
                                //               TextField(
                                //                 controller: _otpController,
                                //               ),
                                //               ElevatedButton(
                                //                 onPressed: ()async{
                                //                   var smsCode = _otpController.text;
                                //                   FirebaseAuth auth = FirebaseAuth.instance;
                                //                   PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
                                //                   var result = await auth.signInWithCredential(phoneAuthCredential);
                                //                   User? user = result.user;
                                //                   if(user != null){
                                //                     Navigator.push(
                                //                       context, 
                                //                       MaterialPageRoute(builder: (context)=>LogInScreen())
                                //                     );
                                //                   }
                                //                 }, 
                                //                 child: Text('Enter')
                                //               )
                                //             ],
                                //           ),
                                //         );
                                //       }
                                //     );
                                //   }
                                // );
                              }
                            },
                            child: Text('Create Account'),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Text('Already have an account?'),
                              TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=> LogInScreen() ));
                                }, 
                                child: Text('Log in')
                              )
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
      ),
    );
  }
FirebaseFirestore firestore = FirebaseFirestore.instance;
var userName = '';
var userEmail = '';
addUserData(String name,String email,String mobile) async{
 return await firestore
 .collection('Users')
 .doc(email)
 .set({
     "Name" : name,
     'Email' : email,
     'Mobile': mobile
  });
}
}
