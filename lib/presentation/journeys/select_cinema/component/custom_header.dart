import 'package:flutter/material.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({
    Key? key,
    required this.content,
    required this.size,
  }) : super(key: key);

  final String content;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: size.height / 10,
          child: Center(
            child: Text(
              content,
              // style: TxtStyle.heading1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 16, top: 4),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_left,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}