import 'package:flutter/material.dart';
import 'package:velvetvnaity/Pages/HomePage.dart';
import 'package:velvetvnaity/Pages/CaradPage.dart';
import 'package:velvetvnaity/Pages/ProductPage.dart'; // Import HomePage or the correct page for navigation


class SolarWaterPump extends StatelessWidget {
  const SolarWaterPump({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Water Pumps - PhotonicFlux",
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
              Color(0xFFA80C0C), // Gradient color for Solar Water Pumps
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
                title: '1. Cost Efficiency',
                content:
                    'Solar water pumps are highly cost-effective for irrigation and water supply in remote areas. They reduce or eliminate electricity costs by utilizing solar energy.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '2. Environmental Impact',
                content:
                    'By using solar energy, these pumps help in reducing greenhouse gas emissions and fossil fuel dependence, contributing to a cleaner environment.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '3. Reliability',
                content:
                    'Solar water pumps operate independently of the electrical grid and are highly reliable in sunny areas, providing consistent water supply even in remote locations.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '4. Low Maintenance',
                content:
                    'With few moving parts and no fuel requirements, solar water pumps require minimal maintenance, reducing overall operational costs.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '5. Versatility',
                content:
                    'These pumps can be used for a variety of applications, including agricultural irrigation, livestock watering, and domestic water supply.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '6. Energy Independence',
                content:
                    'Solar water pumps provide an independent water source without relying on grid power, enhancing energy autonomy in off-grid areas.',
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

void main() {
  runApp(const MaterialApp(
    home: SolarWaterPump(),
  ));
}
