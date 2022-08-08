import 'package:intl/intl.dart';

class TicketData {
  final String number;
  final int seat;
  final DateTime dateTime;
  final String movie;

  String get formattedDate => DateFormat('dd/MM/yy').format(dateTime);

  String get formattedTime => DateFormat('kk:mm').format(dateTime);

  TicketData({required this.number,required  this.movie, required this.seat,required  this.dateTime});
}
