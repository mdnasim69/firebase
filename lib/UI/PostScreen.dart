import 'package:fire/UI/AddPostScreen.dart';
import 'package:fire/UI/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  static String name = "Post";

  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  FirebaseAuth firebaseAuth1 = FirebaseAuth.instance;
  final firebaseDatabase = FirebaseDatabase.instance.ref('post');
  TextEditingController searchController = TextEditingController();
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
        title: Text("POST"),
        centerTitle: true,
      ),
      // body: FirebaseAnimatedList(
      //   query: firebaseDatabase,
      //   itemBuilder:
      //       (
      //         BuildContext context,
      //         DataSnapshot snapshot,
      //         Animation<double> animation,
      //         int index,
      //       ) {
      //         return ListTile(
      //           title: Text(snapshot.child('Description').value.toString()),
      //           subtitle: Text(snapshot.child('id').value.toString()),
      //         );
      //       },
      // ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              onChanged: (String c) {
                setState(() {});
              },
              decoration: InputDecoration(
                hintText: "Search",
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: firebaseDatabase.onValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.snapshot.children.length,
                    itemBuilder: (context, index) {
                      Map<dynamic, dynamic> map =
                          snapshot.data!.snapshot.value as dynamic;
                      List list = map.values.toList();
                      debugPrint(
                        snapshot.data?.snapshot.children.length.toString(),
                      );
                      debugPrint(map.toString());
                      String title = list[index]['Description'];
                      if (searchController.text.isEmpty) {
                        return ListTile(
                          title: Text(list[index]['Description']),
                          subtitle: Text(list[index]['id']),
                        );
                      } else if (title.toLowerCase().contains(
                        searchController.text.toLowerCase(),
                      )) {
                        return ListTile(
                          title: Text(list[index]['Description']),
                          subtitle: Text(list[index]['id']),
                        );
                      }
                      else{
                        return Container();
                      }
                    },
                  );
                }
                return SizedBox();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddPostScreen.name);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
