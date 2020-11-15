

// import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/screen/home.dart';

import 'package:project/screen/signup_screen.dart';

  String errorMessage;

class LoginPage extends StatelessWidget {
TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
bool isEditing=false;
bool textFieldVisibility = false;



// final FirebaseAuth _auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
          Icons.arrow_back_ios, size: 20, color: Colors.black,)),
      ),
      body: Container(
        
       height: MediaQuery.of(context).size.height,
       width: double.infinity,
       child: Column(
         
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: <Widget>[
           Expanded(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 Column(
                   children: <Widget>[
                     Text("Login",style: TextStyle(
                     fontSize: 30,
                     fontWeight: FontWeight.bold,
                 ),),
                 SizedBox(height: 15,),
                 Text("Login to your account",style: TextStyle(
                     fontSize: 15,
                     color: Colors.grey,
                 ),),
                   ],
                     
                 ),
                 Padding(
                   padding: EdgeInsets.symmetric(horizontal: 40),
                 child: Column(
                   children: <Widget>[
                    makeInput1(label: "Email"),
                   
                    makeInput2(label: "Password", obscureText: true),
                   ],
                 ),
                 ),
                 Padding(padding: EdgeInsets.symmetric(horizontal: 40),
                 child: Container(
                    padding: EdgeInsets.only(top: 3,left: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top : BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          )
                        ),

                      child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async{
                                 Firebase.initializeApp();
    try {
  UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: _emailController.text,
    password: _passwordController.text,

                              // Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage())),

    
  );
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
} on FirebaseAuthException catch (e) {
  if (e.code == 'user-not-found') {
    // print('No user found for that email.');
                             Fluttertoast.showToast(
                              msg: 'No user found for that email.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white);
  } else if (e.code == 'wrong-password') {
    // print('Wrong password provided for that user.');
     Fluttertoast.showToast(
                              msg: 'Wrong password provided for that user..',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white);
    
  }
}
                            

                      },
                      color: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                      
                        borderRadius: BorderRadius.circular(50),


                      ),
                      child: Text("Login",style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18
                      ),),),
                 ),
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Text("Don't have an account"),
                     new InkWell(
                       onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));

                       },
                       child: Text("Sign Up", style: 
                        TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18
                        ),
                        
                        ),
                     ),
                   ],
                 )
               ],
             ),
           ),
              Container(
                height: MediaQuery.of(context).size.height/4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image:AssetImage("assets/images/background.png"),  
                    fit: BoxFit.fill
                  )
                ),
              )
         ],
         ),
      ),
    );

  void signInWithEmailAndPassword() async {

  }

  }


  Widget makeInput1({label, obscureText = false}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),),
        SizedBox(height: 5,),
        TextField(
          controller: _emailController,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400])
            ),
             border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400])
            ),
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }

  Widget makeInput2({label, obscureText = false}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),),
        SizedBox(height: 5,),
        TextField(
          controller: _passwordController,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400])
            ),
             border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[400])
            ),
          ),
        ),
        SizedBox(height: 30,),
      ],
    );
  }


}



