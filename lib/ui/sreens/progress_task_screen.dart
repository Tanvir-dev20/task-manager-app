import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/ui/controllers/progress_task_provider.dart';
import 'package:task_manager_app/ui/widgets/centered_Progress_indicator.dart';

import '../widgets/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  final ProgressTaskProvider progressTaskProvider = ProgressTaskProvider();

  @override
  void initState() {
    super.initState();
    progressTaskProvider.getAllProgressTask();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => progressTaskProvider,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<ProgressTaskProvider>(
            builder: (context, progressTaskProvider, _) {
              return Visibility(
                visible:
                    progressTaskProvider.getAllProgressTaskInProgress == false,
                replacement: CenteredProgressIndicator(),
                child: ListView.separated(
                  itemCount: progressTaskProvider.progressTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      bgColor: Colors.purple,
                      taskModel: progressTaskProvider.progressTaskList[index],
                      refreshParent: () {
                        progressTaskProvider.getAllProgressTask();
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
