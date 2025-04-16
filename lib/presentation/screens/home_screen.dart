import 'package:flutter/material.dart';
import 'package:pipeline/presentation/screens/add_task_button_widget.dart';
import 'package:pipeline/presentation/widgets/pipeline_page_widget.dart';

import 'footer_tips_widget.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onThemeToggle;

  const HomeScreen({super.key, required this.onThemeToggle});

  //TODO: Settings menu:
  //      [ ] Toggle nightmode
  //      [ ] Manage sections (number & naming)
  //      [ ] Import/Export JSON file
  //TODO: Task fullscreen view
  //TODO: Task preview
  //TODO: Read tasks info from JSON file
  //TODO: Add a task
  //TODO: Update a task
  //TODO: Delete a task (by swiping right or via trash can icon in the preview & fullscreen modes)
  //TODO: Archive task (by swiping left or via archive icon in the preview & fullscreen modes)
  //TODO: Remove Windows Native navbar
  //TODO: Timer / Time Sheet feature

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
      body: const Stack(
        children: [
          Column(
            children: [
              PipelinePageWidget(),
              FooterTipsWidget(),
            ],
          ),
          AddTaskButtonWidget(),
        ],
      ),
    );
  }
}
