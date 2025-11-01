import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/ui/controllers/completed_task_provider.dart';
import 'package:task_manager_app/ui/widgets/centered_Progress_indicator.dart';

import '../widgets/task_card.dart';

class CompletedTaskScreen extends StatefulWidget {
  const CompletedTaskScreen({super.key});

  @override
  State<CompletedTaskScreen> createState() => _CompletedTaskScreenState();
}

class _CompletedTaskScreenState extends State<CompletedTaskScreen> {
  final CompletedTaskProvider completedTaskProvider = CompletedTaskProvider();

  @override
  initState() {
    super.initState();
    completedTaskProvider.getAllCompletedTask();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => completedTaskProvider,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<CompletedTaskProvider>(
            builder: (context, completedTaskProvider, _) {
              return Visibility(
                visible:
                    completedTaskProvider.getAllCompletedTaskInProgress ==
                    false,
                replacement: CenteredProgressIndicator(),
                child: ListView.separated(
                  itemCount: completedTaskProvider.completedTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      bgColor: Colors.green,
                      taskModel: completedTaskProvider.completedTaskList[index],
                      refreshParent: () {
                        completedTaskProvider.getAllCompletedTask();
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 8);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
