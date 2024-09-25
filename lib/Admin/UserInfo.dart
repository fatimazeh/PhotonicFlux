import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:velvetvnaity/model/shared_preferences.dart';

 // Ensure you import your SharedPreferences helper file

class UserInfo extends StatefulWidget {
    static const String id = "UserInfo";
  const UserInfo({Key? key}) : super(key: key);

  @override
  _UserInfoState createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  String? userName;
  String? userEmail;
  String? userImage;
  String? userId;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _retrieveUserData();
  }

  Future<void> _retrieveUserData() async {
    try {
      // Retrieve user data from SharedPreferences
      userName = await SharedPreferenceshelper.getUserName();
      userEmail = await SharedPreferenceshelper.getUserEmail();
      userImage = await SharedPreferenceshelper.getUserImage();
      userId = await SharedPreferenceshelper.getUserId();

      // Fetch additional user data from Firestore if needed
      if (userId != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .get();

        if (userDoc.exists) {
          Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
          if (userData != null) {
            setState(() {
              userName = userData['Name'] ?? userName;
              userEmail = userData['Email'] ?? userEmail;
              userImage = userData['Image'] ?? userImage;
            });
          }
        }
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Failed to fetch user data: ${e.toString()}',
          style: const TextStyle(fontSize: 20.0),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('Active Users', style: GoogleFonts.aBeeZee(fontSize: 20,color: Colors.white)),
        backgroundColor: const Color(0xFFA80C0C),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: userImage != null
                          ? NetworkImage(userImage!)
                          : AssetImage('assets/default_profile_image.png') as ImageProvider,
                      backgroundColor: Colors.grey[300],
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Name: ${userName ?? 'Not available'}',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email: ${userEmail ?? 'Not available'}',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  // Add more fields as needed
                ],
              ),
            ),
      backgroundColor: Colors.black,
    );
  }
}
