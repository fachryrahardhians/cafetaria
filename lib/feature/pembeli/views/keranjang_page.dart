import 'package:cafetaria/components/alertdialog/alert_dialog_widget.dart';
import 'package:cafetaria/feature/pembeli/bloc/add_order_bloc/add_order_bloc.dart';
import 'package:cafetaria/feature/pembeli/bloc/menu_in_cart_bloc/menu_in_cart_bloc.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria/styles/box_shadows.dart';
import 'package:cafetaria/utilities/SizeConfig.dart';
import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:formz/formz.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:order_repository/order_repository.dart';
import 'package:table_calendar/table_calendar.dart';

class KeranjangPage extends StatefulWidget {
  final String merchantId;
  const KeranjangPage({Key? key, required this.merchantId}) : super(key: key);

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff2E3032));
  TextStyle headlineStyle = const TextStyle(
      fontWeight: FontWeight.w700, fontSize: 24, color: Color(0xff2E3032));
  bool alat = false;
  bool _preorder = false;
  bool diantar = false;
  //TextEditingController _dateController = TextEditingController();
  //DateTime selectedDate = DateTime.now();
  DateTime _selectedDay = DateTime.now().add(const Duration(days: 1));
  DateTime _focusedDay = DateTime.now().add(const Duration(days: 1));
  DateTime _availableDay = DateTime.now();
  List<Keranjang> menuInKeranjang = [];

  int subTotalPrice = 0;
  int biayaPemesanan = 2000;
  // _selectDate(BuildContext context) async {
  //   final DateTime? picked = await showDatePicker(
  //       context: context,
  //       initialDate: selectedDate,
  //       firstDate: DateTime(1990),
  //       lastDate: DateTime(2025),
  //       builder: (BuildContext context, Widget? child) {
  //         return Theme(
  //           data: ThemeData.light().copyWith(
  //             colorScheme: const ColorScheme.light().copyWith(
  //               primary: Colors.red,
  //             ),
  //           ),
  //           child: child!,
  //         );
  //       });
  //   if (picked != selectedDate) {
  //     setState(() {
  //       selectedDate = picked!;
  //       String dateString =
  //           DateFormat('dd MMM yyyy').format(selectedDate).toString();
  //       _dateController.text = dateString;
  //     });
  //     context.read<AddOrderBloc>().add(OrderChange(_dateController.text));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => AddOrderBloc(
                  orderRepository: context.read<OrderRepository>(),
                )),
        BlocProvider(
            create: (context) => MenuInCartBloc(
                  menuRepository: context.read<MenuRepository>(),
                )..add(GetMenusInCart()))
      ],
      child: Scaffold(
        backgroundColor: const Color(0xffFCFBFC),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xffee3124)),
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Keranjang',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff333435)),
          ),
          centerTitle: true,
        ),
        body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            children: [
              _customerInfo(),
              SizedBox(height: SizeConfig.safeBlockVertical * 2),
              _booking(),
              SizedBox(height: SizeConfig.safeBlockVertical * 2),
              _bookingOption(context),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(diantar ? 'Diantar' : 'Ambil Sendiri'),
                        TextButton(
                            onPressed: () => showDialog(
                                context: context,
                                builder: (builder) => _popUpPanel()),
                            style: TextButton.styleFrom(
                                minimumSize: Size.zero,
                                padding: EdgeInsets.zero,
                                tapTargetSize:
                                    MaterialTapTargetSize.shrinkWrap),
                            child: Text(
                              "Ganti",
                              style: textStyle.copyWith(
                                  color: const Color(0xffee3124), fontSize: 11),
                            ))
                      ]),
                  Text(
                    diantar
                        ? 'Pesananmu akan diantar ke apartemen'
                        : 'Kamu ambil sendiri pesananmu di toko',
                    style: textStyle.copyWith(color: const Color(0xff8C8F93)),
                  )
                ],
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'PESANANMU',
                    style: textStyle.copyWith(color: const Color(0xff8C8F93)),
                  ),
                  Text(
                    'Tambah Pesanan',
                    style: textStyle.copyWith(
                        color: const Color(0xffee3124), fontSize: 11),
                  )
                ],
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 3),
              BlocBuilder<MenuInCartBloc, MenuInCartState>(
                  builder: (context, state) {
                if (state is MenuInCartRetrieved) {
                  menuInKeranjang = state.menuInCart;
                  subTotalPrice = state.totalPrice;
                  return ListView.separated(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return item(
                            menuInKeranjang[index].quantity,
                            menuInKeranjang[index].name.toString(),
                            menuInKeranjang[index].totalPrice);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: SizeConfig.safeBlockVertical * 3,
                          ),
                      itemCount: menuInKeranjang.length);
                } else if (state is MenuInCartRetrieveFailed) {
                  return Text(state.message);
                } else {
                  return const CircularProgressIndicator();
                }
              }),
              SizedBox(height: SizeConfig.safeBlockVertical * 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Subtotal',
                    style: textStyle,
                  ),
                  Text(
                    'Rp $subTotalPrice',
                    style: textStyle.copyWith(fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 1),
              Row(
                children: [
                  Text(
                    'Biaya Pemesanan ',
                    style: textStyle,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.info,
                      color: Color(0xffee3124),
                      size: 18,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Rp $biayaPemesanan',
                    style: textStyle.copyWith(fontWeight: FontWeight.w500),
                  )
                ],
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 3),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        alat ? 'Minta alat makan' : 'Tanpa alat makan',
                        style: textStyle,
                      ),
                      SizedBox(height: SizeConfig.safeBlockVertical * 1),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal * 60,
                        child: Text(
                          'Oke, akan kami sampaikan ke resto. Terima kasih sudah mengurangi pengguna plastik.',
                          style: textStyle.copyWith(
                              fontSize: 11, color: const Color(0xffB1B5BA)),
                        ),
                      )
                    ],
                  ),
                  FlutterSwitch(
                    value: alat,
                    onToggle: (val) {
                      setState(() {
                        alat = val;
                      });
                    },
                    activeColor: const Color(0xffee3124),
                    inactiveColor: const Color(0xffC8CCD2),
                    valueFontSize: 12,
                    width: 35,
                    height: 20,
                    toggleSize: 15,
                  )
                ],
              ),
              SizedBox(height: SizeConfig.safeBlockVertical * 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TOTAL PEMBAYARAN',
                    style: textStyle.copyWith(fontWeight: FontWeight.w500),
                  ),
                  BlocBuilder<MenuInCartBloc, MenuInCartState>(
                      builder: ((context, state) {
                    if (state is MenuInCartRetrieved) {
                      return Text(
                        'Rp ${state.totalPrice + biayaPemesanan}',
                        style: textStyle.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      );
                    } else {
                      return SizedBox();
                    }
                  }))
                ],
              )
            ]),
        bottomNavigationBar: BlocConsumer<AddOrderBloc, AddOrderState>(
          listener: (context, state) {
            if (state.formzStatus == FormzStatus.submissionSuccess) {
              var baseDialog = const AlertDialogWait(
                title: 'Makanan Anda sedang diproses',
                message:
                    'Harap menunggu notifikasi melalui app ketika makanan sudah siap untuk diantar atau dijemput.',
                buttonText: 'KEMBALI KE HOME',
              );
              showDialog(
                  context: context,
                  builder: (BuildContext context) => baseDialog);
            } else if (state.formzStatus == FormzStatus.submissionFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Terjadi kesalahan'),
                ),
              );
            }
          },
          builder: (context, state) {
            if (_preorder) {
              return CFButton.primary(
                child: (state.formzStatus == FormzStatus.submissionInProgress)
                    ? const CircularProgressIndicator()
                    : const Text('SIMPAN'),
                onPressed: state.orderInput.valid
                    ? () {
                        context.read<AddOrderBloc>().add(
                              SaveOrder(
                                  merchantId: widget.merchantId,
                                  listKeranjang: menuInKeranjang,
                                  preOrder: _preorder,
                                  grandTotalPrice:
                                      subTotalPrice + biayaPemesanan,
                                  timestamp: DateTime.now().toString(),
                                  pickupDate:
                                      _selectedDay.toString().split(' ')[0] +
                                          ' 08:00:00.000'),
                            );
                      }
                    : null,
              );
            } else {
              return CFButton.primary(
                child: (state.formzStatus == FormzStatus.submissionInProgress)
                    ? const CircularProgressIndicator()
                    : const Text('PESAN'),
                onPressed: () {
                  context.read<AddOrderBloc>().add(
                        SaveOrder(
                            merchantId: widget.merchantId,
                            listKeranjang: menuInKeranjang,
                            preOrder: _preorder,
                            grandTotalPrice: subTotalPrice + biayaPemesanan,
                            timestamp: DateTime.now().toString(),
                            pickupDate: _selectedDay.toString().split(' ')[0] +
                                ' 08:00:00.000'),
                      );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _booking() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Checkbox(
                  value: _preorder,
                  fillColor: MaterialStateProperty.all(CFColors.redPrimary40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  onChanged: (newvalue) => setState(() {
                        _preorder = newvalue!;
                      })),
              const SizedBox(width: 3),
              const Text('Booking')
            ],
          ),
        ),
        const Text('50/50')
      ],
    );
  }

  Widget _bookingOption(BuildContext context) {
    final isRatingValid = context.select(
      (AddOrderBloc bloc) =>
          bloc.state.orderInput.pure ||
          (!bloc.state.orderInput.pure && bloc.state.orderInput.valid),
    );
    return Visibility(
      visible: _preorder,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xffE9EBEF)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 20,
                      padding: const EdgeInsets.all(2),
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xffF8091E),
                                Color(0xffA9085A)
                              ])),
                      child: Center(
                          child: Text('i',
                              style: headlineStyle.copyWith(
                                  color: Colors.white, fontSize: 16))),
                    ),
                    SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
                    Text(
                      'Informasi',
                      style: headlineStyle.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: SizeConfig.safeBlockVertical * 1),
                Text(
                  'Booking minimal 1 hari sebelum pengambilan dan akan dihitung dari hari setelah booking.',
                  style: textStyle.copyWith(
                      fontSize: 14, color: const Color(0xff8C8F93)),
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          Text('TANGGAL PENGAMBILAN',
              style: textStyle.copyWith(color: const Color(0xff66686a))),
          SizedBox(height: SizeConfig.safeBlockVertical * 1),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: boxShadows,
                color: const Color(0xffF9FAFB)),
            child: TableCalendar(
              headerStyle: HeaderStyle(
                  leftChevronIcon: const Icon(
                    Icons.chevron_left_rounded,
                    color: const Color(0xffEE3124),
                  ),
                  rightChevronIcon: const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xffEE3124),
                  ),
                  titleCentered: true,
                  formatButtonVisible: false,
                  titleTextStyle: headlineStyle.copyWith(fontSize: 15)),
              calendarStyle: const CalendarStyle(
                markerDecoration: BoxDecoration(
                    color: Color(0xFFee3124), shape: BoxShape.circle),
                todayDecoration: BoxDecoration(shape: BoxShape.circle),
                todayTextStyle: TextStyle(
                    color: Color(0xFF5A5A5A),
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700),
                selectedDecoration: BoxDecoration(
                    color: Color(0xFFee3124), shape: BoxShape.circle),
              ),
              locale: 'id_ID',
              firstDay: DateTime.utc(1980, 01, 01),
              lastDay: DateTime.utc(2030, 12, 31),
              calendarFormat: CalendarFormat.month,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) {
                return isSameDay(_selectedDay, day);
              },
              enabledDayPredicate: (day) {
                return day.isAfter(_availableDay);
              },
              onDaySelected: (selectedDay, focusedDay) {
                if (selectedDay.isAfter(_availableDay)) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay =
                        focusedDay; // update `_focusedDay` here as well
                  });
                  context
                      .read<AddOrderBloc>()
                      .add(OrderChange(selectedDay.toString()));
                }
              },
            ),
          ),
          // GestureDetector(
          //   onTap: () => _selectDate(context),
          //   child: AbsorbPointer(
          //     child: Container(
          //       decoration: BoxDecoration(boxShadow: [
          //         BoxShadow(
          //             offset: const Offset(0, 4),
          //             blurRadius: 12,
          //             color: Colors.black.withOpacity(.04))
          //       ]),
          //       child: TextFormField(
          //         autofocus: false,
          //         controller: _dateController,
          //         decoration: InputDecoration(
          //           filled: true,
          //           fillColor: Colors.white,
          //           focusedBorder: OutlineInputBorder(
          //               borderSide: BorderSide.none,
          //               borderRadius: BorderRadius.circular(8)),
          //           enabledBorder: OutlineInputBorder(
          //               borderSide: BorderSide.none,
          //               borderRadius: BorderRadius.circular(8)),
          //           errorText:
          //               !isRatingValid ? "Review tidak boleh kosong" : null,
          //           hintText: "Tentukan Tanggal",
          //           hintStyle: const TextStyle(
          //               fontSize: 13, color: const Color(0xffCACCCF)),
          //           suffixIcon: const Icon(
          //             Icons.calendar_today,
          //             color: Color(0xffEE3124),
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          Text('JAM PENGAMBILAN',
              style: textStyle.copyWith(color: const Color(0xff66686a))),
          SizedBox(height: SizeConfig.safeBlockVertical * 1),
          GestureDetector(
            onTap: () {},
            child: AbsorbPointer(
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                      color: Colors.black.withOpacity(.04))
                ]),
                child: TextFormField(
                  initialValue: '08:00',
                  autofocus: false,
                  style: const TextStyle(
                      fontSize: 13, color: const Color(0xffB1B5BA)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xffF2F4F6),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8)),
                    hintText: "Tentukan jam pengambilan",
                    hintStyle: const TextStyle(
                        fontSize: 13, color: const Color(0xffCACCCF)),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 3),
        ],
      ),
      replacement: const SizedBox(),
    );
  }

  Widget _customerInfo() {
    return Container(
        padding: const EdgeInsets.all(16),
        width: SizeConfig.screenWidth,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
                image: AssetImage(Assets.images.cardOverlayOrange.path),
                fit: BoxFit.fill),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.16),
                  offset: const Offset(0, 4),
                  blurRadius: 12)
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(Assets.images.illCafetaria.path,
                width: SizeConfig.safeBlockHorizontal * 20,
                fit: BoxFit.fitWidth),
            SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Lokasi Anda Sekarang',
                    style: textStyle.copyWith(
                        color: Colors.white.withOpacity(.7))),
                SizedBox(height: SizeConfig.safeBlockVertical * .5),
                Text(
                  'Apartemen Skyline Residence',
                  style: textStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.white),
                ),
                SizedBox(height: SizeConfig.safeBlockVertical * .25),
                Text('Tower A • Lantai 3A • Nomor 37 ',
                    style: textStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.white))
              ],
            )
          ],
        ));
  }

  Widget item(int itemCount, String itemName, int totalPrice) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${itemCount}x',
              style: textStyle.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 13)),
          SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(itemName,
                  style: textStyle.copyWith(
                      fontWeight: FontWeight.w500, fontSize: 13)),
              SizedBox(height: SizeConfig.safeBlockVertical * 1),
              GestureDetector(
                onTap: () async {},
                child: Text(
                  'Edit',
                  style: textStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: const Color(0xffee3124),
                      fontSize: 11),
                ),
              )
            ],
          ),
          const Spacer(),
          Text(
            'Rp. $totalPrice',
            style:
                textStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 13),
          )
        ],
      ),
    );
  }

  Widget _popUpPanel() {
    return DraggableScrollableSheet(
      initialChildSize: 0.36,
      minChildSize: 0.36,
      maxChildSize: 0.36,
      builder: (context, scrollController) {
        return Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
              color: Colors.white),
          child: Column(
            children: [
              Container(
                height: 30,
                alignment: Alignment.center,
                child: Container(
                  width: 100,
                  height: 4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xffE5E6E6)),
                ),
              ),
              _card('Ambil Sendiri', 'Kamu ambil sendiri pesananmu di toko',
                  "assets/images/ill_merchants.png", !diantar),
              _card('Diantar', 'Pesananmu akan diantar ke apartemen',
                  "assets/images/ill_home.png", diantar),
            ],
          ),
        );
      },
    );
  }

  Widget _card(String title, String desc, String image, bool isVisible) {
    return Card(
      margin: const EdgeInsets.only(top: 16, left: 24, right: 24),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
          padding: const EdgeInsets.only(top: 24, left: 12, bottom: 24),
          child: InkWell(
            onTap: () {
              // setState(() {
              //   diantar = !diantar;
              // });
              Navigator.pop(context);
              if (title == 'Diantar') {
                showDialog(
                    context: context,
                    builder: (BuildContext context) => _notAvailableAlert());
              }
            },
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 43,
                      height: 43,
                      child: Image.asset(
                        image,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              color: Color(0xff2E3032),
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 6),
                        Text(
                          desc,
                          style: TextStyle(
                              color: Color(0xffB1b5BA),
                              fontWeight: FontWeight.w400,
                              fontSize: 12),
                        ),
                      ],
                    ),
                    Visibility(
                        visible: isVisible,
                        child: Icon(
                          Icons.check,
                          color: Color(0xffEE3124),
                        ))
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget _notAvailableAlert() {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("assets/images/ill_sad.png"),
          Text(
            "Mohon maaf fitur belum tersedia untuk saat ini",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff222222),
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          Text(
            "Kami mohon maaf untuk fitur pesanan diantar keapartemen untuk saat ini masih belum tersedia.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff808285),
                fontSize: 12,
                fontWeight: FontWeight.w400),
          )
        ],
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.all(16)),
                elevation: MaterialStateProperty.all(0),
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xffee3124)),
                foregroundColor:
                    MaterialStateProperty.all(const Color(0xffee3124)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide.none))),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("PILIH KEMBALI PENGAMBILAN",
                style: TextStyle(color: Colors.white, fontSize: 14)),
          ),
        ),
      ],
    );
  }
}
