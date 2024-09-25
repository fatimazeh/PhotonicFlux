import 'package:flutter/material.dart';

class IndustrialSolutionsPage extends StatelessWidget {
  const IndustrialSolutionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Industrial Solar Solutions',
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
              'Guide to Industrial Solar Solutions',
              style: TextStyle(
                fontFamily: 'Libre Caslon Text', // Your font style
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Discover advanced solar solutions designed for industrial applications. From high-capacity solar panels to robust energy storage systems, our guide helps you implement solar technology for large-scale operations and increased energy efficiency.',
              style: TextStyle(
                fontFamily: 'Syne',
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            // High-Capacity Solar Panel Section
            _buildSolarApplianceCard(
              imagePath: '../lib/images/Photoes/Accessories/industrial_solarpanel.jpg',
              title: 'High-Capacity Solar Panels',
              description:
                  'Durable and efficient solar panels designed for industrial scale energy production.',
            ),
            const SizedBox(height: 20),
            // Industrial Solar Inverter Section
            _buildSolarApplianceCard(
              imagePath: '../lib/images/Photoes/Accessories/industrial_inverter.jpg',
              title: 'Industrial Solar Inverters',
              description:
                  'Heavy-duty inverters for converting solar energy into usable power for industrial applications.',
            ),
            const SizedBox(height: 20),
            // Industrial Solar Battery Section
            _buildSolarApplianceCard(
              imagePath: '../lib/images/Photoes/Accessories/industrial_solar_battery.jpg',
              title: 'Industrial Solar Battery Storage',
              description:
                  'High-capacity batteries for storing large amounts of solar energy for continuous power supply.',
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
