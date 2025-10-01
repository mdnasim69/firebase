import 'package:fire/FCM_service.dart';
import 'package:fire/cricket.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FCM_service().initalize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  // bool Loading =false;
  List<CricketMatch> match = [  ];

  // void initState() {
  //
  //   super.initState();
  //   _call();
  // }
  //
  FirebaseFirestore db = FirebaseFirestore.instance;

  // Future<void> _call ()async{
  //   Loading=true;
  //   setState(() {
  //
  //   });
  //   match.clear();
  //   QuerySnapshot<Map<String, dynamic>> snapshot= await db.collection('cricket').get();
  //   for(QueryDocumentSnapshot<Map<String,dynamic>> s in snapshot.docs){
  //     print(s.data());
  //     print(s.id.toString());
  //     match.add(CricketMatch.fromJson(s.data(),s.id));
  //   }
  //   print(match);
  //   Loading=false;
  //   setState(() {
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white, title: Text("Cricket")),
      body: StreamBuilder(
        stream: db.collection('cricket').snapshots(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (asyncSnapshot.hasError) {
            Center(child: Text(asyncSnapshot.error.toString()));
          }
          if (asyncSnapshot.hasData) {
            match.clear();
            QuerySnapshot<Map<String, dynamic>> snap = asyncSnapshot.data!;

            for (QueryDocumentSnapshot<Map<String, dynamic>> s in snap.docs) {
              match.add(CricketMatch.fromJson(s.data(), s.id));
            }
            return ListView.builder(
              itemCount: match.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 8,
                  ),
                  title: Text("Match number:${match[index].id}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Score: ${match[index].run}/${match[index].wicket}"),
                      Text("over:${match[index].over}"),
                    ],
                  ),
                );
              },
            );
          }
          return SizedBox();
        },
      ),
    );
  }
}
