import 'package:flutter/material.dart';

class DIYGuide extends StatelessWidget {
  const DIYGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DIY Guide"),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFA80C0C), // Dark red
              Color(0xFFA80C0C), // Dark red
              Colors.black,      // Black
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                     Image.asset(
                '../lib/images/Photoes/DIY_FULL.gif', // Adjust the path to your image
                height: 250, // Adjust height as needed
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              
              const Text(
                "DIY Guide: Measuring Photonic Flux",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Objective:",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                "Learn how to measure photonic flux, which is the rate at which photons are emitted from a light source.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Materials Needed:",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "• Light source (e.g., LED or lamp)\n"
                "• Photonic flux meter or light sensor\n"
                "• Measuring tape or ruler\n"
                "• Notebook and pen for recording data",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Steps:",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "1. Prepare Your Workspace:\n"
                "   • Set up your light source on a stable surface.\n"
                "   • Place your photonic flux meter or light sensor at a known distance from the light source. Ensure the meter is calibrated if required.\n\n"
                "2. Position the Sensor:\n"
                "   • Use the measuring tape or ruler to position the sensor directly in front of the light source. Ensure it is aligned to capture the light accurately.\n\n"
                "3. Measure the Photonic Flux:\n"
                "   • Turn on your light source and take a reading from the flux meter. Follow any specific instructions provided with your meter for accurate measurement.\n"
                "   • Record the value in your notebook.\n\n"
                "4. Adjust and Compare:\n"
                "   • If needed, adjust the distance between the sensor and the light source to see how it affects the photonic flux.\n"
                "   • Take additional readings at different distances and document your observations.\n\n"
                "5. Analyze Your Data:\n"
                "   • Review your recorded measurements to understand how the light intensity changes with distance or other variables.\n\n"
                "6. Finalize:\n"
                "   • Based on your observations, make any necessary adjustments to your setup or experiment as needed.",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Tips:",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "• Ensure your light source is stable and consistent during measurements.\n"
                "• Record all data carefully for accurate analysis.\n"
                "• If you have any questions or need further assistance, don’t hesitate to reach out!",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Happy experimenting!",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              // Adding an image related to the DIY guide
       
            ],
          ),
        ),
      ),
    );
  }
}
