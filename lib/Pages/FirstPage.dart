import 'package:flutter/material.dart';
import 'package:velvetvnaity/Pages/AffiliatewithUs.dart';
import 'package:velvetvnaity/Pages/DoItYourself.dart';
import 'package:velvetvnaity/Pages/Registernow.dart';
import 'package:velvetvnaity/pages/UserLogin.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
    );
  }
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Revolutionize Your Energy with Solar Power'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFA80C0C), Colors.black, Color(0xFFA80C0C), Colors.black, Color(0xFFA80C0C), Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // One card per row
            childAspectRatio: 3 / 2, // Adjust aspect ratio to control card size
            mainAxisSpacing: 10.0, // Space between rows
          ),
          padding: const EdgeInsets.all(10.0),
          itemCount: 4,
          itemBuilder: (context, index) {
            return _buildCard(
              index,
              () {
                // Handle navigation or other actions based on the card index
                switch (index) {
                  case 0:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Userlogin()),
                    );
                    break;
                  case 1:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AffiliateRegistrationScreen()),
                    );
                    break;
                  case 2:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterInstallerScreen()),
                    );
                    break;
                  case 3:
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const DoItYourself()),
                    );
                    break;
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildCard(int index, VoidCallback onPressed) {
    // Reorder the "Join Now" card to be first
    final List<String> images = [
      '../lib/images/Photoes/Accessories/solar_battery.jpg',
      '../lib/images/Photoes/Solarpanel_2.jpg',
      '../lib/images/Photoes/Accessories/inverters.jpg',
      '../lib/images/Photoes/Solarpanel_2.jpg',
    ];

    final List<String> titles = [
      'JOIN NOW',
      'AFFILIATE WITH US',
      'REGISTER AS INSTALLER',
      'DO IT YOURSELF',
    ];

    final List<String> descriptions = [
      'Join PhotonicFlux today and take control of your solar energy journey like never before! As a user, you’ll unlock a world of cutting-edge features designed to optimize your solar power system and enhance your energy experience.',
      "Affiliate with us in the Photonic Flux app, a cutting-edge solar power application designed to revolutionize the way we harness and utilize solar energy.",
      'The Photonic Flux app is designed to streamline solar energy installation and management, offering your clients real-time insights, predictive analytics, and seamless integration with their solar systems.',
      'The future of solar energy management, designed to elevate your solar experience to new heights! Imagine a system where your solar panels, inverters, and batteries are seamlessly interconnected.',
    ];

    final List<String> buttonTexts = [
      'JOIN NOW',
      'REGISTER NOW',
      'REGISTER NOW',
      'DIY',
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Card(
        color: Colors.transparent,
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: AssetImage(images[index]), // Set the background image
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.3), // Adjust opacity here
                BlendMode.srcOver,
              ),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.5), Colors.black.withOpacity(0.5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  titles[index],
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  descriptions[index],
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shadowColor: Colors.transparent,
                    foregroundColor: Color(0xFFA80C0C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                  child: Text(
                    buttonTexts[index],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
