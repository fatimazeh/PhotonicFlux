import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:velvetvnaity/Admin/ManegeNotifications.dart';

class NotificationPage extends StatefulWidget {
  static const String id = "NotificationPage";

  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final _titleController = TextEditingController();
  final _messageController = TextEditingController();

  Future<void> _addNotification() async {
    final title = _titleController.text;
    final message = _messageController.text;

    if (title.isEmpty || message.isEmpty) {
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('notifications').add({
        'title': title,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _titleController.clear();
      _messageController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Notification sent successfully!')),
      );
    } catch (e) {
      print('Error adding notification: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send notification.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Notifications', style: GoogleFonts.aBeeZee(fontSize: 20, color: Colors.white)),
        backgroundColor: const Color(0xFFA80C0C),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xFFA80C0C)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(20.0), // Add padding to the container
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0), // Padding inside the container
              margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0), // Margin around the container
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
                children: <Widget>[
                  // Heading
                  Center(
                    child: Text(
                      'Keep Everyone Informed, One Notification at a Time!',
                      style: GoogleFonts.aBeeZee(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFA80C0C),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: GoogleFonts.poppins(color: Colors.black54),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      labelStyle: GoogleFonts.aBeeZee(color: Colors.black54),
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addNotification,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA80C0C),
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      textStyle: GoogleFonts.aBeeZee(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: const Text('Send Notification', style: TextStyle(color: Colors.white)),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ManageNotificationsPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFA80C0C),
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      textStyle: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: const Text('Manage All Notifications', style: TextStyle(color: Colors.white)),
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
