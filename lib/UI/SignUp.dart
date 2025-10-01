import 'package:fire/Utils/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpscreen extends StatefulWidget {
  static String name = "/Signup";

  const SignUpscreen({super.key});

  @override
  State<SignUpscreen> createState() => _SignUpscreenState();
}

class _SignUpscreenState extends State<SignUpscreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
 bool Loading =false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AB(),
      body: Container(
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16),
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
                SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter your password';
                    }
                    if(value.length<6){
                      return 'Your password must be at least 6 characters.';
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
                SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: double.infinity,
                  child: Visibility(
                    visible:Loading==false,
                      replacement:Center(child:CircularProgressIndicator(),),
                      child: ElevatedButton(
                        onPressed: (){
                          if (_formKey.currentState!.validate()) {
                            Loading=true;
                            setState(() {
                            });
                            firebaseAuth
                                .createUserWithEmailAndPassword(
                              email: _emailController.text.trim(),
                              password: _passwordController.text,
                            )
                                .then((value) {
                              Utils.ShowSucessMessage("Registration successful");
                            })
                                .onError((error, stackTrace) {
                              Utils.ShowToastMessage(error.toString());
                            });
                            Loading=false;
                            setState(() {
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Text("Sign Up", style: TextStyle(color: Colors.white)),
                      )),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have account !  ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "SignIn",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar AB() {
    return AppBar(
      automaticallyImplyLeading: true,
      toolbarHeight: 60,
      backgroundColor: Colors.deepPurple,
      title: Text(
        "Sign Up",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
    );
  }
}
