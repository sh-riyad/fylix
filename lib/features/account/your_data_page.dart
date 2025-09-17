import 'package:flutter/material.dart';

class YourDataPage extends StatelessWidget {
  const YourDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your data in Fylix')),
      body: const Center(
        child: Text('Your data controls and transparency info go here.'),
      ),
    );
  }
}


