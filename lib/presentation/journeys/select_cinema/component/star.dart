import 'package:flutter/material.dart';

class StarComponent extends StatelessWidget {
  const StarComponent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(right: 4),
      child: Icon(
        Icons.star,
        color: Colors.yellow,
        size: 10,
      ),
    );
  }
}