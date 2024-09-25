import 'package:flutter/material.dart';
import 'package:velvetvnaity/Pages/HomePage.dart';

import 'package:velvetvnaity/Pages/ProductPage.dart'; // Import HomePage or the correct page for navigation


class MountainingStructure extends StatelessWidget {
  const MountainingStructure({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Mountaining Srtucture - PhotonicFlux",
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
              Color(0xFFA80C0C), // Gradient color for Mountaining Structure
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
                title: '1. Optimal Panel Positioning',
                content:
                    'Mountaining structures ensure that solar panels are positioned at the optimal angle to capture the maximum amount of sunlight, improving energy efficiency.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '2. Enhanced Durability',
                content:
                    'Quality mounting structures are designed to withstand harsh weather conditions, including high winds and heavy snow, ensuring the longevity of your solar panels.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '3. Improved Aesthetics',
                content:
                    'Modern mounting structures are designed to blend seamlessly with your roof or property, enhancing the overall appearance of your solar panel installation.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '4. Flexibility and Versatility',
                content:
                    'Mountaining structures come in various designs to fit different roof types and terrains, offering flexibility and versatility for your solar panel setup.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '5. Ease of Maintenance',
                content:
                    'Properly installed mounting structures make it easier to access and maintain your solar panels, facilitating regular cleaning and inspections.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '6. Increased Safety',
                content:
                    'Reliable mounting structures ensure that solar panels are securely attached, minimizing the risk of accidents or damage due to loose or unstable panels.',
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
                          builder: (context) =>   ProductListPage(),
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
    home: MountainingStructure(),
  ));
}
