import 'package:flutter/material.dart';
import 'package:task_manager_app/data/model/task_model.dart';
import 'package:task_manager_app/data/services/api_caller.dart';
import 'package:task_manager_app/data/utils/urls.dart';
import 'package:task_manager_app/ui/widgets/centered_Progress_indicator.dart';
import 'package:task_manager_app/ui/widgets/snack_bar_message.dart';

class TaskCard extends StatefulWidget {
  TaskCard({
    super.key,
    required this.bgColor,
    required this.taskModel,
    required this.refreshParent,
  });
  final Color bgColor;
  TaskModel taskModel;
  final VoidCallback refreshParent;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  bool _changeStatusInProgress = false;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: Colors.white,
      title: Text(
        widget.taskModel.title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(widget.taskModel.description),
          Text(
            widget.taskModel.createdDate,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              Chip(
                backgroundColor: widget.bgColor,
                label: Text(widget.taskModel.status),
                labelStyle: TextStyle(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete, color: Colors.red),
              ),
              Visibility(
                visible: _changeStatusInProgress == false,
                replacement: CenteredProgressIndicator(),
                child: IconButton(
                  onPressed: () {
                    _showChangeStatusDialog();
                  },
                  icon: Icon(Icons.edit),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showChangeStatusDialog() {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text('Change Status'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    _changeStatus('New');
                  },
                  title: Text('New'),
                  trailing:
                      widget.taskModel.status == 'New'
                          ? Icon(Icons.done)
                          : null,
                ),
                ListTile(
                  onTap: () {
                    _changeStatus('Progress');
                  },
                  title: Text('Progress'),
                  trailing:
                      widget.taskModel.status == 'Progress'
                          ? Icon(Icons.done)
                          : null,
                ),
                ListTile(
                  onTap: () {
                    _changeStatus('Cancelled');
                  },
                  title: Text('Cancelled'),
                  trailing:
                      widget.taskModel.status == 'Cancelled'
                          ? Icon(Icons.done)
                          : null,
                ),
                ListTile(
                  onTap: () {
                    _changeStatus('Completed');
                  },
                  title: Text('Completed'),
                  trailing:
                      widget.taskModel.status == 'Completed'
                          ? Icon(Icons.done)
                          : null,
                ),
              ],
            ),
          ),
    );
  }

  Future<void> _changeStatus(String status) async {
    _changeStatusInProgress = true;
    setState(() {});
    if (status == widget.taskModel.status) {
      return;
    }
    Navigator.pop(context);
    final ApiResponse response = await ApiCaller.getRequest(
      url: Urls.updateTaskStatusUrl(widget.taskModel.id, status),
    );
    if (response.isSuccess) {
      widget.refreshParent();
    } else {
      showSnackBarMessage(context, response.errorMessage!);
    }
    _changeStatusInProgress = false;
    setState(() {});
  }
}
