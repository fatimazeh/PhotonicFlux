import 'package:flutter/material.dart';

import 'package:velvetvnaity/Pages/HomePage.dart';
import 'package:velvetvnaity/Pages/ProductPage.dart';





class SolarChargeController extends StatelessWidget {
  const SolarChargeController({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Charge Controller - PhotonicFlux",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
                    Color(0xFFA80C0C), // Updated gradient colors
 // Adjust gradient colors as needed
              Colors.black,
            ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
       
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '1. Efficient Battery Charging',
                content:
                    'Solar charge controllers regulate the voltage and current coming from the solar panels to the batteries, ensuring efficient and safe battery charging.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '2. Prevents Battery Overcharging',
                content:
                    'By monitoring the battery’s charge level, charge controllers prevent overcharging, which can extend the lifespan of the batteries.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '3. Maximizes Energy Harvest',
                content:
                    'Charge controllers can optimize the energy harvested from the solar panels by adjusting the charging process to match the battery’s needs.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '4. Protects Against Battery Over-discharge',
                content:
                    'Solar charge controllers prevent batteries from discharging too much, which can protect the battery from damage and ensure a longer lifespan.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '5. Includes Diagnostic Features',
                content:
                    'Many charge controllers come with diagnostic features that provide valuable information about system performance and battery health.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '6. Enhances System Safety',
                content:
                    'Charge controllers often include safety features to protect the system from electrical faults and improve overall reliability.',
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  ProductListPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      minimumSize: const Size(150, 50),
                    ),
                    child: const Text(
                      'Shop',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 20), // Adds spacing between buttons
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Homepage(), // Ensure this matches the actual class name
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.white,
                      minimumSize: const Size(150, 50),
                    ),
                    child: const Text(
                      'Home',
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center(
                  child: Text(
                    "For more information or if you have any questions, feel free to reach out to us!",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdvantageSection({
    required String title,
    required String content,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
