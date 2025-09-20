import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  TaskCard({super.key, required this.status, required this.bgColor});
  final String status;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      tileColor: Colors.white,
      title: Text(
        'Title will be here',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text('Description of task'),
          Text(
            'Date : 10/9/2025',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
          Row(
            children: [
              Chip(
                backgroundColor: bgColor,
                label: Text(status),
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
              IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
            ],
          ),
        ],
      ),
    );
  }
}
