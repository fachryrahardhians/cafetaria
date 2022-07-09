import 'package:cafetaria/components/alertdialog/alert_dialog_widget.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria/utilities/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';

class KeranjangPage extends StatefulWidget {
  const KeranjangPage({Key? key}) : super(key: key);

  @override
  State<KeranjangPage> createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w400, fontSize: 13, color: Color(0xff2E3032));
  TextStyle headlineStyle = const TextStyle(
      fontWeight: FontWeight.w700, fontSize: 24, color: Color(0xff2E3032));
  bool alat = false;
  bool _loading = false;
  bool value = false;
  TextEditingController _dateController = TextEditingController();

  _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1990),
        lastDate: DateTime(2025),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light().copyWith(
                primary: Colors.red,
              ),
            ),
            child: child!,
          );
        });
    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked!;
        String dateString =
            DateFormat('dd MMM yyyy').format(selectedDate).toString();
        _dateController.text = dateString;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              children: [
                _customerInfo(),
                SizedBox(height: SizeConfig.safeBlockVertical * 2),
                _booking(),
                SizedBox(height: SizeConfig.safeBlockVertical * 2),
                _bookingOption(),
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
                ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return item();
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: SizeConfig.safeBlockVertical * 3,
                        ),
                    itemCount: 3),
                SizedBox(height: SizeConfig.safeBlockVertical * 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal',
                      style: textStyle,
                    ),
                    Text(
                      'Rp 0',
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
                      'Rp 2000',
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
                    Text(
                      'Rp 0',
                      style: textStyle.copyWith(
                          fontWeight: FontWeight.w500, fontSize: 15),
                    )
                  ],
                ),
              ],
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: SizedBox(
          width: SizeConfig.screenWidth,
          height: SizeConfig.safeBlockVertical * 6.5,
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
              onPressed: () async {
                var baseDialog = const AlertDialogWait(
                  title: 'Makanan Anda sedang diproses',
                  message:
                      'Harap menunggu notifikasi melalui app ketika makanan sudah siap untuk diantar atau dijemput.',
                  buttonText: 'KEMBALI KE HOME',
                );
                showDialog(
                    context: context,
                    builder: (BuildContext context) => baseDialog);
              },
              child: Text(
                'PESAN',
                style:
                    headlineStyle.copyWith(color: Colors.white, fontSize: 14),
              )),
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
                  value: value,
                  onChanged: (newvalue) => setState(() {
                        value = newvalue!;
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

  Widget _bookingOption() {
    return Visibility(
      visible: value,
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
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 12,
                      color: Colors.black.withOpacity(.04))
                ]),
                child: TextFormField(
                  autofocus: false,
                  controller: _dateController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8)),
                    hintText: "Tentukan Tanggal",
                    hintStyle: const TextStyle(
                        fontSize: 13, color: const Color(0xffCACCCF)),
                    suffixIcon: const Icon(
                      Icons.calendar_today,
                      color: Color(0xffEE3124),
                    ),
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
                    fillColor: Color(0xffF2F4F6),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(8)),
                    hintText: "Tentukan Tanggal",
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

  Widget item() {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('2x',
              style: textStyle.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 13)),
          SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Item name',
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
            'Rp. 0',
            style:
                textStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 13),
          )
        ],
      ),
    );
  }
}
