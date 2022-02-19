import 'package:firebase_auth/firebase_auth.dart';

class Authenication{
  static Future signUp(String email, String password) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try{
      final user = await auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      return null;
    }
    on FirebaseException catch(e){
      return e.message;
    }
  }

  static Future signIn({required String email,required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try{
      final user = await auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      return null;
    }
    on FirebaseException catch(e){
      return e.message;
    }
  }

  static Future signOut() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try{
      final user = await auth.signOut();
      return null;
    }
    on FirebaseException catch(e){
      return e.message;
    }
  }
}