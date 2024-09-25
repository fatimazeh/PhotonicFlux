import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:velvetvnaity/Admin/web_main.dart';
import 'package:velvetvnaity/model/shared_pref_admin.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  SharedPreferenceHelper sharedPrefHelper = SharedPreferenceHelper(); // Correct class name

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient container
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Color(0xFFA80C0C)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Main content container
          SingleChildScrollView(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
                width: MediaQuery.of(context).size.width * 0.85,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30.0),
                    const Center(
                      child: Icon(
                        Icons.lock, // Icon for privacy/protection
                        size: 60.0,
                        color: Color(0xFFA80C0C),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const Center(
                      child: Text(
                        "Secure Admin Login",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFA80C0C),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        "Fill the following Credentials to get Access",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFA80C0C),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      "Username",
                      style: TextStyle(
                        color:  Color(0xFFA80C0C),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Your Name";
                        }
                        return null;
                      },
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Type your name here....",
                        prefixIcon: Icon(Icons.person, color:  Color(0xFFA80C0C)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      "Password",
                      style: TextStyle(
                        color:  Color(0xFFA80C0C),
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Your Password";
                        }
                        return null;
                      },
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.password, color: Color(0xFFA80C0C)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 30.0),
                    GestureDetector(
                      onTap: () {
                        loginAdmin();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black, Color(0xFFA80C0C)],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loginAdmin() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance.collection("Admin").get();
      bool credentialsCorrect = false;

      for (var result in snapshot.docs) {
        var data = result.data() as Map<String, dynamic>?; // Ensure data is not null

        if (data != null) {
          String? name = data['name'] as String?;
          String? password = data['password'] as String?;

          if (name != null && password != null) { // Ensure name and password are not null
            if (name == nameController.text.trim() && password == passwordController.text.trim()) {
              credentialsCorrect = true;
              await sharedPrefHelper.saveAdminData(name); // Save admin data in shared preferences
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const WebMain()));
              break; // Exit the loop once credentials are correct
            }
          }
        }
      }

      if (!credentialsCorrect) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.black,
            content: Text(
              "Your Given Credentials are not Correct",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
      }
    } catch (e) {
      print("Error during login: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor:Color(0xFFA80C0C),
          content: Text(
            "An error occurred during login",
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      );
    }
  }
}
