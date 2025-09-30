import 'package:flutter/material.dart';
import 'package:task_manager_app/data/model/task_status_count_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/sreens/add_new_task_screen.dart';
import 'package:task_manager_app/ui/widgets/centered_Progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';

import '../widgets/task_card.dart';
import '../widgets/task_count_by_status_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  bool _getAllTaskStatusCountInProgress = false;
  List<TaskStatusCountModel> _taskStatusCountList = [];

  @override
  void initState() {
    super.initState();
    _getAllTaskStatusCount();
  }

  Future<void> _getAllTaskStatusCount() async {
    _getAllTaskStatusCountInProgress = true;
    setState(() {});

    setState(() {});
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskStatusCountUrl,
    );
    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskStatusCountModel.toJson(jsonData));
      }
      _taskStatusCountList = list;
    } else {
      showSnackBarMessage(context, response.responseData);
    }
    _getAllTaskStatusCountInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: Visibility(
                visible: _getAllTaskStatusCountInProgress == false,
                replacement: CenteredProgressIndicator(),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _taskStatusCountList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TaskCountByStatusCard(
                      count: _taskStatusCountList[index].count,
                      title: _taskStatusCountList[index].id,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(width: 4);
                  },
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return TaskCard(status: 'New', bgColor: Colors.blue);
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 8);
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _onTapAddNewTaskButton,
        child: Icon(Icons.add),
      ),
    );
  }

  void _onTapAddNewTaskButton() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddNewTaskScreen()),
    );
  }
}
