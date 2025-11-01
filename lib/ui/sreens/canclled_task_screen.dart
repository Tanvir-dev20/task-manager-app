import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_manager_app/ui/controllers/cancelled_task_provider.dart';
import 'package:task_manager_app/ui/widgets/centered_Progress_indicator.dart';

import '../../data/model/task_model.dart';
import '../../data/services/api_caller.dart';
import '../../data/utils/urls.dart';
import '../widgets/snack_bar_message.dart';
import '../widgets/task_card.dart';

class CanclledTaskScreen extends StatefulWidget {
  const CanclledTaskScreen({super.key});

  @override
  State<CanclledTaskScreen> createState() => _CanclledTaskScreenState();
}

class _CanclledTaskScreenState extends State<CanclledTaskScreen> {
  final CancelledTaskProvider cancelledTaskProvider = CancelledTaskProvider();
  @override
  initState() {
    super.initState();
    cancelledTaskProvider.getAllCancelledTask();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => cancelledTaskProvider,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<CancelledTaskProvider>(
            builder: (context, cancelledTaskProvider, _) {
              return Visibility(
                visible:
                    cancelledTaskProvider.getAllCancelledTaskInProgress ==
                    false,
                replacement: CenteredProgressIndicator(),
                child: ListView.separated(
                  itemCount: cancelledTaskProvider.cancelledTaskList.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      bgColor: Colors.red,
                      taskModel: cancelledTaskProvider.cancelledTaskList[index],
                      refreshParent: () {
                        cancelledTaskProvider.getAllCancelledTask();
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
