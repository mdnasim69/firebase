import 'package:fire/UI/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  static String name ="Post";
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  FirebaseAuth firebaseAuth1 = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () {
            firebaseAuth1.signOut();
            Navigator.pushNamedAndRemoveUntil(
              context,
              Loginscreen.name,
                  (predicate) => false,
            );
          },
          icon: Icon(Icons.logout,color:Colors.white,size:28,),
        ),
        SizedBox(width:10,)
      ],
        backgroundColor: Colors.deepPurple,
        title: Text("POST"),
        centerTitle: true,
      ),
    );
  }
}
