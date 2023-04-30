import 'package:another_flushbar/flushbar.dart';
import 'package:cafetaria/components/buttons/reusables_buttons.dart';
import 'package:cafetaria/feature/penjual/bloc/calender_bloc/calender_bloc.dart';
import 'package:cafetaria/feature/penjual/bloc/days_bloc/days_bloc.dart';
import 'package:cafetaria/feature/penjual/views/set_open.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria/styles/box_shadows.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merchant_repository/merchant_repository.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetOperational extends StatelessWidget {
  final String merchantId;
  const SetOperational({Key? key, required this.merchantId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CalenderBloc(
              merchantRepository: context.read<MerchantRepository>())
            ..add(GetCalender(
                date: DateTime.now().toIso8601String(),
                merchantId: merchantId,
                type: 'monthly')),
        ),
        BlocProvider(
          create: (context) =>
              DaysBloc(merchantRepository: context.read<MerchantRepository>())
                ..add(GetDays(merchantId: merchantId)),
        ),
      ],
      child: SetOperationalWidget(
        merchantId: merchantId,
      ),
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
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  bool close = false;
  DateTime? _selectedDay;
  bool submitLoading = false;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    //print(widget.merchantId);
  }

  Future onSubmit(context) async {
    setState(() {
      submitLoading = true;
    });
    final userId = widget.merchantId;
    String date =
        "${_selectedDay?.year}-${_selectedDay?.month.toString().length == 2 ? _selectedDay?.month : _selectedDay?.month.toString().padLeft(2, '0')}-${_selectedDay?.day.toString().length == 2 ? _selectedDay?.day : _selectedDay?.day.toString().padLeft(2, '0')}";

    setState(() {});

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
      Navigator.pop(context, 'refresh');
      Future.delayed(
        const Duration(microseconds: 100),
        () {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            borderRadius: BorderRadius.circular(8),
            margin: const EdgeInsets.all(16),
            backgroundColor: const Color(0xff36B37E),
            messageText: Column(
              children: const [
                Center(
                  child: Text(
                    "Jam Operasional telah berhasil ditambahkan.",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
            duration: const Duration(seconds: 3),
          ).show(context);
        },
      );
    } catch (error) {
      Fluttertoast.showToast(msg: "$error", toastLength: Toast.LENGTH_LONG);
    } finally {
      setState(() {
        submitLoading = false;
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
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SizedBox(
          width: double.infinity,
          height: 50,
          child: ReusableButton1(
            label: "SIMPAN",
            onPressed: () {
              //_onSubmit(context);
              onSubmit(context);
              context.read<AppSharedPref>().getProgress().then((value) {
                if (value == null) {
                  context.read<AppSharedPref>().setProgress(0.5);
                } else if (value == 0.5) {
                  context.read<AppSharedPref>().setProgress(1);
                  Future.delayed(
                    const Duration(microseconds: 100),
                    () {
                      Flushbar(
                        flushbarPosition: FlushbarPosition.TOP,
                        borderRadius: BorderRadius.circular(8),
                        margin: const EdgeInsets.all(16),
                        backgroundColor: const Color(0xff36B37E),
                        messageText: Column(
                          children: const [
                            Center(
                              child: Text(
                                "Pengaturan Toko telah berhasil dilengkapi dan selamat menikmati fitur-fitur di lapaku.",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        duration: const Duration(seconds: 3),
                      ).show(context);
                    },
                  );
                }
              });
            },
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.all(0),
            loading: submitLoading,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: ListView(
          children: [
            BlocBuilder<CalenderBloc, CalenderState>(
              builder: (context, state) {
                final status = state.status;
                if (status == CalenderStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (status == CalenderStatus.failure) {
                  return Text(state.errorMessage.toString());
                } else if (status == CalenderStatus.success) {
                  final item = state.items;
                  return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: boxShadows,
                          color: const Color(0xffF9FAFB)),
                      child: TableCalendar(
                        calendarBuilders: CalendarBuilders(
                          // Define a builder for the day cell
                          defaultBuilder: (context, date, events) {
                            final event = item!.firstWhere(
                              (element) => isSameDay(element.date, date),
                              orElse: () => RulesDays(
                                  date: DateTime.now(), isClosed: false),
                            );
                            final isSpecialDate = event.isClosed;
                            // Use transparent for other dates
                            return Container(
                              margin: const EdgeInsets.all(4),
                              child: Center(
                                child: Text(
                                  date.day.toString(),
                                  style: TextStyle(
                                    color: isSpecialDate!
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        weekendDays: const [DateTime.sunday, 6],
                        // daysOfWeekStyle: const DaysOfWeekStyle(
                        //   // Weekend days color (Sat,Sun)
                        //   weekendStyle: TextStyle(color: Colors.red),
                        // ),
                        firstDay: DateTime.utc(1980, 01, 01),
                        lastDay: DateTime.utc(2030, 12, 31),
                        calendarFormat: _calendarFormat,
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        // eventLoader: (day) => _events[day] ?? [],
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        calendarStyle: const CalendarStyle(
                          weekendTextStyle: TextStyle(color: Colors.red),
                          markerDecoration: BoxDecoration(
                              color: Color(0xFFee3124), shape: BoxShape.circle),
                          todayDecoration:
                              BoxDecoration(shape: BoxShape.circle),
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
                            final event = item!.firstWhere(
                              (element) => isSameDay(element.date, selectedDay),
                              orElse: () => RulesDays(
                                  date: DateTime.now(), isClosed: false),
                            );
                            close = event.isClosed!;
                          });
                        },
                      ));
                }
                return const SizedBox.shrink();
              },
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    convertDateTime(_selectedDay!),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 150),
                    child: Text(
                      close == true ? " tutup" : " Buka",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Switch(
                    value: close,
                    onChanged: (val) {
                      setState(() {
                        close = val;
                      });
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Colors.green,
                  ),
                ],
              ),
            ),
            BlocBuilder<DaysBloc, DaysState>(builder: (context, state) {
              final status = state.status;
              if (status == DaysStatus.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (status == DaysStatus.failure) {
                return Text(state.errorMessage.toString());
              } else if (status == DaysStatus.success) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.items!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = state.items?[index];
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
                          Image.asset(item?.isClosed == true
                              ? Assets.images.calClose.path
                              : Assets.images.calOpen.path),
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
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
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
              return const SizedBox.shrink();
            }),
            // FutureBuilder<List<Rules>>(
            //   future: context
            //       .read<MerchantRepository>()
            //       .getrulesDay(merchantId: widget.merchantId),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     } else if (snapshot.connectionState == ConnectionState.none) {
            //       return const Text("Error");
            //     } else {
            //       return ListView.builder(
            //         shrinkWrap: true,
            //         itemCount: snapshot.data?.length,
            //         physics: const NeverScrollableScrollPhysics(),
            //         itemBuilder: (context, index) {
            //           final item = snapshot.data?[index];
            //           return Container(
            //             margin: const EdgeInsets.symmetric(vertical: 24),
            //             padding: const EdgeInsets.symmetric(
            //                 vertical: 20, horizontal: 14),
            //             decoration: BoxDecoration(
            //               color: Colors.white,
            //               borderRadius:
            //                   const BorderRadius.all(Radius.circular(8)),
            //               boxShadow: [
            //                 BoxShadow(
            //                   color: Colors.black.withOpacity(0.04),
            //                   blurRadius: 12,
            //                   offset: const Offset(
            //                       0, 4), // changes position of shadow
            //                 ),
            //               ],
            //             ),
            //             height: 84,
            //             child: Row(
            //               children: [
            //                 Image.asset(item?.isClosed == true
            //                     ? Assets.images.calClose.path
            //                     : Assets.images.calOpen.path),
            //                 const SizedBox(width: 18),
            //                 Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(item!.day.toString(),
            //                         style: const TextStyle(
            //                             fontSize: 16,
            //                             fontWeight: FontWeight.bold)),
            //                     Text("${item.openTime} - ${item.closedTime}",
            //                         style: const TextStyle(
            //                             fontSize: 13,
            //                             fontWeight: FontWeight.w500,
            //                             color: Colors.grey)),
            //                   ],
            //                 ),
            //                 const Spacer(),
            //                 GestureDetector(
            //                   onTap: () {
            //                     Navigator.push(
            //                         context,
            //                         MaterialPageRoute(
            //                           builder: (context) => SetOpen(
            //                               rules: item,
            //                               merchantId: widget.merchantId),
            //                         ));
            //                   },
            //                   child: Container(
            //                     decoration: BoxDecoration(
            //                       color: Colors.white,
            //                       borderRadius: const BorderRadius.all(
            //                           Radius.circular(8)),
            //                       border: Border.all(
            //                         color: Colors.red,
            //                         width: 0.0,
            //                       ),
            //                       boxShadow: [
            //                         BoxShadow(
            //                           color: Colors.black.withOpacity(0.04),
            //                           blurRadius: 12,
            //                           offset: const Offset(
            //                               0, 4), // changes position of shadow
            //                         ),
            //                       ],
            //                     ),
            //                     width: 60,
            //                     height: 25,
            //                     child: const Center(
            //                         child: Text(
            //                       "Ubah",
            //                       style: TextStyle(color: Colors.red),
            //                     )),
            //                   ),
            //                 )
            //               ],
            //             ),
            //           );
            //         },
            //       );
            //     }
            //   },
            // )
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
