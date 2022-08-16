import 'package:cafetaria/feature/penjual/bloc/add_menu_penjual_bloc/add_menu_penjual_bloc.dart';
import 'package:cafetaria/feature/penjual/bloc/atur_stock_bloc/atur_stock_bloc_bloc.dart';
import 'package:cafetaria/feature/penjual/bloc/list_menu_bloc/list_menu_bloc.dart';
import 'package:cafetaria/feature/penjual/bloc/menu_makanan_bloc/menu_makanan_bloc.dart';
import 'package:cafetaria/feature/penjual/views/add_menu_page.dart';
import 'package:cafetaria/feature/penjual/views/add_menu_penjual_page.dart';
import 'package:cafetaria/feature/penjual/views/add_opsi_menu_page.dart';
import 'package:cafetaria/feature/penjual/views/widgets/switch.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria_ui/cafetaria_ui.dart';
import 'package:category_repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:menu_repository/menu_repository.dart';

class EditStok extends StatelessWidget {
  const EditStok({Key? key, required this.menuModel}) : super(key: key);
  final MenuModel menuModel;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AturStockBlocBloc(menuRepository: context.read<MenuRepository>()),
      child: StockMenuDetailPage(user: menuModel),
    );
  }
}

class StockMenuDetailPage extends StatefulWidget {
  final MenuModel user;
  const StockMenuDetailPage({Key? key, required this.user}) : super(key: key);

  @override
  State<StockMenuDetailPage> createState() => _StockMenuDetailPageState();
}

class _StockMenuDetailPageState extends State<StockMenuDetailPage> {
  final oCcy = NumberFormat("#,##0.00", "IDR");
  String _chosenValue = 'jam';
  bool _isAvailable = true;
  bool restock = false;
  TimeOfDay time = const TimeOfDay(hour: 10, minute: 30);
  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(child: Text("Setiap Jam"), value: "jam"),
      const DropdownMenuItem(child: Text("Harian"), value: "hari"),
      const DropdownMenuItem(child: Text("Mingguan"), value: "minggu"),
    ];
    return menuItems;
  }

  // TextEditingController tanggalController = TextEditingController();
  DateTime date = DateTime(2022, 12, 24);
  TextEditingController? _stokBarang;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.user.stock);
    setState(() {
      _stokBarang = TextEditingController(text: widget.user.stock.toString());
      widget.user.stock == 0 ? _isAvailable = false : _isAvailable = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    //  final _scaffold = GlobalKey<ScaffoldState>();
    final aturStokState =
        context.select((AturStockBlocBloc element) => element.state);
    final hours = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    // final restok =
    //     context.select((AturStockBlocBloc bloc) => bloc.state.restok);
    // final restokTipe =
    //     context.select((AturStockBlocBloc bloc) => bloc.state.tipeRestok);
    return Scaffold(
      //   key: _scaffold,
      appBar: AppBar(
        title: const Text("Atur Stock Menu"),
        backgroundColor: Colors.white,
      ),
      // bottomNavigationBar: Padding(
      //     padding: const EdgeInsets.all(20),
      //     child: CFButton.primary(
      //       child: (aturStokState.status == FormzStatus.submissionInProgress)
      //           ? const CircularProgressIndicator()
      //           : const Text('SIMPAN'),
      //       onPressed: aturStokState.stokInput.valid
      //           ? () {
      //               final stok = widget.user;
      //               context.read<AturStockBlocBloc>().add(
      //                     AturStok(stok),
      //                   );
      //             }
      //           : null,
      //     )),
      bottomNavigationBar: BlocConsumer<AturStockBlocBloc, AturStockBlocState>(
        listener: (context, state) {
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
              padding: const EdgeInsets.all(20),
              child: CFButton.primary(
                child: (state.status == FormzStatus.submissionInProgress)
                    ? const CircularProgressIndicator()
                    : const Text('SIMPAN'),
                onPressed: state.stokInput.valid
                    //   &&
                    // state.tipeRestok.valid &&
                    // state.timeReset.valid
                    ? () {
                        final stok = widget.user;
                        context.read<AturStockBlocBloc>().add(
                              AturStok(stok),
                            );
                      }
                    : null,
              ));
        },
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      //  margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          color: CFColors.grayscaleBlack50,
                          borderRadius: BorderRadius.circular(7.0),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.5),
                          //     spreadRadius: 2,
                          //     blurRadius: 10,
                          //     offset: const Offset(
                          //         5, 3), // changes position of shadow
                          //   ),
                          // ],
                          image: DecorationImage(
                              image: NetworkImage(widget.user.image == null
                                  ? "https://i.pinimg.com/564x/94/17/82/941782f60e16a9d7f9b4cea4ae7025e0.jpg"
                                  : widget.user.image.toString()),
                              fit: BoxFit.fill)),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.7,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(bottom: 9),
                                child: SizedBox(
                                  child: Text(
                                    widget.user.name.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        // fontFamily: 'Raleway',
                                        fontWeight: FontWeight.w500),
                                  ),
                                )),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 9),
                              child: Text(
                                "Rp ${oCcy.format(widget.user.price)}",
                                style: TextStyle(
                                    color: CFColors.darkGrey,
                                    fontSize: 14,
                                    //fontFamily: 'Raleway',
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Text(
                              "1 Opsi Menu Terhubung",
                              style: TextStyle(
                                  color: CFColors.greenAccent,
                                  fontSize: 14,
                                  //fontFamily: 'Raleway',
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: BottomSheetSwitch(
                        switchValue: _isAvailable,
                        valueChanged: (value) {
                          _isAvailable = value;
                          print(_isAvailable);
                          context
                              .read<AturStockBlocBloc>()
                              .add(AturStokTersedia(_isAvailable));
                        },
                      ),
                    )
                  ],
                ),
                const Padding(
                    padding: EdgeInsets.only(top: 20, left: 5, bottom: 10),
                    child: SizedBox(
                      child: Text(
                        "Stok Menu",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            // fontFamily: 'Raleway',
                            fontWeight: FontWeight.w500),
                      ),
                    )),
                Container(
                  height: 47,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                  decoration: BoxDecoration(
                    //color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 0.0,
                    ),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _stokBarang,
                    onChanged: (value) async {
                      context
                          .read<AturStockBlocBloc>()
                          .add(AturStokJumlah(value));
                    },
                    decoration: const InputDecoration(
                      hintText: 'Jumlah Stok',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Terapkan Sebagai berulang",
                        style: TextStyle(
                          fontSize: 18,
                          //fontFamily: 'Raleway'
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      BottomSheetSwitch(
                          switchValue: restock,
                          valueChanged: (value) async {
                            restock = value;
                            context
                                .read<AturStockBlocBloc>()
                                .add(AturStokRestok(restock));
                            //   print(restock);
                          }),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Padding(
                        padding: EdgeInsets.only(left: 5, bottom: 10),
                        child: SizedBox(
                          child: Text(
                            "Atur Ulang Batas Penjualan",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                // fontFamily: 'Raleway',
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.0),
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.0,
                        ),
                      ),
                      padding: const EdgeInsets.only(left: 12, right: 15),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: _chosenValue,
                          elevation: 16,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 17),
                          // underline: Container(
                          //   height: 2,
                          //   color: Colors.deepPurpleAccent,
                          // ),
                          hint: const SizedBox(
                            width: 150, //and here
                            child: Text(
                              "Pilih Atur Ulang Batas Penjualan",
                              style: TextStyle(color: Colors.grey),
                              textAlign: TextAlign.end,
                            ),
                          ),
                          icon: const Padding(
                              padding: EdgeInsets.only(left: 20),
                              child: Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: Colors.red,
                                size: 25,
                              )),
                          onChanged: (newValue) {
                            setState(() {
                              _chosenValue = newValue!;
                              context
                                  .read<AturStockBlocBloc>()
                                  .add(AturStokRestokType(_chosenValue));
                            });

                            //print(_chosenValue);
                          },
                          items: dropdownItems,
                        ),
                      ),
                    ),
                    const Padding(
                        padding: EdgeInsets.only(left: 5, top: 20),
                        child: SizedBox(
                          child: Text(
                            "Atur Ulang Pada Jam",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                                // fontFamily: 'Raleway',
                                fontWeight: FontWeight.w500),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
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
                                    "${time.hour} : ${time.minute}",
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
                                      context.read<AturStockBlocBloc>().add(
                                          AturStokTime(
                                              "${time.hour} : ${time.minute}"));
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
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
