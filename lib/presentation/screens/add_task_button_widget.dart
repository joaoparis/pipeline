import 'package:flutter/material.dart';

class AddTaskButtonWidget extends StatelessWidget {
  const AddTaskButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Align(
          alignment: Alignment.bottomRight,
          child: IconButton.filled(
            icon: const Icon(Icons.add),
            tooltip: 'Add task',
            onPressed: () {
              showBottomSheet(
                context: context,
                enableDrag: true,
                builder: (context) {
                  return const SizedBox(
                    height: double.maxFinite,
                    child: Center(child: Text("TODO: Add a new task")),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
