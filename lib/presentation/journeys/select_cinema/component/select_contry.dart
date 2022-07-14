import 'package:flutter/material.dart';


class SelectCountryWidget extends StatelessWidget {
  const SelectCountryWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      height: size.height / 14,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white)),
      child: Row(
        children: const [
          Expanded(
              child: TextField(
            decoration: InputDecoration(
                hintText: 'Select Your Contry',
                // hintStyle: TextStyle(color: Colors.accents),
                icon: Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Icon(
                   Icons.add,
                    color: Colors.white,
                  ),
                )),
          )),
          Padding(
            padding: EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.keyboard_arrow_down,
              size: 36,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}