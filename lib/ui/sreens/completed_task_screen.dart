import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/centered_Progress_indicator.dart';

import '../../data/model/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  bool _getAllCompletedTaskInProgress = false;
  List<TaskModel> _completedTaskList = [];

  @override
  initState() {
    super.initState();
    _getAllCompletedTask();
  }

  Future<void> _getAllCompletedTask() async {
    _getAllCompletedTaskInProgress = true;
    setState(() {});
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskListUrl('Completed'),
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _completedTaskList = list;
    } else {
      showSnackBarMessage(context, response.responseData);
    }
    _getAllCompletedTaskInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Visibility(
          visible: _getAllCompletedTaskInProgress == false,
          replacement: CenteredProgressIndicator(),
          child: ListView.separated(
            itemCount: _completedTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                bgColor: Colors.green,
                taskModel: _completedTaskList[index],
                refreshParent: () {
                  _getAllCompletedTask();
                },
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(height: 8);
            },
          ),
        ),
      ),
    );
  }
}
