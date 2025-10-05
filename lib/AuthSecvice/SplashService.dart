import 'package:fire/UI/PostScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../UI/LoginScreen.dart';

class SplashService {
  FirebaseAuth auth =FirebaseAuth.instance;
  void isLogin(BuildContext context) async {
    final user =auth.currentUser;
    await Future.delayed(Duration(seconds: 3));
    if(user!=null){
      Navigator.pushNamedAndRemoveUntil(
        context,
        PostScreen.name,
            (predicate) => false,
      );
    }
    else{
      Navigator.pushNamedAndRemoveUntil(
        context,
        Loginscreen.name,
            (predicate) => false,
      );
    }
  }
}
