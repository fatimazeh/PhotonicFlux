import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  @override
  void initState() {
    super.initState();
    // No need to load user data anymore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Removed User Information Row
            // Rest of your content
            Image.asset(
              'lib/images/Photoes/HOME_PAGE_BANNER.gif',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Welcome to Photonic Flux Mission, where we aim to revolutionize '
              'the way humanity interacts with light. Our mission is grounded '
              'in the belief that photonics—the science and technology of '
              'generating, controlling, and detecting photons—holds the key to '
              'advancing numerous fields, from communications and medicine to '
              'energy and beyond.',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            const SizedBox(height: 20.0),
            Image.asset(
              'lib/images/Photoes/Invertertypes_backbanner.jpg',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'At Photonic Flux Mission, we envision a future where photonics '
              'enables:',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            const SizedBox(height: 10.0),
            const Text(
              '''
- Advanced Communication: Ultra-fast and secure communication networks that redefine connectivity.
- Healthcare Innovation: Precision medical instruments for early disease detection and non-invasive treatments.
- Clean Energy Solutions: Efficient solar cells and novel lighting technologies that reduce our environmental footprint.
- Scientific Discovery: Powerful tools for exploring the universe and understanding the fundamental laws of nature.
''',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20.0),
            Image.asset(
              '../lib/images/Photoes/ourmission_backbanner.jpg',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10.0),
            const Text(
              'Our mission is to push the boundaries of photonics research and '
              'development, fostering innovation through collaboration and '
              'cutting-edge technology. By bringing together experts from diverse '
              'disciplines, we strive to create practical solutions that improve '
              'lives and inspire future generations.',
              style: TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            const SizedBox(height: 40.0),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.black, Color(0xFFA80C0C)],
                ),
              ),
              child: const Text(
                'Smart solutions for superior solar performance',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            // Placeholder for the ContactForm widget
            // const ContactForm(), // Uncomment and adjust as needed
          ],
        ),
      ),
    );
  }
}
