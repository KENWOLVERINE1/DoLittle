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
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(child: const TextField(
              decoration: InputDecoration(labelText: 'Enter Task',border: OutlineInputBorder()),
            ),
            ),
            const SizedBox(height: 10,),
            Container(child: const TextField(
              decoration: InputDecoration(labelText: 'Enter Description',border: OutlineInputBorder()),
            ),
            ),
            Container(
                width: double.infinity,
               height: 40,
               child: ElevatedButton(onPressed: (){}, style: ButtonStyle(backgroundColor: MaterialStateProperty.all(const Color.fromRGBO(83, 58, 113, 1)),padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry>(
                     (Set<MaterialState> states) {
                   return const EdgeInsets.all(45);
                 },
               ),),
               child: Text('Add Task',style: GoogleFonts.poppins(fontSize: 20,color: Colors.white)),))
          ],
        ),
      ),
    );
  }
}
