import 'package:flutter/material.dart';
import 'package:velvetvnaity/Pages/HomePage.dart';

import 'package:velvetvnaity/Pages/ProductPage.dart'; // Import HomePage or the correct page for navigation


class SolarEnergyStorage extends StatelessWidget {
  const SolarEnergyStorage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Energy Storage - PhotonicFlux",
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
         Color(0xFFA80C0C),  // Updated gradient colors for Solar Energy Storage
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
                title: '1. Energy Independence',
                content:
                    'Solar energy storage systems allow you to store excess energy generated during the day for use during the night or cloudy days, enhancing your energy independence.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '2. Cost Savings',
                content:
                    'By storing excess energy, you can reduce your reliance on grid electricity, potentially lowering your energy bills, especially during peak hours.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '3. Backup Power Supply',
                content:
                    'Energy storage systems provide a backup power supply during outages, ensuring that essential appliances and devices remain operational.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '4. Efficient Energy Use',
                content:
                    'Storing solar energy helps in managing energy use more efficiently by balancing supply and demand, optimizing overall energy consumption.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '5. Environmental Benefits',
                content:
                    'Using stored solar energy reduces reliance on fossil fuels and decreases carbon emissions, contributing to a cleaner environment.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '6. Increased Solar Panel Efficiency',
                content:
                    'Energy storage systems can increase the efficiency of your solar panel setup by utilizing excess energy that would otherwise be wasted.',
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
                          builder: (context) => ProductListPage(),
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
