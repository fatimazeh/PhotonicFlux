import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:velvetvnaity/model/data-file.dart'; // Update the import path if needed

class ContactDetailsListPage extends StatefulWidget {
  static const String id = "ContactDetailsListPage";

  @override
  _ContactDetailsListPageState createState() => _ContactDetailsListPageState();
}

class _ContactDetailsListPageState extends State<ContactDetailsListPage> {
  late Future<List<Map<String, dynamic>>> contactDetailsFuture;

  @override
  void initState() {
    super.initState();
    contactDetailsFuture = DatabaseMethods().fetchContactDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('User Contact Info', style: GoogleFonts.aBeeZee(fontSize: 20,color: Colors.white)),
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
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: contactDetailsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No contact details found'));
            } else {
              List<Map<String, dynamic>> contactDetails = snapshot.data!;

              return ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: contactDetails.length,
                itemBuilder: (context, index) {
                  final contact = contactDetails[index];
                  return Card(
                    elevation: 5.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFFA80C0C),
                        child: Text(
                          contact['Name']?.substring(0, 1) ?? 'N',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24.0,
                          ),
                        ),
                      ),
                      title: Text(
                        contact['Name'] ?? 'No Name',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Email: ${contact['Email'] ?? 'No Email'}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                            ),
                          ),
                          Text(
                            'Message: ${contact['Message'] ?? 'No Message'}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
