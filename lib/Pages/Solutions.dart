import 'package:flutter/material.dart';

class Solutions extends StatelessWidget {
  const Solutions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Solutions"),
        backgroundColor: const Color.fromARGB(204, 199, 118, 121),
        centerTitle: true,
      ),
      body: const Center(
        child: Text("Solutions"),
      ),
    );
  }
}
