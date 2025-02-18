import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pipeline/domain/task.dart';

class PipelinePageWidget extends StatefulWidget {
  const PipelinePageWidget({super.key});

  @override
  State<PipelinePageWidget> createState() => _PipelinePageWidgetState();
}

class _PipelinePageWidgetState extends State<PipelinePageWidget> {
  final List<bool> _isExpanded = [true, true, true];
  final List<bool> _isHovered = [false, false, false]; // Track hover state
  late bool _isDragging = false;

  final List<List<Task>> _taskLists = [
    [
      Task('1', '😎', 'Task 1', 'description', '30/02/2029', '25/12/2029',
          '08/03/2029', Colors.red),
      Task('2', '😎', 'Task 2', 'description', '30/02/2029', '25/12/2029',
          '08/03/2029', Colors.green),
      Task('3', '😎', 'Task 3', 'description', '30/02/2029', '25/12/2029',
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
        children: [
          buildExpansionPanel('icebox 🧊', 0),
          buildExpansionPanel('working 🔨', 1),
          buildExpansionPanel('done ✅', 2),
        ],
      ),
    );
  }

  void setExpandedState(int index, bool isExpanded) {
    log("index $index : $isExpanded");
    setState(() {
      _isExpanded[index] = isExpanded;
    });
  }

  ExpansionPanel buildExpansionPanel(String title, int index) {
    return ExpansionPanel(
      headerBuilder: (context, isExpanded) {
        return buildListTitle(title);
      },
      body: buildListBody(index),
      isExpanded: _isExpanded[index],
      canTapOnHeader: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    );
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

  Widget buildListBody(int index) {
    return DragTarget<Task>(
      onWillAcceptWithDetails: (details) {
        setState(() => _isHovered[index] = true);
        return true;
      },
      onLeave: (data) {
        setState(() => _isHovered[index] = false);
      },
      onAcceptWithDetails: (details) {
        _moveTask(details.data, index);
        setState(() => _isHovered[index] = false);
        setState(() => _isDragging = false);
      },
      onMove: (details) {
        setState(() => _isDragging = true);
      },
      builder: (context, candidateData, rejectData) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: buildListBoxes(index),
        child: SizedBox(
          height: _taskLists[index].isEmpty ? 50 : null,
          child: ReorderableListView(
            buildDefaultDragHandles: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            onReorder: (oldIndex, newIndex) {
              setState(() {
                if (newIndex > oldIndex) newIndex--;
                final task = _taskLists[index].removeAt(oldIndex);
                _taskLists[index].insert(newIndex, task);
              });
            },
            children: List.generate(_taskLists[index].length, (taskIndex) {
              final task = _taskLists[index][taskIndex];
              return _buildDraggableTask(index, taskIndex, task);
            }),
          ),
        ),
      ),
    );
  }

  BoxDecoration buildListBoxes(int index) {
    return _isHovered[index]
        ? BoxDecoration(
            color: Colors.blue.withOpacity(0.3),
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(8),
          )
        : _isDragging
            ? BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                border: Border.all(color: Colors.transparent, width: 2),
                borderRadius: BorderRadius.circular(8),
              )
            : BoxDecoration(
                color: Colors.transparent,
                border: Border.all(color: Colors.transparent, width: 2),
                borderRadius: BorderRadius.circular(8),
              );
  }

  Widget _buildDraggableTask(int panelIndex, int taskIndex, Task task) {
    return LongPressDraggable<Task>(
      key: ValueKey(task.id),
      delay: const Duration(milliseconds: 100),
      data: task,
      childWhenDragging: _buildGhostChildContainer(task),
      feedback: _buildFeedbackContainer(task, panelIndex),
      maxSimultaneousDrags: 1,
      child: Stack(
        children: [
          _taskItem(task, taskIndex, panelIndex), // Task UI
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
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
