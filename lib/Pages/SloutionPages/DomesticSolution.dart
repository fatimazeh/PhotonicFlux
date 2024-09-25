import 'package:flutter/material.dart';

class DomesticSolutionsPage extends StatelessWidget {
  const DomesticSolutionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Domestic Solar Solutions',
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
              const Color(0xFFA80C0C), // Stylish gradient background
              Colors.white,
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text(
              'Guide to Domestic Solar Solutions',
              style: TextStyle(
                fontFamily: 'Libre Caslon Text', // Your font style
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Discover the most efficient solar appliances for your home. Whether you\'re looking for solar panels, heaters, or battery storage, our guide will help you make informed decisions for sustainable energy.',
              style: TextStyle(
                fontFamily: 'Syne',
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            // Solar Panel Section
            _buildSolarApplianceCard(
              imagePath: '../lib/images/Photoes/Accessories/Solarpanel.jpg',
              title: 'Solar Panels',
       
              description:
                  'Efficient solar panels for electricity generation at home',
                  
            ),
            const SizedBox(height: 20),
            // Solar Heater Section
            _buildSolarApplianceCard(
              imagePath: '../lib/images/Photoes/Accessories/waterheater.jpg',
              title: 'Solar Water Heater',
              description:
                  'Eco-friendly water heating solutions powered by solar energy.',
            ),
            const SizedBox(height: 20),
            // Solar Battery Section
            _buildSolarApplianceCard(
              imagePath: '../lib/images/Photoes/Accessories/solar_battery.jpg',
              title: 'Solar Battery Storage',
              description:
                  'Store excess solar power and use it when the sun goes down.',
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
