import 'package:cafetaria/feature/penjual/views/set_open.dart';
import 'package:cafetaria/styles/box_shadows.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merchant_repository/merchant_repository.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetOperational extends StatelessWidget {
  final String merchantId;
  const SetOperational({Key? key, required this.merchantId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SetOperationalWidget(
      merchantId: merchantId,
    );
  }
}

class SetOperationalWidget extends StatefulWidget {
  final String merchantId;
  const SetOperationalWidget({Key? key, required this.merchantId})
      : super(key: key);

  @override
  State<SetOperationalWidget> createState() => _SetOperationalWidgetState();
}

class _SetOperationalWidgetState extends State<SetOperationalWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _submitLoading = false;
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  bool close = false;
  DateTime? _selectedDay;
  final Map<DateTime, List<String>> _events = {
    DateTime(2023, 2, 8): ['Event 1'],
    DateTime(2023, 2, 15): ['Event 2'],
  };

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    //print(widget.merchantId);
  }

  Future onSubmit(context) async {
    final userId = widget.merchantId;
    String date =
        "${_selectedDay?.year}-${_selectedDay?.month}-${_selectedDay?.day}";
    setState(() {
      _submitLoading = true;
    });

    try {
      final data = {'date': date, 'isClosed': close};

      await _firestore
          .collection('merchant')
          .doc(userId)
          .collection("offDays")
          .doc(date)
          .set(data);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => DahsboardPage(
      //       id: user.uid,
      //     ),
      //   ),
      // );
      Fluttertoast.showToast(
          msg: "Submit success!", toastLength: Toast.LENGTH_LONG);
    } catch (error) {
      Fluttertoast.showToast(msg: "$error", toastLength: Toast.LENGTH_LONG);
    } finally {
      setState(() {
        _submitLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JAM OPERASIONAL'),
        iconTheme: const IconThemeData(color: Colors.red),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: boxShadows,
                    color: const Color(0xffF9FAFB)),
                child: TableCalendar(
                  weekendDays: const [DateTime.sunday, 6],
                  // daysOfWeekStyle: const DaysOfWeekStyle(
                  //   // Weekend days color (Sat,Sun)
                  //   weekendStyle: TextStyle(color: Colors.red),
                  // ),
                  firstDay: DateTime.utc(1980, 01, 01),
                  lastDay: DateTime.utc(2030, 12, 31),
                  calendarFormat: _calendarFormat,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  eventLoader: (day) => _events[day] ?? [],
                  startingDayOfWeek: StartingDayOfWeek.sunday,
                  calendarStyle: const CalendarStyle(
                    weekendTextStyle: TextStyle(color: Colors.red),
                    markerDecoration: BoxDecoration(
                        color: Color(0xFFee3124), shape: BoxShape.circle),
                    todayDecoration: BoxDecoration(shape: BoxShape.circle),
                    todayTextStyle: TextStyle(
                        color: Color(0xFF5A5A5A),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700),
                    selectedDecoration: BoxDecoration(
                        color: Color(0xFFee3124), shape: BoxShape.circle),
                    // todayDecoration: BoxDecoration(
                    //   color: Colors.green,
                    //   shape: BoxShape.circle,
                    // ),
                    outsideDaysVisible: false,
                  ),
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      close = false;
                    });
                    // context
                    //     .read<MerchantRepository>()
                    //     .getMerchantOffDaysRule(
                    //         merchantId: widget.merchantId,
                    //         date: _selectedDay?.toIso8601String(),
                    //         type: 'daily')
                    //     .then((value) {
                    //   print(value.isClosed);
                    // });
                  },
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  convertDateTime(_selectedDay!),
                ),
                Switch(
                  value: close,
                  onChanged: (val) {
                    setState(() {
                      close = val;
                    });
                    onSubmit(context);
                  },
                  activeColor: Colors.white,
                  activeTrackColor: Colors.green,
                ),
              ],
            ),
            FutureBuilder<List<Rules>>(
              future: context
                  .read<MerchantRepository>()
                  .getrulesDay(widget.merchantId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return const Text("Error");
                } else {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data?.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = snapshot.data?[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 24),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.04),
                              blurRadius: 12,
                              offset: const Offset(
                                  0, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        height: 84,
                        child: Row(
                          children: [
                            const SizedBox(width: 18),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item!.day.toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                Text("${item.openTime} - ${item.closedTime}",
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey)),
                              ],
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SetOpen(
                                          rules: item,
                                          merchantId: widget.merchantId),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 0.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 12,
                                      offset: const Offset(
                                          0, 4), // changes position of shadow
                                    ),
                                  ],
                                ),
                                width: 60,
                                height: 25,
                                child: const Center(
                                    child: Text(
                                  "Ubah",
                                  style: TextStyle(color: Colors.red),
                                )),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}

String convertDateTime(DateTime dateTime) {
  String month;

  switch (dateTime.month) {
    case 1:
      month = 'Januari';
      break;
    case 2:
      month = 'Febuari';
      break;
    case 3:
      month = 'Maret';
      break;
    case 4:
      month = 'April';
      break;
    case 5:
      month = 'Mei';
      break;
    case 6:
      month = 'Juni';
      break;
    case 7:
      month = 'Juli';
      break;
    case 8:
      month = 'Agustus';
      break;
    case 9:
      month = 'September';
      break;
    case 10:
      month = 'Oktober';
      break;
    case 11:
      month = 'November';
      break;
    default:
      month = 'Desember';
  }

  return ' ${dateTime.day} $month ${dateTime.year} ';
}
