import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:velvetvnaity/Pages/FirstPage.dart';

class RegisterInstallerScreen extends StatefulWidget {
  const RegisterInstallerScreen({Key? key}) : super(key: key);

  @override
  _RegisterInstallerScreenState createState() => _RegisterInstallerScreenState();
}

class _RegisterInstallerScreenState extends State<RegisterInstallerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _workexperienceController = TextEditingController();

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseFirestore.instance.collection('installers').add({
          'name': _nameController.text,
          'email': _emailController.text,
          'phone': _phoneController.text,
          'location': _locationController.text,
          'experience': _workexperienceController.text,
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration Successful')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to register: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFA80C0C), // Red color
                  Colors.black,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Content
          Center(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.0,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Register as Installer',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA80C0C), // Accent color
                      ),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          _buildTextFormField(
                            controller: _nameController,
                            labelText: 'Name',
                            hintText: 'Enter your full name',
                            icon: Icons.person,
                          ),
                          _buildTextFormField(
                            controller: _emailController,
                            labelText: 'Email',
                            hintText: 'Enter your email address',
                            icon: Icons.email,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          _buildTextFormField(
                            controller: _phoneController,
                            labelText: 'Phone',
                            hintText: 'Enter your phone number',
                            icon: Icons.phone,
                            keyboardType: TextInputType.phone,
                          ),
                          _buildTextFormField(
                            controller: _locationController,
                            labelText: 'Location',
                            hintText: 'Enter your location',
                            icon: Icons.location_on,
                          ),
                          _buildTextFormField(
                            controller: _workexperienceController,
                            labelText: 'Work Experience',
                            hintText: 'Describe your work experience',
                            icon: Icons.work,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: _submitForm,
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Color(0xFFA80C0C),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 15.0),
                              elevation: 5.0,
                            ),
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const FirstPage(),
                                ),
                              );
                            },
                            child: const Text(
                              'Back to Home',
                              style: TextStyle(
                                color: Color(0xFFA80C0C),
                                fontWeight: FontWeight.bold,
                              ),
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
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(icon, color: Color(0xFFA80C0C)), // Icon color
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        ),
        keyboardType: keyboardType,
        maxLines: maxLines,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $labelText';
          }
          return null;
        },
      ),
    );
  }
}
