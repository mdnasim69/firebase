import 'package:fire/UI/PostScreen.dart';
import 'package:fire/Utils/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerifyScreen extends StatefulWidget {
  static String name = "/otp";

  const OtpVerifyScreen({super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  String? verifyID;

  final TextEditingController _OtpController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  bool Loading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    verifyID = ModalRoute.of(context)!.settings.arguments as String;
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
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(15),
                    fieldHeight: 50,
                    fieldWidth: 50,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white54,
                    selectedFillColor: Colors.white,
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                    selectedColor: Colors.greenAccent,
                    activeBorderWidth: 3,
                    inactiveBorderWidth: 3,
                    selectedBorderWidth: 3.5,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  enableActiveFill: true,
                  controller: _OtpController,
                  onCompleted: (v) {},
                  appContext: context,
                ),
                SizedBox(height: 24),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: ()async{
                      Loading=true;
                      setState(() {
                      });
                      final token = PhoneAuthProvider.credential(
                        verificationId: verifyID!,
                        smsCode: _OtpController.text,
                      );
                      try {
                       await firebaseAuth.signInWithCredential(token);
                        Navigator.pushNamedAndRemoveUntil(context, PostScreen.name, (predicate)=>false);
                      } catch (e) {
                        Loading=false;
                        setState(() {
                        });
                        Utils.ShowToastMessage(e.toString());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text("Next", style: TextStyle(color: Colors.white)),
                  ),
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
    _OtpController.dispose();
  }
}

//DB:98:C9:81:D8:B8:57:EA:B0:BB:28:8C:60:E9:59:4C:3C:F7:4F:51
//DB:98:C9:81:D8:B8:57:EA:B0:BB:28:8C:60:E9:59:4C:3C:F7:4F:51
//E7:D6:DC:28:B6:E8:BD:E2:D8:C2:1D:3F:E4:EA:A6:AE:EC:BE:1D:A6:AA:E9:12:7E:F2:C5:7F:65:7B:6F:9D:C6
//E7:D6:DC:28:B6:E8:BD:E2:D8:C2:1D:3F:E4:EA:A6:AE:EC:BE:1D:A6:AA:E9:12:7E:F2:C5:7F:65:7B:6F:9D:C6