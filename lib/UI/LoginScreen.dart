import 'package:fire/UI/ForgotPasswordScreen.dart';
import 'package:fire/UI/PhoneAuthScreen.dart';
import 'package:fire/UI/PostScreen.dart';
import 'package:fire/UI/SignUp.dart';
import 'package:fire/Utils/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Loginscreen extends StatefulWidget {
  static String name = "/Login";

  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  bool Loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AB(),
      body: Container(
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 18),
                  TextFormField(
                    controller: _emailController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter your email address';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.email_outlined),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 24),
                  TextFormField(
                    controller: _passwordController,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      labelText: 'Password',
                    ),
                    obscureText: true,
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 48),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    width: double.infinity,
                    child: Loading == false
                        ? Button()
                        : Center(child: CircularProgressIndicator()),
                  ),
                  SizedBox(height:8,),
                  Align(alignment:Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, ForgotPasswordScreen.name);
                      },
                      child: Text(
                        "Forgot password   ",
                        style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 48),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have account !  ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpscreen.name);
                        },
                        child: Text(
                          "SignUp",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
            
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey)),
                      Text("   Or   "),
                      Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                    ],
                  ),
                  SizedBox(height: 24),
                  GestureDetector(
                    onTap:(){
                      Navigator.pushNamed(context, PhoneAuthScreen.name);
                    },
                    child: Container(
                      alignment:Alignment.center,
                      width: double.maxFinite,
                      height:55,
                      decoration:BoxDecoration(
                        borderRadius:BorderRadius.circular(16),
                        border:Border.all(color:Colors.black,width:1),
                      ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.phone),
                          SizedBox(width:16,),
                          Text("Login with Phone"),
                          SizedBox(width:16,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton Button() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Loading = true;
          setState(() {});
          firebaseAuth
              .signInWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text,
              )
              .then((value) {
                Loading = false;
                setState(() {});
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  PostScreen.name,
                  (predicate) => false,
                );
                Utils.ShowSucessMessage("Login success");
              })
              .onError((error, m) {
                Loading = false;
                setState(() {});
                Utils.ShowToastMessage(error.toString());
              });
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text("Login", style: TextStyle(color: Colors.white)),
    );
  }

  AppBar AB() {
    return AppBar(
      toolbarHeight: 60,
      backgroundColor: Colors.deepPurple,
      title: Text(
        "LOGIN",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
}
