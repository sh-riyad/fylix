import 'package:flutter/material.dart';

class HelpFeedbackPage extends StatelessWidget {
  const HelpFeedbackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help and feedback')),
      body: const Center(
        child: Text('Help articles and feedback form go here.'),
      ),
    );
  }
}


