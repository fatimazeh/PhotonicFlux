import 'package:flutter/material.dart';
import 'package:velvetvnaity/Pages/AboutUs.dart';
import 'package:velvetvnaity/Pages/AffiliatewithUs.dart';
import 'package:velvetvnaity/Pages/DoItYourself.dart';
import 'package:velvetvnaity/Pages/ProductPages/ChargeContoller.dart';
import 'package:velvetvnaity/Pages/ProductPages/EnergyStorage.dart';
import 'package:velvetvnaity/Pages/ProductPages/MountainingStructure.dart';
import 'package:velvetvnaity/Pages/ProductPages/SolarPanels.dart';
import 'package:velvetvnaity/Pages/ProductPages/SolarInverters.dart';
import 'package:velvetvnaity/Pages/ProductPages/SolarLights.dart';
import 'package:velvetvnaity/Pages/ProductPages/SolarWaterHeater.dart';
import 'package:velvetvnaity/Pages/ProductPages/SolarWaterPump.dart';
import 'package:velvetvnaity/Pages/Profile.dart';
import 'package:velvetvnaity/Pages/Registernow.dart'; 
import 'package:velvetvnaity/Pages/SloutionPages/CommercialSolutions.dart';
import 'package:velvetvnaity/Pages/SloutionPages/DomesticSolution.dart';
import 'package:velvetvnaity/Pages/SloutionPages/IndustrialSolution.dart';
import 'package:velvetvnaity/Pages/UserLogin.dart';
import 'package:velvetvnaity/Pages/WorkTogether/AlignwithUs.dart';
import 'package:velvetvnaity/Pages/WorkTogether/WorkasInstaller.dart';
import 'package:velvetvnaity/model/shared_preferences.dart';
import 'package:velvetvnaity/Pages/NotificationPage.dart'; // Import the NotificationPage
import 'package:cloud_firestore/cloud_firestore.dart';

class MainDrawer extends StatefulWidget {
  const MainDrawer({super.key});

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String? _userName;
  String? _userImage;
  int _notificationCount = 0; // Add this line to keep track of notifications

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchNotificationCount(); // Fetch notification count on initialization
  }

  Future<void> _loadUserData() async {
    _userName = await SharedPreferenceshelper.getUserName();
    _userImage = await SharedPreferenceshelper.getUserImage();
    setState(() {});
  }

  Future<void> _fetchNotificationCount() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('notifications')
          .where('isRead', isEqualTo: false) // Assuming 'isRead' is a field to mark notifications as read
          .get();
      setState(() {
        _notificationCount = snapshot.size;
      });
    } catch (e) {
      print('Error fetching notifications: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 300,
      backgroundColor: Colors.black,
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.black,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  backgroundImage: _userImage != null
                      ? NetworkImage(_userImage!)
                      : null,
                  child: _userImage == null
                      ? Icon(Icons.person, size: 50, color: Colors.black)
                      : null,
                ),
                const SizedBox(height: 10),
                Text(
                  _userName ?? 'Welcome User',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          buildListItem(
            context,
            "Profile",
            Icons.person,
             ProfilePage(),
          ),
          buildDropdownItem(
            context,
            "Products",
            Icons.store_outlined,
            {
              'Solar Panels': const SolarPanel(),
              'Solar Inverter': const SolarInverter(),
              'Energy Storage': const SolarEnergyStorage(),
              'Mountaining Structure': const MountainingStructure(),
              'Charge Controller': const SolarChargeController(),
              'Solar Water Pump': const SolarWaterPump(),
              'Solar Water Heater': const SolarWaterHeater(),
              'Solar Lights': const SolarLights(),
            },
            [
              'Solar Panels',
              'Solar Inverter',
              'Energy Storage',
              'Mountaining Structure',
              'Charge Controller',
              'Solar Water Pump',
              'Solar Water Heater',
              'Solar Lights',
            ],
          ),
          buildDropdownItem(
            context,
            "Solutions",
            Icons.lightbulb_outline,
            {
              'Domestic Solutions': const DomesticSolutionsPage(),
              'Commercial Solutions': const CommercialSolutionsPage(),
              'Industrial Solutions': const IndustrialSolutionsPage(),
            },
            [
              'Domestic Solutions',
              'Commercial Solutions',
              'Industrial Solutions',
            ],
          ),
          buildListItem(
            context,
            "DIY",
            Icons.toll_outlined,
            const DoItYourself(),
          ),
          buildDropdownItem(
            context,
            "Work Together",
            Icons.work_outline,
            {
              'Align With Us': const AffiliateRegistrationScreen(),
              'Work as Installer': const RegisterInstallerScreen(),
            },
            [
              'Align With Us',
              'Work as Installer',
            ],
          ),
          buildListItem(
            context,
            "Notifications", // Added Notifications menu item
            Icons.notifications,
            const NotificationsPage(), // Page to navigate to
            notificationCount: _notificationCount, // Pass notification count
          ),
          buildListItem(
            context,
            "About",
            Icons.info,
            const AboutPage(),
          ),
          buildListItem(
            context,
            "Logout",
            Icons.exit_to_app,
            const LogoutPage(),
            isLogout: true,
          ),
        ],
      ),
    );
  }

  Widget buildListItem(
    BuildContext context,
    String title,
    IconData icon,
    Widget destination, {
    bool isLogout = false,
    int notificationCount = 0, // Add notificationCount parameter
  }) {
    return ListTile(
      leading: Stack(
        children: [
          Icon(icon, color: Colors.white),
          if (notificationCount > 0)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(12),
                ),
                constraints: BoxConstraints(minWidth: 24),
                child: Center(
                  child: Text(
                    '$notificationCount',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
        if (isLogout) {
          // Handle logout logic here
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Userlogin()),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        }
      },
    );
  }

  Widget buildDropdownItem(
    BuildContext context,
    String title,
    IconData icon,
    Map<String, Widget> destinationMap,
    List<String> dropdownItems,
  ) {
    String dropdownValue = dropdownItems.first;

    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: dropdownValue,
          dropdownColor: const Color(0xFFA80C0C),
          style: const TextStyle(color: Colors.white, fontSize: 15),
          onChanged: (String? newValue) {
            if (newValue != null) {
              Widget? destination = destinationMap[newValue];
              if (destination != null) {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => destination),
                );
              }
            }
          },
          items: dropdownItems.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

// Dummy Logout Page. Replace this with your actual logout logic or screen.
class LogoutPage extends StatelessWidget {
  const LogoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Perform logout logic here (e.g., clearing user session)

    // For demonstration, just navigate to a placeholder page
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logged Out'),
      ),
      body: Center(
        child: Text('You have been logged out.'),
      ),
    );
  }
}
