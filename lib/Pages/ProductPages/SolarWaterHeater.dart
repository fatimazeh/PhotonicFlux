import 'package:flutter/material.dart';
import 'package:velvetvnaity/Pages/HomePage.dart';

import 'package:velvetvnaity/Pages/ProductPage.dart'; // Import HomePage or the correct page for navigation


class SolarWaterHeater extends StatelessWidget {
  const SolarWaterHeater({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Water Heaters - PhotonicFlux",
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
              Color(0xFFA80C0C), // Gradient color for Solar Water Heaters
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
                title: '1. Cost Savings',
                content:
                    'Solar water heaters can significantly reduce your utility bills by using free solar energy to heat water, which can lead to substantial savings over time.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '2. Environmentally Friendly',
                content:
                    'Using solar energy to heat water reduces the reliance on fossil fuels and lowers greenhouse gas emissions, making it an eco-friendly choice.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '3. Reliable and Low Maintenance',
                content:
                    'Solar water heaters have few moving parts, making them reliable and requiring minimal maintenance compared to conventional heating systems.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '4. Energy Independence',
                content:
                    'By harnessing the sun’s energy, you become less dependent on the grid for your hot water needs, providing greater energy independence.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '5. Long-Term Investment',
                content:
                    'Solar water heaters typically have a long lifespan and can provide significant benefits over the years, making them a valuable long-term investment.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '6. Increased Property Value',
                content:
                    'Homes equipped with solar water heaters often see an increase in property value, as they are considered a desirable feature for potential buyers.',
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
    home: SolarWaterHeater(),
  ));
}
