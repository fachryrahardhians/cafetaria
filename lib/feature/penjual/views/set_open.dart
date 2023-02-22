import 'package:cafetaria/components/buttons/reusables_buttons.dart';

import 'package:cafetaria/utilities/size_config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merchant_repository/merchant_repository.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SetOpen extends StatelessWidget {
  final Rules rules;
  final String merchantId;
  const SetOpen({Key? key, required this.rules, required this.merchantId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SetOpenWidget(
      rules: rules,
      merchantId: merchantId,
    );
  }
}

class SetOpenWidget extends StatefulWidget {
  final Rules rules;
  final String merchantId;
  const SetOpenWidget({Key? key, required this.rules, required this.merchantId})
      : super(key: key);

  @override
  State<SetOpenWidget> createState() => _SetOpenWidgetState();
}

class _SetOpenWidgetState extends State<SetOpenWidget> {
  bool is24Hour = false;
  bool isClosed = false;
  bool setTime = false;
  bool submitLoading = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController bukaHour = TextEditingController();
  TextEditingController bukaminute = TextEditingController();
  TextEditingController tutupHour = TextEditingController();
  TextEditingController tutupminute = TextEditingController();
  TimeOfDay time = const TimeOfDay(hour: 10, minute: 30);
  String? timeOpen = "";
  String? timeClose = "";
  bool disable() {
    if (is24Hour == true) {
      return false;
    }
    if (isClosed == true) {
      return false;
    }
    if (setTime == true) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      is24Hour = widget.rules.open24Hr!;
      isClosed = widget.rules.isClosed!;
    });
  }

  Future onSubmit(context) async {
    setState(() {
      submitLoading = true;
    });

    try {
      final data = {
        'closedTime': timeClose == ""
            ? widget.rules.closedTime
            : "${DateTime.parse(timeClose.toString()).hour}:${DateTime.parse(timeClose.toString()).minute}",
        'day': widget.rules.day,
        'isClosed': isClosed,
        'open24hr': is24Hour,
        'openTime': timeOpen == ""
            ? widget.rules.closedTime
            : "${DateTime.parse(timeOpen.toString()).hour}:${DateTime.parse(timeOpen.toString()).minute}",
      };

      await _firestore
          .collection('merchant')
          .doc(widget.merchantId)
          .collection("rules")
          .doc(widget.rules.day)
          .update(data);
      Navigator.of(context).pop();
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
        title: Text(widget.rules.day.toString().toUpperCase()),
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
            disabled: disable(),
            loading: submitLoading,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            height: 84,
            child: Row(
              children: [
                const SizedBox(width: 18),
                const Text("Buka 24 Jam",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Spacer(),
                Switch(
                  value: is24Hour,
                  onChanged: (value) {
                    setState(() {
                      is24Hour = value;
                    });
                  },
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            height: 84,
            child: Row(
              children: [
                const SizedBox(width: 18),
                const Text("Tutup",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const Spacer(),
                Switch(
                  value: isClosed,
                  onChanged: (value) {
                    setState(() {
                      isClosed = value;
                    });
                  },
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 24),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4), // changes position of shadow
                ),
              ],
            ),
            height: 134,
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 18),
                    const Text("Atur Jam",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Switch(
                      value: setTime,
                      onChanged: (value) {
                        setState(() {
                          setTime = value;
                        });
                        if (setTime == true) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return StatefulBuilder(
                                  builder: (context, setState) {
                                return Dialog(
                                    child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 15, bottom: 16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Jam Buka",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                top: 15, left: 12, bottom: 10),
                                            child: Text(
                                              timeOpen == "" || timeOpen == null
                                                  ? ""
                                                  : "${DateTime.parse(timeOpen.toString()).hour} : ${DateTime.parse(timeOpen.toString()).minute}",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                // fontFamily: 'Raleway',
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              // DateTime? newDate = await showDatePicker(
                                              //     context: context,
                                              //     initialDate: date,
                                              //     firstDate: DateTime.now(),
                                              //     lastDate: DateTime(2100, 5, 5));

                                              // if (newDate == null) {
                                              //   return;
                                              // } else {
                                              //   setState(() {
                                              //     date = newDate;
                                              //   });
                                              // }
                                              TimeOfDay? newTimes =
                                                  await showTimePicker(
                                                context: context,
                                                initialTime: time,
                                              );

                                              if (newTimes == null) return;
                                              final now = DateTime.now();

                                              //if 'OK' new time
                                              setState(() {
                                                time = newTimes;
                                                timeOpen = DateTime(
                                                        now.year,
                                                        now.month,
                                                        now.day,
                                                        time.hour,
                                                        time.minute)
                                                    .toString();
                                              });
                                            },
                                            child: const Padding(
                                                padding: EdgeInsets.only(
                                                    right: 15, top: 10),
                                                child: Icon(
                                                  Icons.timelapse,
                                                  color: Colors.redAccent,
                                                )),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      const Text(
                                        "Jam Tutup",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                                top: 15, left: 12, bottom: 10),
                                            child: Text(
                                              timeClose == "" ||
                                                      timeClose == null
                                                  ? ""
                                                  : "${DateTime.parse(timeClose.toString()).hour} : ${DateTime.parse(timeClose.toString()).minute}",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 17,
                                                // fontFamily: 'Raleway',
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              // DateTime? newDate = await showDatePicker(
                                              //     context: context,
                                              //     initialDate: date,
                                              //     firstDate: DateTime.now(),
                                              //     lastDate: DateTime(2100, 5, 5));

                                              // if (newDate == null) {
                                              //   return;
                                              // } else {
                                              //   setState(() {
                                              //     date = newDate;
                                              //   });
                                              // }
                                              TimeOfDay? newTimes =
                                                  await showTimePicker(
                                                context: context,
                                                initialTime: time,
                                              );

                                              if (newTimes == null) return;
                                              final now = DateTime.now();

                                              //if 'OK' new time
                                              setState(() {
                                                time = newTimes;
                                                timeClose = DateTime(
                                                        now.year,
                                                        now.month,
                                                        now.day,
                                                        time.hour,
                                                        time.minute)
                                                    .toString();
                                              });
                                            },
                                            child: const Padding(
                                                padding: EdgeInsets.only(
                                                    right: 15, top: 10),
                                                child: Icon(
                                                  Icons.timelapse,
                                                  color: Colors.redAccent,
                                                )),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      Container(
                                          height: 44,
                                          width: SizeConfig.screenWidth,
                                          margin:
                                              const EdgeInsets.only(left: 8),
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  elevation:
                                                      MaterialStateProperty.all(
                                                          0),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          const Color(
                                                              0xffee3124)),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                              side: BorderSide
                                                                  .none))),
                                              onPressed: () {
                                                Navigator.pop(context,
                                                    [timeOpen, timeClose]);
                                              },
                                              child: Text(
                                                "SIMPAN",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.white
                                                        .withOpacity(1)),
                                              )))
                                    ],
                                  ),
                                ));
                              });
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Jam Buka",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(
                              timeOpen == ""
                                  ? "${widget.rules.openTime} "
                                  : "${DateTime.parse(timeOpen.toString()).hour}:${DateTime.parse(timeOpen.toString()).minute}",
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 70),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Jam Tutup",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text(
                              timeClose == ""
                                  ? "${widget.rules.closedTime}"
                                  : "${DateTime.parse(timeClose.toString()).hour}:${DateTime.parse(timeClose.toString()).minute}",
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey)),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
