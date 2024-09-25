import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDIY extends StatefulWidget {
  static const String id = "UserDIY";

  const UserDIY({super.key});

  @override
  State<UserDIY> createState() => _UserDIYState();
}

class _UserDIYState extends State<UserDIY> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> _stream;

  @override
  void initState() {
    super.initState();
    _stream = _firestore.collection('DoItYourSelf').snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        title: Text('User DIY', style: GoogleFonts.aBeeZee(fontSize: 20,color: Colors.white)),
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
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text('No data available'));
            }

            final docs = snapshot.data!.docs;

            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (context, index) {
                final data = docs[index].data() as Map<String, dynamic>;

                return DIYCard(data: data); // Use the custom card widget
              },
            );
          },
        ),
      ),
    );
  }
}

// Define the custom card widget within the same file
class DIYCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const DIYCard({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            data['area']?.substring(0, 1) ?? 'N',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${data['name'] ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color:Color(0xFFA80C0C),
              ),
            ),
            Text(
              'Email: ${data['email'] ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 16.0,
                color:Color(0xFFA80C0C),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Area: ${data['area'] ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'System: ${data['system'] ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            Text(
              'Panel: ${data['panel'] ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            Text(
              'Structure: ${data['structure'] ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            Text(
              'Number of Panels: ${data['numberOfPanels'] ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            Text(
              'Number of Stands: ${data['numberOfStands'] ?? 'N/A'}',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            Text(
              'Ducting + Piping: ${data['hasDuctingPiping'] ? 'Yes' : 'No'}',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            Text(
              'Civil Work: ${data['hasCivilWork'] ? 'Yes' : 'No'}',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            Text(
              'Cables: ${data['hasCables'] ? 'Yes' : 'No'}',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            Text(
              'Surge Protection Devices: ${data['hasSurgeProtectionDevices'] ? 'Yes' : 'No'}',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            Text(
              'Complete Net Metering Services: ${data['completeNetMeteringServices'] ? 'Yes' : 'No'}',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            Text(
              'Transportation + Labour: ${data['transportationAndLabour'] ? 'Yes' : 'No'}',
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 4.0), // Adds a small space above the timestamp
            Text(
              'Added on: ${data['timestamp']?.toDate().toLocal().toString() ?? 'Unknown'}',
              style: const TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
