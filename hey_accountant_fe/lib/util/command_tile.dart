import 'package:flutter/material.dart';

class CommandTile extends StatelessWidget {
  final String commandKeyword;
  final bool matchesKeyword;

  const CommandTile({
    super.key,
    required this.commandKeyword,
    required this.matchesKeyword,
  });

  @override
  Widget build(BuildContext context) {
    Color tileColor = Color.fromARGB(211, 90, 90, 90);
    Color textColor = Colors.grey;
    Icon icon = Icon(
      Icons.question_mark_outlined,
      color: textColor,
    );

    if (matchesKeyword) {
      textColor = Colors.white;
      tileColor = Colors.green;
      icon = Icon(
        Icons.check,
        color: textColor,
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: tileColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 12,
            ),
            Column(
              children: [
                // title
                Text(
                  commandKeyword,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
