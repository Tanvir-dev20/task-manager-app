import 'package:flutter/foundation.dart';
import 'package:task_manager_app/data/model/task_model.dart' show TaskModel;

import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';

class CancelledTaskProvider extends ChangeNotifier {
  bool getAllCancelledTaskInProgress = false;
  List<TaskModel> cancelledTaskList = [];
  String? _message;
  String? get message => _message;

  Future<void> getAllCancelledTask() async {
    getAllCancelledTaskInProgress = true;
    notifyListeners();
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.taskListUrl('Cancelled'),
    );
    if (response.isSuccess) {
      List<TaskModel> list = [];
      for (Map<String, dynamic> jsonData in response.responseData['data']) {
        list.add(TaskModel.fromJson(jsonData));
      }
      cancelledTaskList = list;
    } else {
      _message = response.responseData;
    }
    getAllCancelledTaskInProgress = false;
    notifyListeners();
  }
}
