import 'package:flutter/material.dart';

import 'package:velvetvnaity/Admin/admin_login.dart';

import 'package:velvetvnaity/main.dart';


class Layoutscreen extends StatelessWidget {
  const Layoutscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 600) {
        return const AdminLogin(); //Adminlogin();
      } else {
        return const SplashScreen();
      }
    });
  }
}
