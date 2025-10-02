import 'package:fire/UI/LoginScreen.dart';
import 'package:fire/UI/OtpVerifyScreen.dart';
import 'package:fire/UI/PhoneAuthScreen.dart';
import 'package:fire/UI/SignUp.dart';
import 'package:fire/UI/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'UI/PostScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.purple, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.blue, width: 1),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white54, width: 1.5),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        primaryColor: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Splashscreen.name,
      routes: {
        Splashscreen.name: (_) => Splashscreen(),
        Loginscreen.name: (_) => Loginscreen(),
        SignUpscreen.name: (_) => SignUpscreen(),
        PostScreen.name: (_) => PostScreen(),
        OtpVerifyScreen.name: (_) => OtpVerifyScreen(),
        PhoneAuthScreen.name: (_) => PhoneAuthScreen(),
      },
    );
  }
}
