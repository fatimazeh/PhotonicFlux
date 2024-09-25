import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageNotificationsPage extends StatefulWidget {
  @override
  _ManageNotificationsPageState createState() => _ManageNotificationsPageState();
}

class _ManageNotificationsPageState extends State<ManageNotificationsPage> {
  Future<void> _deleteNotification(String id) async {
    try {
      await FirebaseFirestore.instance.collection('notifications').doc(id).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Notification deleted successfully!')),
      );
    } catch (e) {
      print('Error deleting notification: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete notification.')),
      );
    }
  }

  Future<void> _editNotification(String id, String title, String message) async {
    try {
      await FirebaseFirestore.instance.collection('notifications').doc(id).update({
        'title': title,
        'message': message,
        'timestamp': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Notification updated successfully!')),
      );
    } catch (e) {
      print('Error updating notification: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update notification.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Notifications', style: GoogleFonts.poppins(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold)),
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
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('notifications')
              .orderBy('timestamp', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}', style: GoogleFonts.poppins(color: Colors.red)));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No notifications available.', style: GoogleFonts.poppins(color: Colors.black)));
            }

            final notifications = snapshot.data!.docs;

            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index].data() as Map<String, dynamic>;
                final id = notifications[index].id;
                final title = notification['title'] ?? 'No Title';
                final message = notification['message'] ?? 'No Message';
                final timestamp = (notification['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now();

                return _buildNotificationCard(id, title, message, timestamp);
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildNotificationCard(String id, String title, String message, DateTime timestamp) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(title, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: Text(message, style: GoogleFonts.poppins(fontSize: 16)),
        trailing: Text(
          '${timestamp.hour}:${timestamp.minute}',
          style: GoogleFonts.poppins(color: Colors.grey),
        ),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                _showEditNotificationDialog(id, title, message);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _showDeleteConfirmationDialog(id);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showEditNotificationDialog(String id, String currentTitle, String currentMessage) {
    final titleController = TextEditingController(text: currentTitle);
    final messageController = TextEditingController(text: currentMessage);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Notification', style: GoogleFonts.poppins(fontSize: 20)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
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
                controller: messageController,
                decoration: InputDecoration(
                  labelText: 'Message',
                  labelStyle: GoogleFonts.poppins(color: Colors.black54),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _editNotification(id, titleController.text, messageController.text);
              },
              child: Text('Save', style: GoogleFonts.poppins(color: Color(0xFFA80C0C))),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Notification', style: GoogleFonts.poppins(fontSize: 20)),
          content: Text('Are you sure you want to delete this notification?', style: GoogleFonts.poppins(fontSize: 16)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel', style: GoogleFonts.poppins(color: Colors.black)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _deleteNotification(id);
              },
              child: Text('Delete', style: GoogleFonts.poppins(color: Color(0xFFA80C0C))),
            ),
          ],
        );
      },
    );
  }
}
