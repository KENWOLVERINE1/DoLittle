import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dolittle/screens/add_task.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isChecked = false;
  String uid = "";

  @override
  void initState() {
    getuid();
    super.initState();
  }

  getuid() async {
    final auth = FirebaseAuth.instance;
    final User? user = await auth.currentUser;
    setState(() {
      uid = user!.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Text('DoLittle',
                  style:
                      GoogleFonts.poppins(fontSize: 30, color: Colors.white))),
          backgroundColor: Colors.deepPurple.shade300),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("tasks")
              .doc(uid)
              .collection("mytasks")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(
                  child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator()),
                ),
              );
            } else {
              final docs = snapshot.data!.docs;
              return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(index.toString()),
                      background: Container(
                        color: Colors.red,
                      ),
                      onDismissed: (direction) {
                        direction = DismissDirection.endToStart;
                        FirebaseFirestore.instance
                            .collection('tasks')
                            .doc(uid)
                            .collection('mytasks')
                            .doc(docs[index]['starttime'])
                            .delete();
                      },
                      child: InkWell(
                        onTap: () {
                          return;
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade100,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 90,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 20),
                                      child: Text(
                                        docs[index]['tittle'],
                                        style: isChecked?TextStyle(fontSize: 18,decoration: TextDecoration.lineThrough,):GoogleFonts.roboto(fontSize: 18),
                                      ))
                                ],
                              ),
                              Container(
                                child: Checkbox(
                                  value: isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      isChecked = !isChecked;
                                    });

                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color.fromRGBO(83, 58, 113, 1),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddTask()));
        },
      ),
    );
  }
}
