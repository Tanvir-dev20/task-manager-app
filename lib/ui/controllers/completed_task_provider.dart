import 'package:flutter/widgets.dart';

import '../../data/model/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class CompletedTaskProvider extends ChangeNotifier {
  bool getAllCompletedTaskInProgress = false;
  List<TaskModel> completedTaskList = [];
  String? _message;
  String? get message => _message;

  Future<void> getAllCompletedTask() async {
    getAllCompletedTaskInProgress = true;
    notifyListeners();
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskListUrl('Completed'),
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      completedTaskList = list;
    } else {
      _message = response.responseData;
    }
    getAllCompletedTaskInProgress = false;
    notifyListeners();
  }
}
