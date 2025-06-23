import 'package:pipeline/features/features.dart';

class BodyWidget extends StatefulWidget {
  const BodyWidget({super.key});

  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {
  late bool _isDraggingTask = false;
  final List<Section> sections = [
    Section(0, 'icebox 🧊', true, false),
    Section(1, 'working 🔨', true, false),
    Section(2, 'done ✅', true, false),
  ];
  final List<List<Task>> _taskLists = [
    [
      Task('1', '😎', 'Task 1', 'description', '30/02/2029', '25/12/2029',
          '08/03/2029', Colors.red),
      Task('2', '😎', 'Task 2', 'description', '30/02/2029', '25/12/2029',
          '08/03/2029', Colors.green),
      Task('101', '😎', 'Task 3', 'description', '30/02/2029', '25/12/2029',
          '08/03/2029', Colors.blue)
    ], // Icebox
    [
      Task('4', '😎', 'Task 4', 'description', '30/02/2029', '25/12/2029',
          '08/03/2029', Colors.redAccent),
      Task('5', '😎', 'Task 5', 'description', '30/02/2029', '25/12/2029',
          '08/03/2029', Colors.greenAccent),
      Task('6', '😎', 'Task 6', 'description', '30/02/2029', '25/12/2029',
          '08/03/2029', Colors.blueAccent)
    ], // Working
    [
      Task('7', '😎', 'Task 7', 'description', '30/02/2029', '25/12/2029',
          '08/03/2029', Colors.orange),
      Task('8', '😎', 'Task 8', 'description', '30/02/2029', '25/12/2029',
          '08/03/2029', Colors.lightGreen)
    ] // Done
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList(
        expansionCallback: setExpandedState,
        expandedHeaderPadding: EdgeInsets.zero,
        dividerColor: Theme.of(context).primaryColorLight,
        materialGapSize: 0.0,
        children: buildExpansionPanel(sections),
      ),
    );
  }

  void setExpandedState(int itemListIndex, bool isExpanded) {
    debugPrint("index $itemListIndex : $isExpanded");
    setState(() {
      sections[itemListIndex].isExpanded = isExpanded;
    });
  }

  List<ExpansionPanel> buildExpansionPanel(List<Section> sections) {
    List<ExpansionPanel> expansionPanels = [];
    for (var element in sections) {
      final panel = ExpansionPanel(
        headerBuilder: (context, isExpanded) {
          return buildListTitle(element.title);
        },
        body: buildListBody(element.id),
        isExpanded: element.isExpanded,
        canTapOnHeader: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      );
      expansionPanels.add(panel);
    }

    return expansionPanels;
  }

  Padding buildListTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(fontSize: 20.0),
        ),
      ),
    );
  }

  Widget buildListBody(int sectionIndex) {
    return DragTarget<Task>(
      onWillAcceptWithDetails: (details) {
        setState(() => sections[sectionIndex].isHovered = true);
        return true;
      },
      onLeave: (data) {
        setState(() => sections[sectionIndex].isHovered = false);
      },
      onAcceptWithDetails: (details) {
        _moveTask(details.data, sectionIndex);
        setState(() => sections[sectionIndex].isHovered = false);
        setState(() => _isDraggingTask = false);
      },
      onMove: (details) {
        setState(() => _isDraggingTask = true);
      },
      builder: (context, candidateData, rejectData) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: buildListBoxes(sectionIndex),
        child: SizedBox(
          height: _taskLists[sectionIndex].isEmpty ? 50 : null,
          child: ReorderableListView(
            buildDefaultDragHandles: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            onReorderStart: (oldIndex) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                      "Reorganizing ${sections[sectionIndex].title} section...")));
            },
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex--;
                final task = _taskLists[sectionIndex].removeAt(oldIndex);
                _taskLists[sectionIndex].insert(newIndex, task);
              });
            },
            onReorderEnd: (newIndex) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            children:
                List.generate(_taskLists[sectionIndex].length, (taskIndex) {
              final task = _taskLists[sectionIndex][taskIndex];
              return _buildDraggableTask(sectionIndex, taskIndex, task);
            }),
          ),
        ),
      ),
    );
  }

  BoxDecoration buildListBoxes(int index) {
    var opacity = Colors.transparent;
    var border = Colors.transparent;
    if (sections[index].isHovered) {
      opacity = Colors.blue.withOpacity(0.3);
      border = Colors.blue;
    } else if (_isDraggingTask) {
      opacity = Colors.blue.withOpacity(0.1);
    }

    return BoxDecoration(
      color: opacity,
      border: Border.all(color: border, width: 2),
      borderRadius: BorderRadius.circular(8),
    );
  }

  Widget _buildDraggableTask(int sectionIndex, int taskIndex, Task task) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return LongPressDraggable<Task>(
      key: ValueKey(task.id),
      delay: const Duration(milliseconds: 100),
      data: task,
      childWhenDragging: _buildGhostChildContainer(task),
      feedback: _buildFeedbackContainer(task, sectionIndex),
      maxSimultaneousDrags: 1,
      onDragStarted: () {
        scaffoldMessenger.clearSnackBars();
        scaffoldMessenger.showSnackBar(
            const SnackBar(content: Text("Moving to a new section...")));
      },
      onDragCompleted: () {
        scaffoldMessenger.clearSnackBars();
        scaffoldMessenger.showSnackBar(SnackBar(
            content:
                Text("Moved from ${sections[sectionIndex].title} section")));
      },
      onDraggableCanceled: (vel, offset) {
        scaffoldMessenger.clearSnackBars();
        scaffoldMessenger
            .showSnackBar(const SnackBar(content: Text("Moving canceled")));
      },
      child: Stack(
        children: [
          _taskItem(task, taskIndex, sectionIndex), // Task UI
        ],
      ),
    );
  }

  Widget _buildFeedbackContainer(Task task, int panelIndex) {
    return Material(
      type: MaterialType.transparency, // Ensures consistent styling
      child: _buildTaskContainer(task, panelIndex),
    );
  }

  Widget _buildGhostChildContainer(Task task) =>
      Opacity(opacity: 0.3, child: _buildTaskContainer(task, 0));

  Widget _taskItem(Task task, int taskIndex, int panelIndex) {
    return ReorderableDragStartListener(
      index: taskIndex,
      key: ValueKey(task.id),
      child: _buildTaskContainer(task, panelIndex),
    );
  }

  Widget _buildTaskContainer(Task task, int panelIndex) {
    return Container(
      key: ValueKey(task.id),
      height: 50,
      width: 400,
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        color: task.color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                task.emoji,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 8,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  task.title,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: ListView(
                children: [
                  Center(
                    child: Text(
                      "▶️ ${task.startDate}",
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                  Center(
                    child: Text(
                      panelIndex == 2
                          ? "🏁 ${task.actualEndDate}"
                          : "🥅 ${task.goalEndDate}",
                      style: const TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _moveTask(Task task, int toPanel) {
    setState(() {
      final fromPanel = _taskLists.indexWhere((list) => list.contains(task));

      if (fromPanel != -1 && fromPanel != toPanel) {
        _taskLists[fromPanel].remove(task);
        _taskLists[toPanel].add(task);
      }
    });
  }
}
