import 'package:flutter/material.dart';

class TaskItem {
  String description;
  bool completed;

  TaskItem({required this.description, required this.completed});

  void toggleCompleted() {
    completed = !completed;
  }
}

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<TaskItem> tasks = []; // List of TaskItems

  @override
  void initState() {
    super.initState();
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

  // Creates more of the UI of the app
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Tasks'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Display a message providing instructions for the daily task list.
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Here is your daily list, you can write any tasks you would like to complete by the end of the day or any tasks you would like in your daily routine.',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          // Displays a list of the tasks
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(tasks[index].description),
                  // Assigns the completed status of the task to the checkbox
                  value: tasks[index].completed,
                  onChanged: (value) {
                    toggleTask(index);
                  },
                  // creates delete icon that when pressed deletes the task
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
