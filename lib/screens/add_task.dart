import 'package:dolittle/screens/tasks.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController tittlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  TextEditingController starttimecontroller = TextEditingController();
  TextEditingController endtimecontroller = TextEditingController();

  addtasktofirestore() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = await auth.currentUser;
    String uid = user!.uid;
    await FirebaseFirestore.instance
        .collection('tasks')
        .doc(uid)
        .collection('mytasks')
        .doc(starttimecontroller.text)
        .set({
      'tittle': tittlecontroller.text,
      'starttime': starttimecontroller.text,
      'endtime': endtimecontroller.text,
      'description': descriptioncontroller.text
    });
    Fluttertoast.showToast(msg: "Task Added");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'New Task',
          style: GoogleFonts.poppins(fontSize: 25, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple.shade300,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: TextField(
                controller: tittlecontroller,
                decoration: InputDecoration(
                    labelText: 'Enter Task', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              child: TextField(
                controller: starttimecontroller,
                decoration: InputDecoration(
                    labelText: 'Enter Start Time',
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: TextField(
                controller: endtimecontroller,
                decoration: InputDecoration(
                    labelText: 'Enter End Time', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              child: TextField(
                controller: descriptioncontroller,
                decoration: InputDecoration(
                    labelText: 'Enter Description',
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
                width: double.infinity,
                height: 70,
                child: ElevatedButton(
                  onPressed: () {
                    addtasktofirestore();
                    Navigator.pop(
                        context, MaterialPageRoute(builder: (context) => Home()));
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(83, 58, 113, 1)),
                    padding:
                        MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                      (Set<MaterialState> states) {
                        return const EdgeInsets.all(20);
                      },
                    ),
                  ),
                  child: Text('Add Task',
                      style: GoogleFonts.poppins(
                          fontSize: 20,color:Colors.white )),
                ))
          ],
        ),
      ),
    );
  }
}
