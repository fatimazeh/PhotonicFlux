import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BillingInfoListPage extends StatelessWidget {
  static const String id = 'BillingInfoListPage'; // Add this ID

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Billing Info', style: GoogleFonts.aBeeZee(fontSize: 20,color: Colors.white)),
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
          stream: FirebaseFirestore.instance.collection('BillingInfo').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}', style: TextStyle(fontSize: 16, color: Colors.red)));
            }

            final billingInfos = snapshot.data?.docs ?? [];

            if (billingInfos.isEmpty) {
              return const Center(child: Text('No billing information available.', style: TextStyle(fontSize: 18, color: Colors.grey)));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: billingInfos.length,
              itemBuilder: (context, index) {
                final billingInfo = billingInfos[index].data() as Map<String, dynamic>;
                final timestamp = (billingInfo['timestamp'] as Timestamp).toDate();

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
                        billingInfo['name']?.substring(0, 1) ?? 'B',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    title: Text(
                      'Submitted on ${timestamp.toLocal()}',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Name: ${billingInfo['name'] ?? 'No name'}', style: _infoTextStyle()),
                        Text('Email: ${billingInfo['email'] ?? 'No email'}', style: _infoTextStyle()),
                        Text('Address: ${billingInfo['address'] ?? 'No address'}', style: _infoTextStyle()),
                        Text('State: ${billingInfo['state'] ?? 'No state'}', style: _infoTextStyle()),
                        Text('Zip Code: ${billingInfo['zipCode'] ?? 'No zip code'}', style: _infoTextStyle()),
                        Text('Payment Method: ${billingInfo['paymentMethod'] ?? 'No payment method'}', style: _infoTextStyle()),
                      ],
                    ),
                    trailing: Text(
                      '${timestamp.toLocal()}',
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

  TextStyle _infoTextStyle() {
    return TextStyle(
      fontSize: 16.0,
      color: Colors.black54,
    );
  }
}
