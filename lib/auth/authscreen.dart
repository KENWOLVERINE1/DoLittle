import 'package:dolittle/auth/authform.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center
          (child: Text('Authetication',style: GoogleFonts.lato(fontSize: 30,fontWeight: FontWeight.w700,color: Colors.white)),
      ),
        backgroundColor:  Colors.deepPurple.shade300
        // Color.fromRGBO(224, 216, 232, 1)
        // Color.fromRGBO(253, 244, 220, 1),
      ),
      body: AuthForm(),
    );
  }
}
