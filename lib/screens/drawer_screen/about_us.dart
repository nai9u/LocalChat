import 'package:flutter/material.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({ Key? key}) : super(key: key);

  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {

  @override
  Widget build(BuildContext context) {
     double screenHeight = MediaQuery.of(context).size.height;
     double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.yellow.shade700),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            const Text('LocalChat Messenger',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            const Text('Version 1.0',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black54,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            Icon(Icons.phone_in_talk,
              size: screenWidth * 0.35, color: Colors.blue,
            ),
            SizedBox(height: screenHeight * 0.03),
            const Text('©️localChat.com.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black54,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            const Text('Developers \n Nainaiu, Fahim, Jamil, Sultan, Aftab',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}