import 'package:pipeline/features/features.dart';

class FooterTipsWidget extends StatelessWidget {
  const FooterTipsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              "Tap, hold & drag to move task to a new section",
              style: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              "or just",
              style: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
            Text(
              "tap & drag to reorganize task in section",
              style: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      );
}
