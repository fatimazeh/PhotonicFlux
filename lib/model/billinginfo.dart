class BillingInfo {
  String name;
  String address;
  String city;
  String state;
  String zipCode;
  String cardNumber;
  String expirationDate;
  String cvv;
  String paymentMethod; // Added paymentMethod

  BillingInfo({
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.cardNumber,
    required this.expirationDate,
    required this.cvv,
    required this.paymentMethod, // Updated constructor
  });

  // Factory method to create a BillingInfo object from a map
  factory BillingInfo.fromJson(Map<String, dynamic> json) {
    return BillingInfo(
      name: json['name'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      zipCode: json['zipCode'],
      cardNumber: json['cardNumber'],
      expirationDate: json['expirationDate'],
      cvv: json['cvv'],
      paymentMethod: json['paymentMethod'], // Updated to parse paymentMethod
    );
  }

  // Method to convert a BillingInfo object to a map
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'cardNumber': cardNumber,
      'expirationDate': expirationDate,
      'cvv': cvv,
      'paymentMethod': paymentMethod, // Included in the map
    };
  }
}
