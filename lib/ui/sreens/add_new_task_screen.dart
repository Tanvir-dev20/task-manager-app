import 'package:flutter/material.dart';
import 'package:task_manager_app/ui/widgets/screen_background.dart';
import 'package:task_manager_app/ui/widgets/tm_appbar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});
  static const String name = '/add-new-task';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                const SizedBox(height: 15),
                Text(
                  'Add New Task',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                TextFormField(
                  controller: _subjectTEController,
                  decoration: InputDecoration(hintText: 'Subject'),
                ),
                TextFormField(
                  controller: _descriptionTEController,
                  decoration: InputDecoration(hintText: 'Description'),
                  maxLines: 4,
                ),
                const SizedBox(height: 10),
                FilledButton(
                  onPressed: _onTapAddButton,
                  child: Icon(Icons.arrow_circle_right_outlined),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapAddButton() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _subjectTEController.dispose();
    _descriptionTEController.dispose();
  }
}
