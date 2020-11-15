

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/screen/home.dart';
import 'package:project/screen/login_screen.dart';


  enum authProblems { UserNotFound, PasswordNotValid, NetworkError }

class SignupPage extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
    String errorMessage;

  

TextEditingController _emailController = TextEditingController();
TextEditingController _passwordController = TextEditingController();
TextEditingController _cPasswordController = TextEditingController();

// final FirebaseAuth _auth = FirebaseAuth.instance;

// final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

bool _success;
String _userEmail;

  @override
  Widget build(BuildContext context) {
    // WidgetsFlutterBinding.ensureInitialized();

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
                     Text("Sign Up",style: TextStyle(
                     fontSize: 30,
                     fontWeight: FontWeight.bold,
                 ),),
                 SizedBox(height: 15,),
                 Text("SignUp to your account",style: TextStyle(
                     fontSize: 15,
                     color: Colors.grey,
                 ),),
                   ],
                     
                 ),
                 Padding(
                   padding: EdgeInsets.symmetric(horizontal: 40),
                 child: Column(
                   children: <Widget>[
                    makeInput(label: "Email"),
                    makeInput1(label: "Password", obscureText: true,),
                    makeInput3(label: "Confirm Password", obscureText: true,),

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
                      onPressed: () async  {
                                                        //  Firebase.initializeApp();

                                                                    Firebase.initializeApp();

   if (_passwordController.text == _cPasswordController.text && _passwordController.text != '' && _emailController.text != '') {
  //    final FirebaseUser user = (await 
  //     _auth.createUserWithEmailAndPassword(
  //       email: _emailController.text,
  //       password: _passwordController.text,
  //     )
  // ).user;

      try {
  UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: _emailController.text,
    password: _passwordController.text,

                              // Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage())),

    
  );
  Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
} on FirebaseAuthException catch (error) {
  switch (error.code) {
      case "ERROR_INVALID_EMAIL":
        // errorMessage = "Your email address appears to be malformed.";
        Fluttertoast.showToast(
                              msg: 'Your email address appears to be malformed.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white);
        break;
      case "ERROR_WRONG_PASSWORD":
        // errorMessage = "Your password is wrong.";
        Fluttertoast.showToast(
                              msg: 'Your password is wrong',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white);
        break;
      case "ERROR_USER_NOT_FOUND":
        // errorMessage = "User with this email doesn't exist.";
            Fluttertoast.showToast(
                              msg: 'User with this email does not exist',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white);
        break;
      case "ERROR_USER_DISABLED":
        // errorMessage = "User with this email has been disabled.";
            Fluttertoast.showToast(
                              msg: 'User with this email has been disabled.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white);
        break;
      case "ERROR_TOO_MANY_REQUESTS":
        // errorMessage = "Too many requests. Try again later.";
            Fluttertoast.showToast(
                              msg: 'Too many requests. Try again later.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white);
        break;
      case "ERROR_OPERATION_NOT_ALLOWED":
        // errorMessage = "Signing in with Email and Password is not enabled.";
            Fluttertoast.showToast(
                              msg: 'Signing in with Email and Password is not enabled.',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white);
        break;
        case "weak-password":
        // errorMessage = "Your password is too weak";
             Fluttertoast.showToast(
                              msg: 'Your password is too weak',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white);
        break;
      default:
        errorMessage = "An undefined Error happened.";
    }
    

}
  
   } else {
      Fluttertoast.showToast(
                              msg: 'Your password is not match or invalide',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIos: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white);
   }
  
            
                      },
                      color: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: 
                      Text("Sign Up",style: TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18
                      ),),),
                 ),
                 ),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Text("SignUp allready"),
                     Container(
                       child: MaterialButton(
                         onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                         },
                         child: 
                         Text("Login", style: 
                        TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18
                        ),),
                       )
                       
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
    
  }

  Widget makeInput({label, obscureText = false}){
    return Container(
      child: Column(
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
      ),
    );
  }

  Widget makeInput1({label, obscureText = false}){
    return Container(
      child: Column(
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
      ),
    );
  }

  Widget makeInput3({label, obscureText = false}){
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(label, style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),),
          SizedBox(height: 5,),
          TextField(
            controller: _cPasswordController,
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
      ),
    );
  }
 void _register() async {
 
}
}



 