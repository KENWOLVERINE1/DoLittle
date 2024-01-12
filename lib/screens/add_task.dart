import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Task',style: GoogleFonts.poppins(fontSize: 25,color: Colors.white),),backgroundColor: Colors.deepPurple.shade300,),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(child: TextField(
              decoration: InputDecoration(labelText: 'Enter Task',border: OutlineInputBorder()),
            ),
            ),
            SizedBox(height: 10,),
            Container(child: TextField(
              decoration: InputDecoration(labelText: 'Enter Description',border: OutlineInputBorder()),
            ),
            )
          ],
        ),
      ),
    );
  }
}
