import 'package:flutter/material.dart';

class NoteSetting extends StatelessWidget {
  final void Function()? onEdit;
  final void Function()? onDelete;

  NoteSetting({super.key, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => {
            Navigator.of(context).pop(),
            onEdit!(),
          },
          child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.background),
              child: Center(
                  child: Text(
                'Edit',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ))),
        ),
        GestureDetector(
          onTap: () => {
            Navigator.of(context).pop(),
            onDelete!(),
          },
          child: Container(
              height: 50,
              color: Theme.of(context).colorScheme.background,
              child: Center(
                  child: Text(
                'Delete',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ))),
        )
      ],
    );
  }
}
