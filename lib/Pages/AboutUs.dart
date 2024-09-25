import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

import 'package:velvetvnaity/main.dart';
import 'package:velvetvnaity/model/data-file.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Picture widget (not a full background)
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 3.0),
              child: Image.asset(
                '../lib/images/Photoes/globevideo_backbanner.gif', // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const MyApp()),
                    );
                  },
                  child: const Text(
                    'Back to Home',
                    style: TextStyle(
                        color: Color(0xFFA80C0C), fontWeight: FontWeight.bold),
                  ),
                ),
              ),
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
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 3.0),
              child: Image.asset(
                '../lib/images/Photoes/Invertertypes_backbanner.jpg', // Replace with your image path
                fit: BoxFit.cover,
              ),
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
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 3.0),
              child: Image.asset(
                '../lib/images/Photoes/raw_backbanner.jpg', // Replace with your image path
                fit: BoxFit.cover,
              ),
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
              padding: const EdgeInsets.all(20.0), // Adjust padding as needed
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.black, Color(0xFFA80C0C)],
                ),
              ),

              child: const Text(
                'Contact Us',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 10.0),
            const ContactForm(), // Inserting the ContactForm widget here
          ],
        ),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({super.key});

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: const TextStyle(color: Colors.white),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.white),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: const TextStyle(color: Colors.white),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your email';
              } else if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 10.0),
          TextFormField(
            controller: _messageController,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Message',
              labelStyle: const TextStyle(color: Colors.white),
              hintText: 'Enter your message',
              hintStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            style: const TextStyle(color: Colors.white),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter your message';
              }
              return null;
            },
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                String id = randomAlphaNumeric(10);
                Map<String, dynamic> usercontactMap = {
                  "Id": id,
                  "Name": _nameController.text,
                  "Email": _emailController.text,
                  "Message": _messageController.text,
                };

                try {
                  await DatabaseMethods()
                      .ContactDetails(usercontactMap, id)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Message sent!',
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Color(0xFFA80C0C),
                      ),
                    );

                    _nameController.clear();
                    _emailController.clear();
                    _messageController.clear();
                  });
                } catch (e) {
                  Fluttertoast.showToast(
                    msg: "Failed to send message. Please try again.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 3,
                    backgroundColor: const Color(0xFFA80C0C),
                    textColor: Colors.white,
                    fontSize: 16.0,
                  );
                  print('Error sending message: $e');
                }
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFFA80C0C),
            ),
            child: const Center(
              child: Text(
                'Submit',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
