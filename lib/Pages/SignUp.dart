import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velvetvnaity/pages/UserLogin.dart';
import '../model/data-file.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? name, mail, password, confirmPassword;

  TextEditingController namecontroller = TextEditingController();
  TextEditingController mailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  Future<void> registration() async {
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        content: const Text(
          'Passwords do not match.',
          style: TextStyle(fontSize: 16.0, color: Colors.white),
        ),
      ));
      return;
    }

    if (name != null && mail != null && password != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: mail!, password: password!);
        String Id = randomAlphaNumeric(10);
        Map<String, dynamic> userInfoMap = {
          "Id": Id,
          "Name": namecontroller.text,
          "Email": mailcontroller.text,
          "Image":
              "https://t3.ftcdn.net/jpg/06/19/26/46/360_F_619264680_x2PBdGLF54sFe7kTBtAvZnPyXgvaRw0Y.jpg"
        };
        await DatabaseMethods().adduserinformation(userInfoMap, Id);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Color(0xFFA80C0C),
          content: Text("Registered Successfully", style: TextStyle(color: Colors.white),),
        ));
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Userlogin()));
      } on FirebaseException catch (e) {
        String errorMessage = e.code == "weak-password"
            ? "Weak Password. Please use a stronger password."
            : e.code == "email-already-in-use"
                ? "Email already exists."
                : "An unexpected error occurred: ${e.message}";

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            errorMessage,
            style: const TextStyle(fontSize: 16.0, color: Colors.white),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
            decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('../lib/images/background_gif.gif'), // Add your background image here
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            colors: [Colors.transparent, Color(0xFFA80C0C).withOpacity(0.8), Colors.transparent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7), // Darker transparent background for the form container
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 40.0),
                  Text(
                    'Create Your Account',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.syne(
                      textStyle: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Unlock Your World: Secure Access Starts Here!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.syne(
                      textStyle: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA80C0C),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Form(
                    key: _formkey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: namecontroller,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            hintText: 'Enter your name',
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle: const TextStyle(color: Colors.white54),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.5),
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: mailcontroller,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle: const TextStyle(color: Colors.white54),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.5),
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!value.contains('@')) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: passwordcontroller,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle: const TextStyle(color: Colors.white54),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.5),
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            hintText: 'Confirm your password',
                            labelStyle: const TextStyle(color: Colors.white),
                            hintStyle: const TextStyle(color: Colors.white54),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.5),
                          ),
                          style: const TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != passwordcontroller.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              setState(() {
                                mail = mailcontroller.text;
                                name = namecontroller.text;
                                password = passwordcontroller.text;
                                confirmPassword = confirmPasswordController.text;
                              });
                              registration();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black, // Text color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text('Sign Up'),
                        ),
                        const SizedBox(height: 10.0),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Userlogin()),
                            );
                          },
                          child: const Text(
                            "Already have an account? Sign In",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
