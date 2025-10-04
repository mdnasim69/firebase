import 'package:fire/UI/LoginScreen.dart';
import 'package:fire/Utils/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  static String name = "AddPost";

  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final TextEditingController _WritetController = TextEditingController();
  FirebaseAuth firebaseAuth1 = FirebaseAuth.instance;
  final firebaseDatabase = FirebaseDatabase.instance.ref('post');
  bool Loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              firebaseAuth1.signOut();
              Navigator.pushNamedAndRemoveUntil(
                context,
                Loginscreen.name,
                (predicate) => false,
              );
            },
            icon: Icon(Icons.logout, color: Colors.white, size: 28),
          ),
          SizedBox(width: 10),
        ],
        backgroundColor: Colors.deepPurple,
        title: Text("ADD YOUR POST"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 16),

               TextFormField(
                controller: _WritetController,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Enter your description';
                  }
                  return null;
                },
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: "description",
                  hintText: "what's on your mind !",
                ),
                keyboardType: TextInputType.phone,
              ),

            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: double.infinity,
              child:  Visibility(
                visible:Loading==false,
                replacement:Center(child:CircularProgressIndicator(),),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {Loading = true;});
                    String uniqueID =DateTime.now().microsecondsSinceEpoch.toString();
                    firebaseDatabase.child(uniqueID).set({
                      "Description": _WritetController.text,
                      "id": uniqueID,
                    }).then((v){
                      Utils.ShowSucessMessage("added");
                      setState(() {Loading = false;});
                    }).onError((e,m){
                      Utils.ShowToastMessage(e.toString());
                      setState(() {Loading = false;});
                    });

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Post", style: TextStyle(color: Colors.white)),
                ),
              )
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }



  @override
  void dispose() {
    _WritetController.dispose(); // TODO: implement dispose
    super.dispose();
  }
}
