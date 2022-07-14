import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final VoidCallback onTap;
  const NextButton({
    Key? key,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: ElevatedButton(
        onPressed: onTap,
        child: const Icon(
          Icons.home,
          color: Colors.white,
          size: 30,
        ),
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            primary: Colors.blue),
      ),
    );
  }
}