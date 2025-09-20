import 'package:flutter/material.dart';

import '../widgets/task_card.dart';

class CanclledTaskScreen extends StatefulWidget {
  const CanclledTaskScreen({super.key});

  @override
  State<CanclledTaskScreen> createState() => _CanclledTaskScreenState();
}

class _CanclledTaskScreenState extends State<CanclledTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.separated(
          itemCount: 10,
          itemBuilder: (context, index) {
            return TaskCard(status: 'Canclled', bgColor: Colors.red);
          },
          separatorBuilder: (context, index) {
            return SizedBox(height: 8);
          },
        ),
      ),
    );
  }
}
