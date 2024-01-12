import 'package:dolittle/screens/add_task.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('DoLittle',style: GoogleFonts.poppins(fontSize: 30,color: Colors.white))),backgroundColor:  Colors.deepPurple.shade300),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Color.fromRGBO(83, 58, 113, 1),
      onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTask()));
      },),
    );
  }
}
