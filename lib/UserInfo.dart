import 'package:shared_preferences/shared_preferences.dart';

class UserInformation{

  final String email = "email";
  Future<void> saveUserEmailDataToSharedPreference(String email) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(this.email, email);
  }

  Future<void> deleteLogInDataToSharedPreference() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  Future<String> getEmail() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String userEmail;
    userEmail = pref.getString(email)!;
    return userEmail;
  }
}