import 'package:flutter/material.dart';

class ArrowBackButton extends StatelessWidget {
  const ArrowBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, top: 4),
      child: IconButton(
        icon: const Icon(
          Icons.arrow_left,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}