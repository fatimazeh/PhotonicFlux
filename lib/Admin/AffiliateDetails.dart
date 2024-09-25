import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class AffiliateListScreen extends StatelessWidget {
  static const String id = "AffiliateListScreen";

  const AffiliateListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Affiliate Details', style: GoogleFonts.aBeeZee(fontSize: 20,color: Colors.white)),
        backgroundColor: const Color(0xFFA80C0C),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFf5f5f5), Color(0xFFe0e0e0)], // Light gray gradient
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('affiliates').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final affiliates = snapshot.data?.docs ?? [];

            if (affiliates.isEmpty) {
              return const Center(child: Text('No affiliates found.'));
            }

            return ListView.builder(
              itemCount: affiliates.length,
              itemBuilder: (context, index) {
                final affiliate = affiliates[index].data() as Map<String, dynamic>;

                return Card(
                  margin: const EdgeInsets.all(10.0),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFA80C0C),
                      child: Text(
                        affiliate['name']?.substring(0, 1) ?? 'A',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    title: Text(
                      affiliate['name'] ?? 'No name',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Email: ${affiliate['email'] ?? 'No email'}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          'Phone: ${affiliate['phone'] ?? 'No phone'}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          'Organization: ${affiliate['organization'] ?? 'No organization'}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54,
                          ),
                        ),
                        Text(
                          'Message: ${affiliate['message'] ?? 'No message'}',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                    trailing: Text(
                      '${affiliate['timestamp']?.toDate().toLocal() ?? DateTime.now()}',
                      style: TextStyle(color: Colors.grey),
                    ),
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
