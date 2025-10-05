import 'package:fire/UI/OtpVerifyScreen.dart';
import 'package:fire/Utils/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneAuthScreen extends StatefulWidget {
  static String name = "/phone";

  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool Loading = false;

  void initState() {
    _phoneController.text = "+880";
    super.initState();
  }

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
                  controller: _phoneController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Enter your phone number';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "phone",
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 32),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: double.infinity,
                  child: Loading == false
                      ? ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              Loading = true;
                              setState(() {});
                              firebaseAuth.verifyPhoneNumber(
                                phoneNumber: _phoneController.text,
                                verificationCompleted: (v) {},
                                verificationFailed: (e) {
                                  Utils.ShowToastMessage(e.toString());
                                  Loading = false;
                                  setState(() {});
                                },
                                codeSent: (String VerifyID, int? token) {
                                  Navigator.pushNamed(
                                    context,
                                    OtpVerifyScreen.name,
                                    arguments: VerifyID,
                                  );
                                },
                                codeAutoRetrievalTimeout: (t) {
                                  Utils.ShowToastMessage(t.toString());
                                  Loading = false;
                                  setState(() {});
                                },
                              );

                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            "Next",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : Center(child: CircularProgressIndicator()),
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
        "Verify",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
      ),
      centerTitle: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _phoneController.dispose();
  }
}
