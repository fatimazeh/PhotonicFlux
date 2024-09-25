
import 'package:flutter/material.dart';
import 'package:velvetvnaity/model/billinginfo.dart';
import 'package:velvetvnaity/model/product.dart';


class BillingInfoPage extends StatefulWidget {
  final List<Product> cart;
  final double totalAmount;

  const BillingInfoPage({
    required this.cart,
    required this.totalAmount,
    Key? key,
  }) : super(key: key);

  @override
  _BillingInfoPageState createState() => _BillingInfoPageState();
}

class _BillingInfoPageState extends State<BillingInfoPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expirationDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  String _paymentMethod = 'Credit Card'; // Default payment method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: 'City'),
            ),
            TextField(
              controller: _stateController,
              decoration: const InputDecoration(labelText: 'State'),
            ),
            TextField(
              controller: _zipCodeController,
              decoration: const InputDecoration(labelText: 'Zip Code'),
            ),
            TextField(
              controller: _cardNumberController,
              decoration: const InputDecoration(labelText: 'Card Number'),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            TextField(
              controller: _expirationDateController,
              decoration: const InputDecoration(labelText: 'Expiration Date (MM/YY)'),
            ),
            TextField(
              controller: _cvvController,
              decoration: const InputDecoration(labelText: 'CVV'),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            DropdownButton<String>(
              value: _paymentMethod,
              onChanged: (String? newValue) {
                setState(() {
                  _paymentMethod = newValue!;
                });
              },
              items: <String>['Credit Card', 'PayPal', 'Bank Transfer']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            ElevatedButton(
              onPressed: () {
                final billingInfo = BillingInfo(
                  name: _nameController.text,
                  address: _addressController.text,
                  city: _cityController.text,
                  state: _stateController.text,
                  zipCode: _zipCodeController.text,
                  cardNumber: _cardNumberController.text,
                  expirationDate: _expirationDateController.text,
                  cvv: _cvvController.text,
                  paymentMethod: _paymentMethod,
                );

                Navigator.pop(context, billingInfo); // Return billing info to CartPage
              },
              child: const Text('Submit Billing Info'),
            ),
          ],
        ),
      ),
    );
  }
}
