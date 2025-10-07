class Urls {
  static const String _baseUrl = 'http://35.73.30.144:2005/api/v1';
  static const String registrationUrl = '$_baseUrl/Registration';
  static const String logInUrl = '$_baseUrl/Login';
  static const String addNewTaskUrl = '$_baseUrl/createTask';
  static const String taskStatusCountUrl = '$_baseUrl/taskStatusCount';
  static String taskListUrl(String status) =>
      '$_baseUrl/listTaskByStatus/$status';

  static String updateTaskStatusUrl(String id, String newStatus) =>
      '$_baseUrl/updateTaskStatus/$id/$newStatus';

  static String deleteTaskUrl(String id) => '$_baseUrl/deleteTask/$id';
}
