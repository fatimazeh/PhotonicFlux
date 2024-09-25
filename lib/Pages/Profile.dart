import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velvetvnaity/model/shared_preferences.dart'; // Adjust the import as necessary

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userName;
  String? userEmail;
  String? userImage;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? name = await SharedPreferenceshelper.getUserName();
    String? email = await SharedPreferenceshelper.getUserEmail();
    String? image = await SharedPreferenceshelper.getUserImage();

    setState(() {
      userName = name;
      userEmail = email;
      userImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: GoogleFonts.syne(color: Colors.white)),
        backgroundColor: Color(0xFFA80C0C),
      ),
      body: userName == null || userEmail == null || userImage == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: userImage != null
                        ? NetworkImage(userImage!)
                        : AssetImage('assets/default_profile.png') as ImageProvider, // Default image if none is provided
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Name: $userName',
                    style: GoogleFonts.syne(
                      textStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email: $userEmail',
                    style: GoogleFonts.syne(
                      textStyle: TextStyle(fontSize: 20),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await SharedPreferenceshelper.clearUserData();
                      Navigator.pushReplacementNamed(context, '/Userlogin'); // Navigate to login page or home page
                    },
                    child: Text('Logout', style: GoogleFonts.syne(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFA80C0C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
