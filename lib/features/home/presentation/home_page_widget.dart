import 'package:pipeline/features/features.dart';

class HomePageWidget extends StatelessWidget {
  final VoidCallback onThemeToggle;

  const HomePageWidget({super.key, required this.onThemeToggle});

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
      body: const SingleChildScrollView(
        child: Column(
          children: [
            BodyWidget(),
            FooterTipsWidget(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("TODO: add a new task")));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
