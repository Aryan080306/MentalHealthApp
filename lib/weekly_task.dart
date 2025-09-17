import 'package:flutter/material.dart';

class TaskItem {
  String description;
  bool completed;

  TaskItem({required this.description, required this.completed});

  void toggleCompleted() {
    completed = !completed;
  }
}

class WeeklyTaskScreen extends StatefulWidget {
  const WeeklyTaskScreen({super.key});

  @override
  _WeeklyTaskScreenState createState() => _WeeklyTaskScreenState();
}

class _WeeklyTaskScreenState extends State<WeeklyTaskScreen> {
  List<TaskItem> tasks = []; // List of TaskItems

  @override
  void initState() {
    super.initState();
    // Initializing some sample tasks
    tasks = [
      TaskItem(description: 'Task 1', completed: false),
      TaskItem(description: 'Task 2', completed: false),
    ];
  }

  void addTask(String newTask) {
    setState(() {
      tasks.add(TaskItem(description: newTask, completed: false));
    });
  }

  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index].toggleCompleted(); // Toggle the completion status
      if (tasks[index].completed) {
        showCongratulations();
      }
    });
  }

  void showCongratulations() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: const Text('You completed a task!'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Tasks'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Here is your weekly list, you can write any tasks you would like to complete by the end of the week.',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(tasks[index].description),
                  value: tasks[index].completed,
                  onChanged: (value) {
                    toggleTask(index);
                  },
                  secondary: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      removeTask(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              String newTask = '';

              return AlertDialog(
                title: const Text('Add Task'),
                content: TextField(
                  onChanged: (value) {
                    newTask = value;
                  },
                  decoration: const InputDecoration(hintText: 'Enter task'),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (newTask.isNotEmpty) {
                        addTask(newTask);
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
