import 'package:flutter/material.dart';

import '../const.dart';

class CalendarDay extends StatefulWidget {
  final String? dayAbbreviation;
  final String dayNumber;
  bool isActive;
  CalendarDay(
      {Key? key,
      required this.dayNumber,
      this.dayAbbreviation,
      this.isActive = false})
      : super(key: key);

  @override
  _CalendarDayState createState() => _CalendarDayState();
}

class _CalendarDayState extends State<CalendarDay> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: InkWell(
        onTap: () {
          setState(() {
            widget.isActive = !widget.isActive;
          });
        },
        child: Container(
          width: 50.0,
          height: 70.0,
          decoration: BoxDecoration(
              color: widget.isActive ? kPimaryColor : null,
              borderRadius: BorderRadius.circular(15.0)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(widget.dayNumber,
                  style: TextStyle(
                      color: widget.isActive ? kBackgroundColor : Colors.white,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold)),
              Text(
                widget.dayAbbreviation!.toUpperCase(),
                style: TextStyle(
                  color: widget.isActive ? kBackgroundColor : Colors.white12,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
