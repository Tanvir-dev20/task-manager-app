import 'package:flutter/material.dart';

import '../../data/model/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class ProgressTaskProvider extends ChangeNotifier {
  bool getAllProgressTaskInProgress = false;
  List<TaskModel> _progressTaskList = [];
  List<TaskModel> get progressTaskList => _progressTaskList;

  String? _message;
  String? get message => _message;
  Future<void> getAllProgressTask() async {
    getAllProgressTaskInProgress = true;
    notifyListeners();
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskListUrl('Progress'),
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      _progressTaskList = list;
    } else {
      _message = response.responseData;
    }
    getAllProgressTaskInProgress = false;
    notifyListeners();
  }
}
