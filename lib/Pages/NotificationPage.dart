import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
 appBar: AppBar(
  title: Center(
    child: Stack(
      alignment: Alignment.center,
      children: const [
        Text(
          'Notifications',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Positioned(
          bottom: 20,
          child: Text(
            'Be in the Know with Our Latest Alerts!',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    ),
  ),
  backgroundColor: Colors.white,
),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFA80C0C), Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
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
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No notifications available.'));
            }

            final notifications = snapshot.data!.docs;

            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index].data() as Map<String, dynamic>;
                final title = notification['title'] ?? 'No Title';
                final message = notification['message'] ?? 'No Message';
                final timestamp = (notification['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now();

                return Card(
                  
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  

                  child: ListTile(
                    leading: Icon(
                      Icons.notifications,
                      color:Color(0xFFA80C0C),
                    ),
                    title: Text(
                      title,

                      style: TextStyle(fontWeight: FontWeight.bold,  fontSize: 18),

                    ),

                    subtitle: Text(message),
                    trailing: Text(
                      '${timestamp.hour}:${timestamp.minute}',
                      style: TextStyle(color: Colors.grey,),
                     
                    ),

                    contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
