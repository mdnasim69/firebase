import 'package:fire/UI/SignUp.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AB(),
      body: Container(
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Padding(
            padding:  EdgeInsets.all(8.0),
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
                Container(padding:EdgeInsets.symmetric(horizontal:10),
                    height: 50, width: double.infinity, child: Button()),
                SizedBox(height: 24),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account !  ",style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),),
                    GestureDetector(
                      onTap:(){Navigator.pushNamed(context, SignUpscreen.name);},
                      child: Text(
                        "SignUp",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height:80,)
              ],
            ),
          ),
        ),
      ),
    );
  }

  ElevatedButton Button() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {}
      },
      child: Text("Login", style: TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
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
}
