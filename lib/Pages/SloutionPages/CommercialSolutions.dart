import 'package:flutter/material.dart';

class CommercialSolutionsPage extends StatelessWidget {
  const CommercialSolutionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Commercial Solar Solutions',
          style: TextStyle(
            fontFamily: 'Montserrat', // Use your desired font
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFA80C0C),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFA80C0C), // Stylish gradient background
              Colors.white,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text(
              'Guide to Commercial Solar Solutions',
              style: TextStyle(
                fontFamily: 'Libre Caslon Text', // Your font style
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Explore cutting-edge solar appliances tailored for businesses. From large-scale solar panels to industrial battery storage, discover how you can maximize energy efficiency and reduce operational costs.',
              style: TextStyle(
                fontFamily: 'Syne',
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            // Solar Panel Section
            _buildSolarApplianceCard(
              imagePath: '../lib/images/Photoes/Accessories/CSI_INveter.jpg',
              title: 'CSI  Inverter',

              description:
                  'High-efficiency Inverter for large-scale electricity generation in businesses.',
            ),
            const SizedBox(height: 20),
            // Solar Inverter Section
            _buildSolarApplianceCard(
              imagePath: '../lib/images/Photoes/Accessories/streetlights.jpg',
              title: 'Street  Lights',

              description:
                  'Advanced StreetLigts  for seamless integration of solar energy into industrial setups.',
            ),
            const SizedBox(height: 20),
            // Solar Battery Section
            _buildSolarApplianceCard(
              imagePath: '../lib/images/Photoes/Accessories/industrail_panel.jpg',
              title: 'Commercial Solar Battery Storage',
              description:
                  'Large-capacity Solar Panel to store excess power for business operations.',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSolarApplianceCard({
    required String imagePath,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 180,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Libre Caslon Text',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFA80C0C), // Stylish title color
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'Syne',
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
