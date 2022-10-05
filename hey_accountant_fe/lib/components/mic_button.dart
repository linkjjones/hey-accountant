import 'package:flutter/material.dart';

class MicButton extends StatelessWidget {
  final Function startRun;
  final Function stopRun;
  final bool isRunning;
  const MicButton({
    super.key,
    required this.startRun,
    required this.stopRun,
    required this.isRunning,
  });

  changeRunState() {
    isRunning ? stopRun : startRun;
  }

  @override
  Widget build(BuildContext context) {
    return
    Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6.0,
            spreadRadius: 0.0,
          )
        ],
      ),
      margin: const EdgeInsets.only(right: 22, bottom: 22),
      child: ClipOval(
        child: Material(
          color: isRunning ? Colors.red : Colors.green,
          child: InkWell(
            onTap: () { print('callingback'); },
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Icon(
                Icons.mic,
                size: 33,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
