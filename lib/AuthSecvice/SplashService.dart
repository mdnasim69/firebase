import 'package:flutter/material.dart';
import '../UI/LoginScreen.dart';

class SplashService {
  void isLogin(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));
    Navigator.pushNamedAndRemoveUntil(
      context,
      Loginscreen.name,
      (predicate) => false,
    );
  }
}
