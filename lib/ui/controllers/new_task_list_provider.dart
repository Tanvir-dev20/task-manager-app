import 'package:flutter/widgets.dart';

import '../../data/model/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class NewTaskListProvider extends ChangeNotifier {
  bool _getAllNewTaskInProgress = false;
  bool get getAllNewTaskInProgress => _getAllNewTaskInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  List<TaskModel> _newTaskList = [];
  List<TaskModel> get newTaskList => _newTaskList;

  Future<bool> getAllNewTask() async {
    bool isSuccess = false;
    _getAllNewTaskInProgress = true;
    notifyListeners();
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskListUrl('New'),
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _newTaskList = list;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _getAllNewTaskInProgress = false;
    notifyListeners();
    return isSuccess;
  }
}
