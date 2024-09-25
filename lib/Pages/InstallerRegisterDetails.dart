import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class InstallerListScreen extends StatelessWidget {
  
  const InstallerListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Installers List'),
        backgroundColor: const Color(0xFFA80C0C), // Accent color
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('installers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final installers = snapshot.data?.docs ?? [];

          if (installers.isEmpty) {
            return const Center(child: Text('No installers found.'));
          }

          return ListView.builder(
            itemCount: installers.length,
            itemBuilder: (context, index) {
              final installer = installers[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(installer['name'] ?? 'No name'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${installer['email'] ?? 'No email'}'),
                      Text('Phone: ${installer['phone'] ?? 'No phone'}'),
                      Text('Location: ${installer['location'] ?? 'No location'}'),
                      Text('Experience: ${installer['experience'] ?? 'No experience'}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
