import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:velvetvnaity/LayoutScreen.dart';
import 'package:velvetvnaity/Pages/AboutUs.dart'; 
import 'package:velvetvnaity/Pages/Chatcreen.dart';
import 'package:velvetvnaity/Pages/FirstPage.dart';
import 'package:velvetvnaity/Pages/HomePage.dart'; 
import 'package:velvetvnaity/Pages/MainDrawer.dart';
import 'package:velvetvnaity/Pages/ProductPage.dart';

import 'package:velvetvnaity/model/data_provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
      apiKey: "AIzaSyCEsSGAOwb9xQgRaBfUesxJqg2ZVGFN-xk",
  authDomain: "photonicflux-4a550.firebaseapp.com",
  projectId: "photonicflux-4a550",
  storageBucket: "photonicflux-4a550.appspot.com",
  messagingSenderId: "822896895341",
  appId: "1:822896895341:web:4d5cf0001c5de94e1b6664",
  measurementId: "G-K9JXYGK577"
      ),
    );
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyA76p4ZxmrXKuzW5WHI33TawxtP24QP-3k",
        appId: "1:822896895341:android:bbb4ce00fe4381621b6664",
        messagingSenderId: "822896895341",
        projectId: "photonicflux-4a550",
         // Ensure this is included if using Realtime Database
        storageBucket:
            "photonicflux-4a550.appspot.com", // Ensure this is included if using Storage
      ),
    );
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: const MyApp(),
      
    ),
  );
}


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const FirstPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              '../lib/images/Logo/dynamic_PF_Logo.gif',
              width: 400,
              height: 400,
            ),
          ],
        ),
      ),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PhotonicFlux',
      theme: ThemeData(),
      home:  const Layoutscreen(),
    );
  }
}

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const Homepage(),
      ProductListPage(),
    const AboutPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatbotPage()),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.chat,color:Colors.black),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "Photonic",
                style: TextStyle(
                  color:  Color(0xFFA80C0C),
                  fontSize: 25,
                  fontFamily: 'DancingScript',
                ),
              ),
              TextSpan(
                text: "Flux",
                style: TextStyle(
                  color:  Color(0xFFA80C0C),
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      drawer: const MainDrawer(),
      backgroundColor: Colors.black,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color:  Color(0xFFA80C0C)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop, color:  Color(0xFFA80C0C)),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info, color:  Color(0xFFA80C0C)),
            label: 'About',
          ),
        ],
      ),
    );
  }
}
