import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:menu_repository/menu_repository.dart';

import 'package:cafetaria/feature/penjual/bloc/atur_stock_bloc/atur_stock_bloc_bloc.dart';

class EditStok extends StatelessWidget {
  const EditStok({Key? key, required this.menuModel}) : super(key: key);
  final MenuModel menuModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AturStockBlocBloc(menuRepository: context.read<MenuRepository>()),
      child: AddStockMenuPage(user: menuModel),
    );
  }
}

class AddStockMenuPage extends StatefulWidget {
  final MenuModel user;
  const AddStockMenuPage({Key? key, required this.user}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AddStockMenuPageState();
}

class _AddStockMenuPageState extends State<AddStockMenuPage> {
  bool stockActive = true;
  bool berulangActive = false;
  List<String> dropdown = ['Setiap Jam', 'Mingguan', 'Harian'];
  String selectedDropdown = 'jam';
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Setiap Jam"), value: "jam"),
      const DropdownMenuItem(child: Text("Harian"), value: "hari"),
      const DropdownMenuItem(child: Text("Mingguan"), value: "minggu"),
    ];
    return menuItems;
  }

  TextEditingController? _stokBarang;
  TimeOfDay time = const TimeOfDay(hour: 10, minute: 30);
  String timeRestok = "";
  final oCcy = NumberFormat("#,##0.00", "IDR");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _stokBarang = TextEditingController(text: widget.user.stock.toString());
    widget.user.stock == 0 ? stockActive = false : stockActive = true;

    widget.user.autoResetStock == false
        ? berulangActive = false
        : berulangActive = true;
    context.read<AturStockBlocBloc>().add(AturStokJumlah(_stokBarang!.text));
    if (berulangActive == true) {
      selectedDropdown =
          widget.user.resetType == "" || widget.user.resetType!.isEmpty
              ? "jam"
              : widget.user.resetType!;
      timeRestok = widget.user.resetTime!;
      context.read<AturStockBlocBloc>().add(AturStokRestok(berulangActive));
      context
          .read<AturStockBlocBloc>()
          .add(AturStokRestokType(selectedDropdown));
      context.read<AturStockBlocBloc>().add(AturStokTime(timeRestok));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Atur Stok Menu',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.red),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      // color: Colors.grey,
                      decoration: BoxDecoration(
                          color: CFColors.grayscaleBlack50,
                          borderRadius: BorderRadius.circular(7.0),
                          image: DecorationImage(
                              image: NetworkImage(widget.user.image == null
                                  ? "https://i.pinimg.com/564x/94/17/82/941782f60e16a9d7f9b4cea4ae7025e0.jpg"
                                  : widget.user.image.toString()),
                              fit: BoxFit.fill)),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.user.name.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          "Rp ${oCcy.format(widget.user.price)}",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        const Text(
                          '1 opsi menu tersambung',
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(10),
                    //   child: BottomSheetSwitch(
                    //     switchValue: stockActive,
                    //     valueChanged: (value) {
                    //       stockActive = value;
                    //       // print(stockActive);
                    //       context
                    //           .read<AturStockBlocBloc>()
                    //           .add(AturStokTersedia(stockActive));
                    //     },
                    //   ),
                    // )
                    Switch(
                      value: stockActive,
                      onChanged: (val) {
                        setState(() {
                          stockActive = val;
                        });
                        context
                            .read<AturStockBlocBloc>()
                            .add(AturStokTersedia(stockActive));
                      },
                      activeColor: Colors.white,
                      activeTrackColor: Colors.green,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'STOK MENU',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4.0),
                Container(
                  height: 47,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  decoration: BoxDecoration(
                    color: stockActive ? Colors.white : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.0,
                    ),
                  ),
                  child: TextFormField(
                    controller: _stokBarang,
                    // initialValue: '100',
                    enabled: stockActive,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      context
                          .read<AturStockBlocBloc>()
                          .add(AturStokJumlah(value));
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Terapkan sebagai berulang',
                    ),
                    Switch(
                      value: berulangActive,
                      onChanged: (val) {
                        setState(() {
                          berulangActive = val;
                        });
                        context
                            .read<AturStockBlocBloc>()
                            .add(AturStokRestok(berulangActive));
                      },
                      activeColor: Colors.white,
                      activeTrackColor: Colors.green,
                    ),
                  ],
                ),
                Visibility(
                  visible: berulangActive,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24.0),
                      const Text(
                        'ATUR ULANG BATAS PENJUALAN',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Container(
                        height: 47,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.0,
                          ),
                        ),
                        child: DropdownButtonFormField(
                          value: selectedDropdown,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.red,
                          ),
                          decoration: const InputDecoration.collapsed(
                            hintText: 'Pilih atur ulang batas penjualan',
                          ),
                          items: dropdownItems,
                          onChanged: (val) {
                            setState(() {
                              selectedDropdown = val.toString();
                            });

                            context
                                .read<AturStockBlocBloc>()
                                .add(AturStokRestokType(selectedDropdown));
                          },
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const Text(
                        'ATUR ULANG PADA JAM',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Container(
                        height: 50,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 0.0,
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.only(
                                      top: 15, left: 12, bottom: 10),
                                  child: Text(
                                    timeRestok,
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
                                    TimeOfDay? newTimes = await showTimePicker(
                                        context: context, initialTime: time);

                                    if (newTimes == null) return;

                                    //if 'OK' new time
                                    setState(() {
                                      time = newTimes;
                                      timeRestok =
                                          "${time.hour} : ${time.minute} ${time.period.name.toUpperCase()}";
                                      context.read<AturStockBlocBloc>().add(
                                          AturStokTime(time.format(context)));
                                    });
                                  },
                                  child: const Padding(
                                      padding:
                                          EdgeInsets.only(right: 15, top: 10),
                                      child: Icon(
                                        Icons.timelapse,
                                        color: Colors.redAccent,
                                      )),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'PENGISIAN STOK SELANJUTNYA',
                        style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      const Text(
                        'Jumat, 5 Maret 2022 pada 08:00',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BlocConsumer<AturStockBlocBloc, AturStockBlocState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state.status == FormzStatus.submissionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Stok Berhasil Di Update'),
              ),
            );
          } else if (state.status == FormzStatus.submissionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Terjadi kesalahan'),
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: state.stokInput.valid ||
                      state.timeReset.valid ||
                      state.tipeRestok.valid
                  //   &&
                  // state.tipeRestok.valid &&
                  // state.timeReset.valid
                  ? () {
                      final stok = widget.user;
                      context.read<AturStockBlocBloc>().add(
                            AturStok(stok),
                          );
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text('SIMPAN'),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                tapTargetSize: MaterialTapTargetSize.padded,
              ),
            ),
          );
        },
      ),
    );
  }
}
