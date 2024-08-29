import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

import 'note_settings.dart';

class NoteTile extends StatelessWidget {
  final String text;
  final void Function()? onUpdate;
  final void Function()? onDelete;

  NoteTile(
      {super.key,
      required this.text,
      required this.onUpdate,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          title: Text(text),
          trailing: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                showPopover(
                  backgroundColor: Theme.of(context).colorScheme.background,
                  height: 100,
                  width: 100,
                  context: context,
                  bodyBuilder: (context) => NoteSetting(
                    onEdit: onUpdate,
                    onDelete: onDelete,
                  ),
                );
              },
              icon: Icon(Icons.more_vert),
            ),
          ),
        ),
      ),
    );
  }
}

// flutter pub add popover
