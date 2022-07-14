// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:movea_app/src/config/app_color.dart';
// import 'package:movea_app/src/config/text_style.dart';
// import 'package:movea_app/src/constants/asset_path.dart';
// import 'package:movea_app/src/modules/selectCinema/select_seat_page.dart';

// import '../../models/movie.dart';
// import 'component/custom_header.dart';
// import 'component/next_button.dart';
// import 'component/select_country.dart';

// class SelectCinemaPage extends StatelessWidget {
//   const SelectCinemaPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             CustomHeader(
//               size: size,
//               content: 'Ralph Breaks the\nInternet',
//             ),
//             SelectCountryWidget(size: size),
//             buildTitle('Choose Date'),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: days
//                     .map((e) => Builder(
//                           builder: (context) => buildDateWidget(size, e),
//                         ))
//                     .toList(),
//               ),
//             ),
//             buildTitle('Central Park CGV'),
//             Container(
//               margin: const EdgeInsets.only(top: 8, bottom: 16),
//               height: size.height / 15,
//               child: ListView.builder(
//                 itemBuilder: (context, index) =>
//                     _buildTimeWidget(size, index, timeStates_1),
//                 itemCount: times.length,
//                 scrollDirection: Axis.horizontal,
//               ),
//             ),
//             buildTitle('FX Sudirman XXI'),
//             Container(
//               margin: const EdgeInsets.only(top: 8, bottom: 16),
//               height: size.height / 15,
//               child: ListView.builder(
//                 itemBuilder: (context, index) =>
//                     _buildTimeWidget(size, index, timeStates_2),
//                 itemCount: times.length,
//                 scrollDirection: Axis.horizontal,
//               ),
//             ),
//             buildTitle('Kelapa Gading IMAX'),
//             Container(
//               margin: const EdgeInsets.only(top: 8, bottom: 16),
//               height: size.height / 15,
//               child: ListView.builder(
//                 itemBuilder: (context, index) =>
//                     _buildTimeWidget(size, index, timeStates_3),
//                 itemCount: times.length,
//                 scrollDirection: Axis.horizontal,
//               ),
//             ),
//             NextButton(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const SelectSeatPage()));
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Container buildDateWidget(Size size, String e) {
//     return Container(
//       height: size.height / 8,
//       width: size.width / 5,
//       decoration: BoxDecoration(
//           color: _getColor(dateStates[days.indexOf(e)]),
//           borderRadius: BorderRadius.circular(12)),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             e,
//             style: TxtStyle.heading3Medium,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 4.0),
//             child: Text(
//               (20 + days.indexOf(e)).toString(),
//               style: TxtStyle.heading3Medium,
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   Container _buildTimeWidget(Size size, int index, List<TicketStates> states) {
//     return Container(
//       margin: const EdgeInsets.only(left: 24),
//       width: size.width / 4,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//           color: _getColor(states[index]),
//           borderRadius: BorderRadius.circular(14)),
//       child: Text(
//         times[index],
//         style: TxtStyle.heading3Medium,
//       ),
//     );
//   }

//   Color _getColor(TicketStates state) {
//     switch (state) {
//       case TicketStates.idle:
//         {
//           return DarkTheme.darkBackground;
//         }
//       case TicketStates.active:
//         {
//           return DarkTheme.blueMain;
//         }
//       case TicketStates.busy:
//         {
//           return DarkTheme.greyBackground;
//         }
//     }
//   }

//   Container buildTitle(String content) {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
//       child: Text(
//         content,
//         style: TxtStyle.heading2,
//       ),
//     );
//   }
// }