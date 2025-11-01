import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/ui/controllers/new_task_list_provider.dart';
import 'package:task_manager_app/ui/sreens/add_new_task_screen.dart';
import 'package:task_manager_app/ui/widgets/centered_Progress_indicator.dart';

import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  void initState() {
    super.initState();
    context.read<NewTaskListProvider>().getAllNewTask();
    context.read<NewTaskListProvider>()..getAllTaskStatusCount();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewTaskListProvider>(
      builder: (context, newTaskListProvider, _) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                SizedBox(
                  height: 100,
                  child: Visibility(
                    visible:
                        newTaskListProvider.getAllTaskStatusCountInProgress ==
                        false,
                    replacement: CenteredProgressIndicator(),
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: newTaskListProvider.taskStatusCountList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TaskCountByStatusCard(
                          count:
                              newTaskListProvider
                                  .taskStatusCountList[index]
                                  .count,
                          title:
                              newTaskListProvider.taskStatusCountList[index].id,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(width: 4);
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Visibility(
                    visible:
                        newTaskListProvider.getAllNewTaskInProgress == false,
                    replacement: CenteredProgressIndicator(),
                    child: ListView.separated(
                      itemCount: newTaskListProvider.newTaskList.length,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          bgColor: Colors.blue,
                          taskModel: newTaskListProvider.newTaskList[index],
                          refreshParent: () {
                            newTaskListProvider.getAllNewTask();
                            newTaskListProvider.getAllTaskStatusCount();
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 8);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          floatingActionButton: FloatingActionButton(
            onPressed: () => _onTapAddNewTaskButton(),
            child: Icon(Icons.add),
          ),
        );
      },
    );
  }

  void _onTapAddNewTaskButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddNewTaskScreen()),
    );
  }
}
