import 'package:flutter/material.dart';

import 'package:velvetvnaity/Pages/CaradPage.dart';
import 'package:velvetvnaity/Pages/ProductPage.dart';
import 'package:velvetvnaity/main.dart';



class SolarPanel extends StatelessWidget {
  const SolarPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Solar Panels - PhotonicFlux",
        style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        centerTitle: true,
        
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFA80C0C),
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
                title: '1. Cost Savings',
                content:
                    'Solar panels can significantly reduce your electricity bills by generating your own energy. Over time, the savings on energy costs can be substantial.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '2. Environmental Benefits',
                content:
                    'Solar energy is a clean, renewable resource. By using solar panels, you reduce your carbon footprint and contribute to a cleaner environment.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '3. Energy Independence',
                content:
                    'Generating your own electricity means you are less dependent on the grid. This can provide you with more control over your energy supply and protect you from energy price fluctuations.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '4. Increase Property Value',
                content:
                    'Homes with solar panel systems can see an increase in property value. Potential buyers often find solar panels attractive due to the energy savings they offer.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '5. Low Maintenance Costs',
                content:
                    'Solar panels require minimal maintenance. Regular cleaning and occasional inspections are usually all that’s needed to keep them functioning efficiently.',
              ),
              const SizedBox(height: 20),
              _buildAdvantageSection(
                title: '6. Technological Advancements',
                content:
                    'Solar technology is constantly evolving. With advancements in efficiency and storage, solar panels are becoming more effective and affordable.',
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
                          builder: (context) => const MyDrawer(), // Ensure this matches the actual class name
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
