import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velvetvnaity/Pages/SignUp.dart';
import 'package:velvetvnaity/main.dart';
import 'package:velvetvnaity/model/shared_preferences.dart';

class Userlogin extends StatefulWidget {
  const Userlogin({super.key});

  @override
  State<Userlogin> createState() => _UserloginState();
}

class _UserloginState extends State<Userlogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> userLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim());

        User? user = userCredential.user;
        if (user != null) {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection('users')
              .where('Email', isEqualTo: emailController.text.trim())
              .get();

          if (querySnapshot.docs.isNotEmpty) {
            DocumentSnapshot userDoc = querySnapshot.docs.first;
            String userId = userDoc.id;

            Map<String, dynamic>? userData =
                userDoc.data() as Map<String, dynamic>?;

            if (userData != null) {
              await SharedPreferenceshelper.saveUserName(userData["Name"]);
              await SharedPreferenceshelper.saveUserImage(
                  "https://t3.ftcdn.net/jpg/06/19/26/46/360_F_619264680_x2PBdGLF54sFe7kTBtAvZnPyXgvaRw0Y.jpg");
              await SharedPreferenceshelper.saveUserId(userId);
              _showDialog(
                context,
                "Login Successfully",
                Icons.check_circle_outline,
               Color(0xFFA80C0C),
                () {
                  Navigator.pop(context); // Close the dialog
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyDrawer()),
                  );
                },
              );
            } else {
              throw Exception("User Data is null");
            }
          } else {
            throw Exception("User Document does not exist.");
          }
        } else {
          throw Exception("User is null");
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        if (e.code == 'invalid-email') {
          errorMessage = "No User found for that Email";
        } else if (e.code == "wrong-password") {
          errorMessage = "Wrong Password provided by User";
        } else {
          errorMessage = "An unexpected error occurred: ${e.message}";
        }
        _showDialog(
          context,
          errorMessage,
          Icons.error_outline,
          Colors.red,
          () {
            Navigator.pop(context); // Close the dialog
          },
        );
      } catch (e) {
        _showDialog(
          context,
          "Failed to fetch user data: ${e.toString()}",
          Icons.error_outline,
          Colors.red,
          () {
            Navigator.pop(context); // Close the dialog
          },
        );
      }
    }
  }

  void _showDialog(BuildContext context, String message, IconData icon, Color iconColor, VoidCallback onContinue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: iconColor, size: 50),
              const SizedBox(height: 20),
              Text(
                message,
                  style: GoogleFonts.syne(
                      textStyle: const TextStyle(
                        fontSize: 19,
                      
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA80C0C),
                      ),
                    ),
                textAlign: TextAlign.center,
              ),
                    Text(
                'Welcome to PhotonixFlux',
                  style: GoogleFonts.syne(
                      textStyle: const TextStyle(
                        fontSize: 10,
                      
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA80C0C),
                      ),
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onContinue,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: iconColor,
                
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                
                ),
                child: const Text("Continue", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('../lib/images/background_gif.gif'), // Path to your background image
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            colors: [
              Colors.transparent,
              Color(0xFFA80C0C).withOpacity(0.10),
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8), // Transparent background for the form container
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 40.0),
                  Text(
                    'Login Here',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.syne(
                      textStyle: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA80C0C),
                      ),
                    ),
                  ),
                  Text(
                    'Unlock Your World: Secure Access Starts Here!',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.syne(
                      textStyle: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40.0),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white54),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.3),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 20.0),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            labelStyle: TextStyle(color: Colors.white),
                            hintStyle: TextStyle(color: Colors.white54),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true,
                            fillColor: Colors.black.withOpacity(0.3),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () => userLogin(context),
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black, // Button color
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          child: const Text('Login',style: TextStyle(color: Color(0xFFA80C0C),fontWeight: FontWeight.bold),),
                        ),
                        const SizedBox(height: 10.0),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp()),
                            );
                          },
                          child: const Text(
                            "Don't have an account? Sign Up",
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
