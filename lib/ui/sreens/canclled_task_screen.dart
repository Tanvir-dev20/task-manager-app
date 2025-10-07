import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/centered_Progress_indicator.dart';

import '../../data/model/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CanclledTaskScreen extends StatefulWidget {
  const CanclledTaskScreen({super.key});

  @override
  State<CanclledTaskScreen> createState() => _CanclledTaskScreenState();
}

class _CanclledTaskScreenState extends State<CanclledTaskScreen> {
  bool _getAllCancelledTaskInProgress = false;
  List<TaskModel> _cancelledTaskList = [];
  @override
  initState() {
    super.initState();
    _getAllCancelledTask();
  }

  Future<void> _getAllCancelledTask() async {
    _getAllCancelledTaskInProgress = true;
    setState(() {});
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskListUrl('Cancelled'),
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _cancelledTaskList = list;
    } else {
      showSnackBarMessage(context, response.responseData);
    }
    _getAllCancelledTaskInProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Visibility(
          visible: _getAllCancelledTaskInProgress == false,
          replacement: CenteredProgressIndicator(),
          child: ListView.separated(
            itemCount: _cancelledTaskList.length,
            itemBuilder: (context, index) {
              return TaskCard(
                bgColor: Colors.red,
                taskModel: _cancelledTaskList[index],
                refreshParent: () {
                  _getAllCancelledTask();
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
