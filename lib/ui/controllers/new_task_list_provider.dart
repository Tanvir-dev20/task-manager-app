import 'package:flutter/widgets.dart';

import '../../data/model/task_model.dart';
import '../../data/model/task_status_count_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class NewTaskListProvider extends ChangeNotifier {
  bool _getAllNewTaskInProgress = false;
  bool get getAllNewTaskInProgress => _getAllNewTaskInProgress;

  bool _getAllTaskStatusCountInProgress = false;
  bool get getAllTaskStatusCountInProgress => _getAllTaskStatusCountInProgress;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<TaskStatusCountModel> _taskStatusCountList = [];
  List<TaskStatusCountModel> get taskStatusCountList => _taskStatusCountList;

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

  Future<bool> getAllTaskStatusCount() async {
    bool isSuccess = false;
    _getAllTaskStatusCountInProgress = true;
    notifyListeners();
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskStatusCountUrl,
    );
    if (response.isSuccess) {
      List<TaskStatusCountModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskStatusCountModel.toJson(jsonData));
      }
      _taskStatusCountList = list;
      _getAllTaskStatusCountInProgress = false;
      notifyListeners();
      return isSuccess = true;
    } else {
      _getAllTaskStatusCountInProgress = false;
      notifyListeners();
      return isSuccess;
    }
  }
}
