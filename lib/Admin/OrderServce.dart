import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProductSummaryService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId = FirebaseAuth.instance.currentUser!.uid;

  Future<Map<String, dynamic>> fetchProductSummary() async {
    // Fetch orders
    QuerySnapshot ordersSnapshot = await _firestore
        .collection('Orders')
        .where('userId', isEqualTo: userId)
        .get();

    // Fetch billing info
    DocumentSnapshot billingInfoSnapshot = await _firestore
        .collection('BillingInfo')
        .doc(userId)
        .get();

    List<Map<String, dynamic>> orders = ordersSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    Map<String, dynamic>? billingInfo = billingInfoSnapshot.data() as Map<String, dynamic>?;

    return {
      'orders': orders,
      'billingInfo': billingInfo,
    };
  }
}
