import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/common/constants/size_constants.dart';
import 'package:movieapp/common/screenutil/screenutil.dart';
import 'package:movieapp/data/core/api_constants.dart';
import 'package:movieapp/presentation/journeys/buy_ticket/check_out_page.dart';
import 'package:movieapp/presentation/themes/theme_color.dart';
import 'components/calendar_day.dart';
import 'components/cienma_seat.dart';
import 'components/show_time.dart';
import '../../../common/constants/size_constants.dart';
import '../../../common/extensions/size_extensions.dart';

class BuyTicket extends StatefulWidget {
  final title;
  final path;

  const BuyTicket(this.title, this.path, {Key? key}) : super(key: key);

  @override
  _BuyTicketState createState() => _BuyTicketState();
}

class _BuyTicketState extends State<BuyTicket> {
  int total = 0;
  int numberSeat = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.vulcan,
      body: SafeArea(
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: Sizes.dimen_12.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        flex: 1,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Sizes.dimen_16.w),
                          ),
                          elevation: 3,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(Sizes.dimen_16.w),
                            child: CachedNetworkImage(
                              imageUrl:
                                  '${ApiConstants.BASE_IMAGE_URL}${widget.path}',
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          widget.title,
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.5,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25.0),
                          topLeft: Radius.circular(25.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CalendarDay(
                                dayNumber: '9',
                                dayAbbreviation: 'TH',
                              ),
                              CalendarDay(
                                dayNumber: '10',
                                dayAbbreviation: 'FR',
                              ),
                              CalendarDay(
                                dayNumber: '11',
                                dayAbbreviation: 'SA',
                              ),
                              CalendarDay(
                                dayNumber: '12',
                                dayAbbreviation: 'SU',
                                isActive: true,
                              ),
                              CalendarDay(
                                dayNumber: '13',
                                dayAbbreviation: 'MO',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        ShowTime(
                          time: '11:00',
                          price: 45000,
                          isActive: false,
                        ),
                        ShowTime(
                          time: '12:30',
                          price: 45000,
                          isActive: true,
                        ),
                        ShowTime(
                          time: '12:30',
                          price: 45000,
                          isActive: false,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        const Icon(
                          Icons.tv,
                          color: AppColor.royalBlue,
                          size: 25.0,
                        ),
                        const SizedBox(width: 20.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Rạp chiếu phim Quốc Gia'),
                              const Text('87 P.Láng Hạ, Q. Đống Đa, Hà Nội',
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white30, fontSize: 18.0)),
                              const SizedBox(height: 10.0),
                              Row(
                                children: <Widget>[
                                  Text('2D'),
                                  const SizedBox(width: 10.0),
                                  const Text('3D',
                                      style: TextStyle(
                                          color: Colors.white30,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold)),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(width: 20.0),
                        const Icon(
                          Icons.keyboard_arrow_right,
                          size: 30.0,
                          color: Colors.white38,
                        )
                      ],
                    ),
                  ),
                  Center(child: Image.asset('assets/pngs/screen.png')),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // First Seat Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: (MediaQuery.of(context).size.width / 20),
                            ),
                            CienmaSeat(),
                            CienmaSeat(),
                            CienmaSeat(),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width / 20) * 2,
                            ),
                            CienmaSeat(),
                            CienmaSeat(),
                            CienmaSeat(),
                            SizedBox(
                              width: (MediaQuery.of(context).size.width / 20),
                            ),
                          ],
                        ),
                        // Second Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CienmaSeat(),
                            CienmaSeat(),
                            CienmaSeat(),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width / 20) * 2,
                            ),
                            CienmaSeat(
                              isReserved: true,
                            ),
                            CienmaSeat(),
                            CienmaSeat(),
                          ],
                        ),
                        // Third  Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CienmaSeat(),
                            CienmaSeat(),
                            CienmaSeat(),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width / 20) * 2,
                            ),
                            CienmaSeat(),
                            CienmaSeat(
                              isReserved: true,
                            ),
                            CienmaSeat(
                              isReserved: true,
                            ),
                          ],
                        ),
                        // 4TH Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CienmaSeat(),
                            CienmaSeat(),
                            CienmaSeat(),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width / 20) * 2,
                            ),
                            CienmaSeat(
                              isReserved: true,
                            ),
                            CienmaSeat(),
                            CienmaSeat(),
                          ],
                        ),
                        // 5TH Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CienmaSeat(),
                            CienmaSeat(),
                            CienmaSeat(),
                            CienmaSeat(),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width / 20) * 2,
                            ),
                            CienmaSeat(),
                            CienmaSeat(),
                            CienmaSeat(),
                            CienmaSeat(),
                          ],
                        ),
                        // 6TH Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            CienmaSeat(),
                            CienmaSeat(),
                            CienmaSeat(),
                            CienmaSeat(),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width / 20) * 2,
                            ),
                            CienmaSeat(),
                            CienmaSeat(),
                            CienmaSeat(),
                            CienmaSeat(),
                          ],
                        ),
                        // final Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: (MediaQuery.of(context).size.width / 20),
                            ),
                            CienmaSeat(),
                            CienmaSeat(),
                            CienmaSeat(),
                            SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width / 20) * 2,
                            ),
                            CienmaSeat(),
                            CienmaSeat(),
                            CienmaSeat(),
                            SizedBox(
                              width: (MediaQuery.of(context).size.width / 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(left: 25.0),
                        child: Text(
                          '45.000 Đ',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 10.0),
                        decoration: const BoxDecoration(
                            color: AppColor.royalBlue,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.0))),
                        child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CheckOutPage(
                                            title: widget.title,
                                            path: widget.path,
                                            total: total,
                                            date: '15/07/2022',
                                          )));
                            },
                            child: Text('Pay',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold))),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
