import 'package:flutter/material.dart';


class StarRating extends StatefulWidget {

  final double rating;

  StarRating(this.rating);

  @override
  _StarRatingState createState() => _StarRatingState();
}

class _StarRatingState extends State<StarRating> {
  @override
  Widget build(BuildContext context) {

    Widget star(bool fill){
      return Container(
        child: Icon(
          Icons.star,
          size: 18.0,
          color: fill ? Colors.yellow : Colors.grey,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        if(index < (widget.rating / 2).round()){
          return star(true);
        }
        else
          {
            return star(false);
          }
      }),
    );
  }
}
