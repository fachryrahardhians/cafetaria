import 'package:cafetaria/components/tiles/custom_tiles.dart';
import 'package:cafetaria/feature/penjual_order/bloc/penjual_action_order/penjual_action_order_bloc.dart';
import 'package:cafetaria/feature/penjual_order/bloc/penjual_action_order/penjual_action_order_event.dart';
import 'package:cafetaria/feature/penjual_order/bloc/penjual_action_order/penjual_action_order_state.dart';
import 'package:cafetaria/feature/penjual_order/views/order_page/model/order_model.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:penjual_order_repository/penjual_order_repository.dart';

class DetailOrderPage extends StatelessWidget {
  const DetailOrderPage({Key? key, required this.order}) : super(key: key);

  final PenjualOrderModel order;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PenjualActionOrderBloc>(
      create: (context) =>
          PenjualActionOrderBloc(context.read<PenjualOrderRepository>())
            ..add(ActionPenjualInitial(order)),
      child: const DetailOrderPageView(
          // order: order,
          ),
    );
  }
}

class DetailOrderPageView extends StatelessWidget {
  const DetailOrderPageView({Key? key}) : super(key: key);

  // final PenjualOrderModel order;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PenjualActionOrderBloc, PenjualActionOrderState>(
      listener: (context, state) {
        if (state.status == PenjualActionStatus.done) {
          if (state.order!.statusOrder == 'process') {
            //todo show dialog berhasil
            //todo ketika dialog berhasil dipop , panggil pop sekali lagi
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => const Dialog(
                      backgroundColor: Colors.transparent,
                      child: PenjualOrderFinishSuccessDialog(),
                    )).then((value) {
              Navigator.pop(context);
            });
          }
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<PenjualActionOrderBloc, PenjualActionOrderState>(
        builder: (context, state) {
          if (state.order != null) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: const Color(0xffF9FAFB),
                elevation: 0,
                leading: const BackButton(
                  color: MyColors.red1,
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(30),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 24,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Detail Pesanan",
                          style: extraBigText.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              body: LoadingOverlay(
                isLoading: state.status == PenjualActionStatus.loading,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    // DetailOrderCard(),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      clipBehavior: Clip.antiAlias,
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.04),
                              offset: Offset(0, 0),
                              spreadRadius: 3,
                              blurRadius: 3,
                            ),
                          ]),
                      child: Row(
                        children: [
                          CustomTileDateBox(
                            timestamp: state.order!.pickupDate!,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Order #${state.order!.docId}",
                                style: bigText.copyWith(
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Apartemen Skyline Residence",
                                style: bigText,
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                "Tower A • Lantai 3A • Nomor 37",
                                style: normalText,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        title: Text(
                          "DETAIL PELANGGAN",
                          style: normalText.copyWith(
                              color: const Color(0xff8C8F93),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.8),
                        ),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        expandedAlignment: Alignment.centerLeft,
                        childrenPadding:
                            const EdgeInsets.symmetric(horizontal: 24),
                        tilePadding: const EdgeInsets.symmetric(horizontal: 24),
                        children: [
                          detailPelangganTile(
                            name: "nama pelanggan",
                            value: "Salma Tahira",
                          ),
                          detailPelangganTile(
                            name: "nomor handphone",
                            value: "081397979797",
                          ),
                          detailPelangganTile(
                              name: "alamat",
                              value: "Apartemen Skyline Residence",
                              detail: "Tower A • Lantai 3A • Nomor 37"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        "DETAIL TAGIHAN",
                        style: normalText.copyWith(
                            color: const Color(0xff8C8F93),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: List.generate(
                            state.order!.menus!.length,
                            (i) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(6),
                                        2: FlexColumnWidth(2),
                                      },
                                      children: [
                                        ///table row 1 untuk qty , nama , harga per menu
                                        TableRow(children: [
                                          Text(
                                            "${state.order!.menus![i].qty}x",
                                            style: bigText.copyWith(
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            "${state.order!.menus![i].detailMenu != null ? state.order!.menus![i].detailMenu!.name : '--------'}",
                                            style: bigText.copyWith(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "Rp.${NumberFormat("###,###").format(state.order!.menus![i].price)}",
                                            style: bigText.copyWith(
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.end,
                                          )
                                        ]),
                                        const TableRow(
                                          children: [
                                            SizedBox(height: 10),
                                            SizedBox(height: 10),
                                            SizedBox(height: 10),
                                          ],
                                        ),

                                        ///table row 2 untuk topping
                                        TableRow(children: [
                                          Container(),
                                          Column(
                                            children: List.generate(
                                              state.order!.menus![i].toppings!
                                                  .length,
                                              (itopp) => Row(
                                                children: [
                                                  Text(
                                                    'Porsi ${itopp + 1}: ',
                                                    style: normalText.copyWith(
                                                      color: const Color(
                                                          0xff8C8F93),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text.rich(
                                                      TextSpan(
                                                        children: List<
                                                            TextSpan>.generate(
                                                          state
                                                              .order!
                                                              .menus![i]
                                                              .toppings![itopp]
                                                              .items!
                                                              .length,
                                                          (iitem) => TextSpan(
                                                            text:
                                                                "${state.order!.menus![i].toppings![itopp].items![iitem].name},",
                                                            style: normalText
                                                                .copyWith(
                                                              color: const Color(
                                                                  0xff8C8F93),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(),
                                        ]),
                                        const TableRow(
                                          children: [
                                            SizedBox(height: 10),
                                            SizedBox(height: 10),
                                            SizedBox(height: 10),
                                          ],
                                        ),

                                        ///table row 3 untuk catatan
                                        TableRow(children: [
                                          Container(),
                                          Text.rich(
                                            TextSpan(children: [
                                              TextSpan(
                                                text: 'Catatan : ',
                                                style: normalText.copyWith(
                                                  color: MyColors.red1,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    '${state.order!.menus![i].notes}',
                                                style: normalText.copyWith(
                                                  color: Colors.grey,
                                                ),
                                              ),
                                            ]),
                                          ),
                                          Container(),
                                        ]),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                )),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "TOTAL PEMBAYARAN",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.3),
                          ),
                          Text(
                            "Rp. ${NumberFormat('###,###').format(state.order!.total)}",
                            style: const TextStyle(
                                fontSize: 13, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: ['declined', 'finish']
                          .contains(state.order!.statusOrder),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                    text: "Keterangan : ",
                                    style:
                                        bigText.copyWith(color: MyColors.red1)),
                                TextSpan(
                                    text: state.order!.keterangan ?? '',
                                    style:
                                        bigText.copyWith(color: MyColors.grey2))
                              ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: ['new'].contains(state.order!.statusOrder),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            Text(
                              "KETERANGAN",
                              style: normalText.copyWith(
                                  color: const Color(0xff5C5E61)),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 0),
                              clipBehavior: Clip.antiAlias,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 10),
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0, 0),
                                      spreadRadius: 0,
                                      blurRadius: 1,
                                    ),
                                  ]),
                              child: TextFormField(
                                // controller: ,
                                onChanged: (val) {
                                  context
                                      .read<PenjualActionOrderBloc>()
                                      .add(ActionPenjualUpdateKeterangan(val));
                                },
                                maxLines: 4,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Masukkan Keterangan',
                                  hintStyle: smallText.copyWith(
                                    color: const Color(0xfff2f2f2),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: const DetailOrderActionBuilder(),
            );
          }
          return const Scaffold(
            body: Center(child: Text('Loading...')),
          );
        },
      ),
    );
  }

  Column detailPelangganTile(
      {required String name, required String value, String? detail}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          name.toUpperCase(),
          style: normalText.copyWith(
              color: const Color(0xff8C8F93),
              fontWeight: FontWeight.w600,
              letterSpacing: 1),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          value,
          style: normalText.copyWith(
            letterSpacing: 0.8,
          ),
        ),
        detail != null
            ? const SizedBox(
                height: 5,
              )
            : Container(),
        detail != null
            ? Text(
                detail,
                style: normalText.copyWith(
                  letterSpacing: 0.8,
                ),
              )
            : Container(),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }
}

class CustomTileDateBox extends StatelessWidget {
  const CustomTileDateBox({Key? key, required this.timestamp})
      : super(key: key);

  final Timestamp timestamp;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      padding: const EdgeInsets.symmetric(vertical: 2),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff808285),
              Color(0xff808285),
              Color(0xff333435),
            ],
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            DateFormat('EEE').format(timestamp.toDate()),
            style: normalText.copyWith(color: Colors.white),
          ),
          Text(
            "${timestamp.toDate().day}",
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
          Text(
            DateFormat('MMM').format(timestamp.toDate()),
            style: normalText.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class DetailOrderActionBuilder extends StatelessWidget {
  const DetailOrderActionBuilder({Key? key}) : super(key: key);

  // final String status;
  // final PenjualOrderModel data;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PenjualActionOrderBloc, PenjualActionOrderState>(
      listener: (context, state) {},
      child: BlocBuilder<PenjualActionOrderBloc, PenjualActionOrderState>(
        builder: (context, state) {
          switch (state.order!.statusOrder) {
            case 'new':
              return _new(context);
            case 'process':
              return _process(context);
            case 'declined':
              return _declined(context);
            case 'finish':
              return _finish(context);
            default:
              return _finish(context);
          }
        },
      ),
    );
    // switch (status.toLowerCase()) {
    //   case 'new':
    // }
    // return _new(context);
  }

  Widget _new(BuildContext context) {
    return BlocBuilder<PenjualActionOrderBloc, PenjualActionOrderState>(
      builder: (context, state) {
        return Row(
          children: [
            Flexible(
                child: InkWell(
              onTap: () {
                context.read<PenjualActionOrderBloc>().add(ActionPenjualToOrder(
                    data: state.order!
                        .copyWithOrderStatus('declined', state.keterangan)
                        .toJson(),
                    docId: state.order!.docId!));
              },
              child: Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(6),
                  ),
                  border: Border.all(color: MyColors.red1),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    "TOLAK",
                    style: bigText.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: 1.5),
                  ),
                ),
              ),
            )),
            Flexible(
                child: InkWell(
              onTap: () {
                context.read<PenjualActionOrderBloc>().add(ActionPenjualToOrder(
                    data: state.order!
                        .copyWithOrderStatus('process', state.keterangan)
                        .toJson(),
                    docId: state.order!.docId!));
              },
              child: Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6),
                  ),
                  border: Border.all(color: MyColors.red1),
                  color: MyColors.red1,
                ),
                child: Center(
                  child: Text(
                    "TERIMA",
                    style: bigText.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5),
                  ),
                ),
              ),
            )),
          ],
        );
      },
    );
  }

  Widget _declined(BuildContext context) {
    return const SizedBox.shrink();
  }

  Widget _finish(BuildContext context) {
    return const SizedBox.shrink();
  }

  Widget _process(BuildContext context) {
    return BlocBuilder<PenjualActionOrderBloc, PenjualActionOrderState>(
      builder: (context, state) {
        return Row(
          children: [
            Flexible(
                child: InkWell(
              onTap: () {
                ///tampilkan dialog nilai bayar manual
                ///
                showDialog<DialogBayarManualValue>(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => Dialog(
                          backgroundColor: Colors.transparent,
                          child: DialogBayarManual(),
                        )).then((value) {
                  ///action submit disini
                  context.read<PenjualActionOrderBloc>().add(
                        ActionPenjualToOrder(
                            data: state.order!
                                .copyWithOrderStatus(
                                    'finish', "${state.keterangan}",
                                    cash: value!.cash,
                                    change: (value.cash - state.order!.total!)
                                        .toString())
                                .toJson(),
                            docId: state.order!.docId!),
                      );
                });
              },
              child: Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(6),
                  ),
                  border: Border.all(color: MyColors.red1),
                  color: MyColors.red1,
                ),
                child: Center(
                  child: Text(
                    "BAYAR MANUAL",
                    style: bigText.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.5),
                  ),
                ),
              ),
            )),
          ],
        );
      },
    );
  }
}

class DialogBayarManualValue {
  final bool isDone;
  final int cash;

  DialogBayarManualValue({
    required this.isDone,
    required this.cash,
  });
}

class DialogBayarManual extends StatelessWidget {
  DialogBayarManual({Key? key}) : super(key: key);

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "NILAI TRANSAKSI",
            style: bigText.copyWith(
                color: const Color(0xff8C8F93),
                fontWeight: FontWeight.w600,
                letterSpacing: 1),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0, 0),
                    spreadRadius: 0,
                    blurRadius: 1,
                  ),
                ]),
            child: TextFormField(
              controller: controller,
              maxLines: 1,
              keyboardType: const TextInputType.numberWithOptions(),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefix: Text('Rp. '),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          InkWell(
            onTap: () {
              ///action setelah input
              if (controller.text.isNotEmpty) {
                Navigator.pop(
                    context,
                    DialogBayarManualValue(
                        isDone: true, cash: int.parse(controller.text)));
              } else {
                Navigator.pop(
                    context, DialogBayarManualValue(isDone: false, cash: 0));
              }
            },
            child: Container(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(6),
                ),
                border: Border.all(color: MyColors.red1),
                color: MyColors.red1,
              ),
              child: Center(
                child: Text(
                  "BAYAR",
                  style: bigText.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PenjualOrderFinishSuccessDialog extends StatelessWidget {
  const PenjualOrderFinishSuccessDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            CupertinoIcons.checkmark_seal_fill,
            color: Colors.greenAccent,
            size: 72,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Transaksi Berhasil !",
            style: bigText.copyWith(
                color: const Color(0xff8C8F93),
                fontWeight: FontWeight.bold,
                letterSpacing: 1),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Pembayaran telah berhasil",
            style: normalText.copyWith(letterSpacing: 1),
          ),
          const SizedBox(
            height: 12,
          ),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 50,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(6),
                ),
                border: Border.all(color: MyColors.red1),
                color: MyColors.red1,
              ),
              child: Center(
                child: Text(
                  "OK",
                  style: bigText.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
