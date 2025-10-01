import 'package:fire/UI/LoginScreen.dart';
import 'package:fire/UI/SignUp.dart';
import 'package:fire/UI/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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
            borderSide: BorderSide(color: Colors.purple,width:1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.deepPurple,width:1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.black,width:1.5),
          ),
          fillColor:Colors.white,
          filled: true,
        ),
        primaryColor: Colors.deepPurple,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: Splashscreen.name,
      routes: {
        Splashscreen.name: (_) => Splashscreen(),
        Loginscreen.name: (_) => Loginscreen(),
        SignUpscreen.name:(_)=>SignUpscreen(),

      },
    );
  }
}
