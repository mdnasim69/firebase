import 'package:fire/AuthSecvice/SplashService.dart';
import 'package:fire/UI/LoginScreen.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  static String name = "/";

  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  SplashService splashService =SplashService();

  void initState(){
    super.initState();
    splashService.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text("SPLASH Screen")));
  }
}
