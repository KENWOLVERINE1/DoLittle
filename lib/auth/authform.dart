import 'package:dolittle/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthForm extends StatefulWidget {
  const AuthForm({super.key});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  var _username = '';
  bool isLoginPage = false;

  secureauth(){
    final validity = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if(validity){
      _formkey.currentState!.save();
      submitform(_email,_password,_username);
    }
  }

  submitform(String email,String password,String username)async{
    final auth = FirebaseAuth.instance;
    UserCredential authResult;
    try{
      if(isLoginPage){
        authResult = await auth.signInWithEmailAndPassword(email: email, password: password);
      }else{
        authResult = await auth.createUserWithEmailAndPassword(email: email, password: password);
        String uid = authResult.user!.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username' : username,
          'email' :email,
          'password' :password,
        });
      }
    }
    catch(err){
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: ListView(
        padding: EdgeInsets.only(right: 20,left: 20,top: 40),
        children: [
          Container(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  if(!isLoginPage)
                  TextFormField(
                    keyboardType: TextInputType.text,
                    key : ValueKey('username'),
                    validator: (value){
                      if(value!.isEmpty){
                        return 'User Not Found';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _username = value!;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide()
                        ),
                        labelText: "Enter Your Username",
                        labelStyle: GoogleFonts.poppins(fontSize: 14)
                    ),
                  ),
                  SizedBox(height: 20,),

                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    key : ValueKey('email'),
                    validator: (value){
                      if(value!.isEmpty || !value.contains('@gmail.com')){
                        return 'Enter a valid Email Address';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _email = value!;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide()
                      ),
                        labelText: "Enter Your Email",
                      labelStyle: GoogleFonts.poppins(fontSize: 14)
                    ),
                  ),
                  SizedBox(height: 20,),

                  TextFormField(
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    key : ValueKey('password'),
                    validator: (value){
                      if(value!.isEmpty || !value.contains('@') || !value.contains('#') || !value.contains('&')){
                        return 'Enter a valid Password';
                      }
                      return null;
                    },
                    onSaved: (value){
                      _password = value!;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide()
                        ),
                        labelText: "Enter Your Password",
                        labelStyle: GoogleFonts.poppins(fontSize: 14)
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    padding: EdgeInsets.all(5),
                    width: double.infinity,
                    height: 70,
                      child: ElevatedButton(
                        child: isLoginPage? Text('Login', style: GoogleFonts.poppins(fontSize: 18,color: Colors.white))
                            :Text('Signup',style: GoogleFonts.poppins(fontSize: 18,color: Colors.white)),
                        onPressed: (){
                        secureauth();
                      },
                        style: ButtonStyle(
                          textStyle: MaterialStateProperty.all(TextStyle(color: Colors.white)),
                          backgroundColor: MaterialStateProperty.all(Color.fromRGBO(83, 58, 113, 1)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)))
                        ),
                      )
                  ),
                  SizedBox(height: 20,),
                  Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                          margin: const EdgeInsets.only(left: 60.0, right: 10.0),
                          child: Divider(
                            color: Colors.black,
                            height: 36,
                          )),
                    ),
                    Text("Or",style: GoogleFonts.poppins(fontSize: 18),),
                    Expanded(
                      child: new Container(
                          margin: const EdgeInsets.only(left: 10.0, right: 60.0),
                          child: Divider(
                            color: Colors.black,
                            height: 36,
                          )),
                    ),
                  ]),
                  Container(
                    child: TextButton(onPressed: (){
                      setState(() {
                        isLoginPage = !isLoginPage;
                      });

                    }, child: isLoginPage? Text('Not a Member? Sign Up'): Text("Returning User! Sign In")),
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
