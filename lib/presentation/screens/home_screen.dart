import 'package:flutter/material.dart';
import 'package:pipeline/presentation/widgets/pipeline_page_widget.dart';

import 'footer_tips_widget.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onThemeToggle;

  const HomeScreen({super.key, required this.onThemeToggle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          title: const Text('🌊'),
          actions: [
            Switch(
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {
                // Toggle the theme
                onThemeToggle();
              },
            ),
          ],
        ),
      ),
      body: const Column(
        children: [
          PipelinePageWidget(),
          FooterTipsWidget(),
        ],
      ),
    );
  }
}
