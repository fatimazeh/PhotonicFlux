import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:velvetvnaity/Admin/AddProducts.dart';
import 'package:velvetvnaity/Admin/AffiliateDetails.dart';
import 'package:velvetvnaity/Admin/BillingInfo.dart';
import 'package:velvetvnaity/Admin/InstallerDetails.dart';
import 'package:velvetvnaity/Admin/Notifire.dart';
import 'package:velvetvnaity/Admin/Orders.dart';
import 'package:velvetvnaity/Admin/ProductAccess.dart';
import 'package:velvetvnaity/Admin/RegisteredUsers.dart';
import 'package:velvetvnaity/Admin/UserContactInfo.dart';
import 'package:velvetvnaity/Admin/Dashboard.dart';
import 'package:velvetvnaity/Admin/UserDIY.dart';
import 'package:velvetvnaity/Admin/UserInfo.dart';
import 'package:velvetvnaity/model/shared_pref_admin.dart'; // Update import if needed

class WebMain extends StatefulWidget {
  const WebMain({Key? key}) : super(key: key);
  static const String id = "WebMain";

  @override
  State<WebMain> createState() => _WebMainState();
}

class _WebMainState extends State<WebMain> {
  Widget selectedScreen = const Dashboard();
  String adminName = 'Admin'; // Default name

  String selectedRoute = Dashboard.id;

  @override
  void initState() {
    super.initState();
    _fetchAdminName();
  }

  Future<void> _fetchAdminName() async {
    final name = await SharedPreferenceHelper().getAdminData();
    if (name != null && name.isNotEmpty) {
      setState(() {
        adminName = name;
      });
    }
  }

  void chooseScreen(String? route) {
    setState(() {
      selectedRoute = route ?? Dashboard.id;
      switch (selectedRoute) {
        case Dashboard.id:
          selectedScreen = const Dashboard();
          break;
        case NotificationPage.id:
          selectedScreen = const NotificationPage();
          break;
        case ContactDetailsListPage.id:
          selectedScreen =  ContactDetailsListPage();
          break;
        case UserDIY.id:
          selectedScreen = const UserDIY();
          break;
        case AddProductPage.id:
          selectedScreen =  AddProductPage();
          break;
        case UserInfo.id:
          selectedScreen = const UserInfo();
          break;
        case RegisteredUsers.id:
          selectedScreen = const RegisteredUsers();
          break;
        case AffiliateListScreen.id:
          selectedScreen = const AffiliateListScreen();
          break;
        case InstallerListScreen.id:
          selectedScreen = const InstallerListScreen();
          break;
        case ProductSummaryPage.id:
          selectedScreen = ProductSummaryPage(totalAmount: 0, cart: [],);
          break;
        case BillingInfoListPage.id:
          selectedScreen =  BillingInfoListPage();
          break;
        case ProductAccess.id:
          selectedScreen = const ProductAccess();
          break;
        default:
          selectedScreen = const Dashboard();
      }
    });
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, '/login'); // Update with your login route
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome, $adminName!",
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Your Control Hub Awaits!",
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () {
            Scaffold.of(context).openDrawer(); // Open the side drawer
          },
        ),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              switch (value) {
                case 'User Panel':
                  Navigator.pushNamed(context, '/userPanel');
                  break;
                case 'About':
                  Navigator.pushNamed(context, '/about');
                  break;
                default:
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return const [
                PopupMenuItem<String>(
                  value: 'User Panel',
                  child: Text('User Panel'),
                ),
                PopupMenuItem<String>(
                  value: 'About',
                  child: Text('About'),
                ),
              ];
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            _buildDrawerItem(icon: Icons.dashboard, title: 'Dashboard', route: Dashboard.id),
            _buildDrawerItem(icon: Icons.notifications, title: 'Manage Notifications', route: NotificationPage.id),
            _buildDrawerItem(icon: Icons.contacts, title: 'Contact Info', route: ContactDetailsListPage.id),
            _buildDrawerItem(icon: Icons.details, title: 'Affiliate Details', route: AffiliateListScreen.id),
            _buildDrawerItem(icon: Icons.data_array, title: 'Installer Details', route: InstallerListScreen.id),
            _buildDrawerItem(icon: Icons.add_box, title: 'Add Product', route: AddProductPage.id),
            _buildDrawerItem(icon: Icons.webhook_sharp, title: 'User DIY', route: UserDIY.id),
            _buildDrawerItem(icon: Icons.person, title: 'Registered Users', route: RegisteredUsers.id),
            _buildDrawerItem(icon: Icons.person, title: 'User Info List', route: UserInfo.id),
            _buildDrawerItem(icon: Icons.shopping_cart, title: 'Placed Orders', route: ProductSummaryPage.id),
            _buildDrawerItem(icon: Icons.receipt, title: 'Billing Info', route: BillingInfoListPage.id),
            _buildDrawerItem(icon: Icons.list_alt, title: 'Product List', route: ProductAccess.id),
          ],
        ),
      ),
      body: AdminScaffold(
        sideBar: SideBar(
          iconColor: const Color(0xFFA80C0C),
          textStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          onSelected: (item) => chooseScreen(item.route),
          items: const [
            AdminMenuItem(title: "Dashboard", icon: Icons.dashboard, route: Dashboard.id),
            AdminMenuItem(title: "Manage Notifications", icon: Icons.notifications, route: NotificationPage.id),
            AdminMenuItem(title: "Contact Info", icon: Icons.contacts, route: ContactDetailsListPage.id),
            AdminMenuItem(title: "Affiliate Details", icon: Icons.details, route: AffiliateListScreen.id),
            AdminMenuItem(title: "Installer Details", icon: Icons.data_array, route: InstallerListScreen.id),
            AdminMenuItem(title: "Add Product", icon: Icons.add_box, route: AddProductPage.id),
            AdminMenuItem(title: "User DIY", icon: Icons.webhook_sharp, route: UserDIY.id),
            AdminMenuItem(title: "Registered Users", icon: Icons.person, route: RegisteredUsers.id),
            AdminMenuItem(title: "User Info List", icon: Icons.person, route: UserInfo.id),
            AdminMenuItem(title: "Placed Orders", icon: Icons.shopping_cart, route: ProductSummaryPage.id),
            AdminMenuItem(title: "Billing Info", icon: Icons.receipt, route: BillingInfoListPage.id),
            AdminMenuItem(title: "Product List", icon: Icons.list_alt, route: ProductAccess.id),
          ],
          selectedRoute: selectedRoute,
          backgroundColor: Colors.white,
          activeTextStyle: const TextStyle(color: Color(0xFFA80C0C)),
        ),
        body: selectedScreen,
      ),
    );
  }

  Widget _buildDrawerItem({required IconData icon, required String title, required String route}) {
    final bool isSelected = route == selectedRoute;
    return ListTile(
      leading: Icon(icon, color: isSelected ? const Color(0xFFA80C0C) : Colors.black),
      title: Text(title, style: TextStyle(color: isSelected ? const Color(0xFFA80C0C) : Colors.black)),
      onTap: () => chooseScreen(route),
    );
  }
}
