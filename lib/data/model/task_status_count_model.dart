class TaskStatusCountModel {
  final String id;
  final int count;
  TaskStatusCountModel({required this.id, required this.count});

  factory TaskStatusCountModel.toJson(Map<String, dynamic> jsonData) {
    return TaskStatusCountModel(id: jsonData['_id'], count: jsonData['sum']);
  }
}
