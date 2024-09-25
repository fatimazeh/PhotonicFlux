import 'package:flutter/material.dart';
import 'package:velvetvnaity/Pages/HomePage.dart';

import 'package:velvetvnaity/Pages/ProductPage.dart'; // Import HomePage or the correct page for navigation


class SolarLights extends StatelessWidget {
  const SolarLights({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Solar Lights - PhotonicFlux",
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
              Color(0xFFA80C0C), // Gradient color for Solar Lights
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
              _buildAdvantageSection(
                title: '1. Energy Efficiency',
                content:
                    'Solar lights are highly energy efficient, converting sunlight into usable light with minimal energy waste.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '2. Low Operating Costs',
                content:
                    'Once installed, solar lights have minimal operating costs as they use renewable energy from the sun.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '3. Easy Installation',
                content:
                    'Solar lights are easy to install with no wiring required, making them a versatile option for various settings.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '4. Environmentally Friendly',
                content:
                    'By using solar energy, solar lights help reduce reliance on fossil fuels and lower carbon emissions.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '5. Enhanced Safety',
                content:
                    'Solar lights provide better visibility and security for outdoor spaces without the need for electrical connections.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '6. Low Maintenance',
                content:
                    'Solar lights generally require low maintenance as they have no moving parts and use durable LED bulbs.',
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

void main() {
  runApp(const MaterialApp(
    home: SolarLights(),
  ));
}
