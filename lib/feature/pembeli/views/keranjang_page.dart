import 'package:cafetaria/components/alertdialog/alert_dialog_widget.dart';
import 'package:cafetaria/feature/pembeli/data/data_sources/makanan_datasource.dart';
import 'package:cafetaria/feature/pembeli/data/model/makanan_model.dart';
import 'package:cafetaria/feature/pembeli/data/model/order_model.dart';
import 'package:cafetaria/feature/pembeli/views/topping_page.dart';
import 'package:cafetaria/utilities/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  @override
  Widget build(BuildContext context) {
    return Consumer<OrderNotifier>(
        builder: (context, OrderNotifier model, child) {
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                children: [
                  Container(
                      padding: const EdgeInsets.all(16),
                      width: SizeConfig.screenWidth,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: const DecorationImage(
                              image: AssetImage(
                                  'assets/overlay/card_overlay_orange.png'),
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
                          Image.asset('assets/illustration/ill_cafetaria.png',
                              width: SizeConfig.safeBlockHorizontal * 20,
                              fit: BoxFit.fitWidth),
                          SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Lokasi Anda Sekarang',
                                  style: textStyle.copyWith(
                                      color: Colors.white.withOpacity(.7))),
                              SizedBox(
                                  height: SizeConfig.safeBlockVertical * .5),
                              Text(
                                'Apartemen Skyline Residence',
                                style: textStyle.copyWith(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: Colors.white),
                              ),
                              SizedBox(
                                  height: SizeConfig.safeBlockVertical * .25),
                              Text('Tower A • Lantai 3A • Nomor 37 ',
                                  style: textStyle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Colors.white))
                            ],
                          )
                        ],
                      )),
                  SizedBox(height: SizeConfig.safeBlockVertical * 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PESANANMU',
                        style:
                            textStyle.copyWith(color: const Color(0xff8C8F93)),
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
                        return item(
                            model.getData[index], model.getMenuData[index]);
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: SizeConfig.safeBlockVertical * 3,
                          ),
                      itemCount: model.getData.length),
                  SizedBox(height: SizeConfig.safeBlockVertical * 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Subtotal',
                        style: textStyle,
                      ),
                      Text(
                        'Rp ' +
                            Provider.of<OrderNotifier>(context, listen: false)
                                .getTotalPrice()
                                .toString(),
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
                        'Rp ' +
                            (Provider.of<OrderNotifier>(context, listen: false)
                                        .getTotalPrice() +
                                    2000)
                                .toString(),
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
                    padding:
                        MaterialStateProperty.all(const EdgeInsets.all(16)),
                    elevation: MaterialStateProperty.all(0),
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xffee3124)),
                    foregroundColor:
                        MaterialStateProperty.all(const Color(0xffee3124)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide.none))),
                onPressed: () async {
                  SharedPreferences sharedPreferences =
                      await SharedPreferences.getInstance();
                  String? id = sharedPreferences.getString("userId");
                  String? apartement =
                      sharedPreferences.getString("apartement");
                  OrderModel order = OrderModel(
                      userId: id!,
                      apartmentId: apartement!,
                      merchantId: model.getData[0].merchantId,
                      orders: model.getData);
                  setState(() {
                    _loading = true;
                  });
                  bool response = await addFoodOrder(order);
                  setState(() {
                    _loading = false;
                  });
                  if (response) {
                    var baseDialog = const AlertDialogWait(
                      title: 'Makanan Anda sedang diproses',
                      message:
                          'Harap menunggu notifikasi melalui app ketika makanan sudah siap untuk diantar atau dijemput.',
                      buttonText: 'KEMBALI KE HOME',
                    );
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => baseDialog);
                  }
                },
                child: Text(
                  'PESAN',
                  style:
                      headlineStyle.copyWith(color: Colors.white, fontSize: 14),
                )),
          ),
        ),
      );
    });
  }

  Widget item(FoodOrder order, Menu menu) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(order.qty.toString() + 'x',
              style: textStyle.copyWith(
                  fontWeight: FontWeight.w500, fontSize: 13)),
          SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(order.item.itemName,
                  style: textStyle.copyWith(
                      fontWeight: FontWeight.w500, fontSize: 13)),
              order.item.toppings.isNotEmpty
                  ? SizedBox(height: SizeConfig.safeBlockVertical * 1)
                  : const SizedBox(),
              order.item.toppings.isNotEmpty
                  ? Text(order.item.toppings[0].name,
                      style: textStyle.copyWith(
                          color: const Color(0xffB1B5BA), fontSize: 13))
                  : const SizedBox(),
              SizedBox(height: SizeConfig.safeBlockVertical * 1),
              GestureDetector(
                onTap: () async {
                  FoodOrder updOrder = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ToppingPage(
                              photo: 'assets/illustration/ill_food.png',
                              foodItem: menu,
                              qty: order.qty,
                              note: order.note)));
                  if (updOrder.qty == 0) {
                    Provider.of<OrderNotifier>(context, listen: false)
                        .removeData(updOrder);
                    Provider.of<OrderNotifier>(context, listen: false)
                        .removeMenuData(menu);
                  } else {
                    Provider.of<OrderNotifier>(context, listen: false)
                        .updateData(updOrder);
                  }
                },
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
            'Rp. ${order.totalPrice}',
            style:
                textStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 13),
          )
        ],
      ),
    );
  }
}
