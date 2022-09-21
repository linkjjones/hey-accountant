import 'package:flutter/material.dart';

class MicButton extends StatelessWidget {
  const MicButton({super.key});

  @override
  Widget build(BuildContext context) {
    return
    Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 6.0,
            spreadRadius: 0.0,
          )
        ],
      ),
      margin: const EdgeInsets.only(right: 20, bottom: 20),
      child: ClipOval(
        child: Material(
          elevation: 30,
          color: Colors.green,
          child: InkWell(
            onTap: () {},
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
