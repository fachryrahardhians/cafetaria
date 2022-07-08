import 'package:cafetaria/feature/pembeli/data/data_sources/makanan_datasource.dart';
import 'package:cafetaria/feature/pembeli/data/model/makanan_model.dart';
import 'package:cafetaria/feature/pembeli/data/model/order_model.dart';
import 'package:cafetaria/feature/pembeli/views/keranjang_page.dart';
import 'package:cafetaria/feature/pembeli/views/topping_page.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cafetaria/utilities/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MerchantPage extends StatelessWidget {
  final String title;
  const MerchantPage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListMenu(title: title);
  }
}

class ListMenu extends StatefulWidget {
  final String title;
  const ListMenu({Key? key, required this.title}) : super(key: key);

  @override
  State<ListMenu> createState() => _ListMenuState(title);
}

class _ListMenuState extends State<ListMenu> {
  String title;
  _ListMenuState(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCFBFC),
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xffee3124)),
          backgroundColor: const Color(0xffFCFBFC),
          elevation: 0),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16.0),
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff333435)),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 2),
          _merchantInfo(),
          SizedBox(height: SizeConfig.safeBlockVertical * 3),
          _customerInfo(),
          SizedBox(height: SizeConfig.safeBlockVertical * 3),
          Text(
            'REKOMENDASI UNTUKMU',
            style: normalText.copyWith(color: const Color(0xff8C8F93)),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 1),
          _recomendation(),
          SizedBox(height: SizeConfig.safeBlockVertical * 1),
          Text(
            'AYAM',
            style: normalText.copyWith(color: const Color(0xff8C8F93)),
          ),
          SizedBox(height: SizeConfig.safeBlockVertical * 1),
          _listMenu(),
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
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ChangeNotifierProvider<OrderNotifier>(
                            create: (_) => OrderNotifier(),
                            child: const KeranjangPage())));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                      text: TextSpan(
                          text: 'Keranjang • ',
                          style: normalText.copyWith(
                              fontSize: 14, color: Colors.white),
                          children: [
                        TextSpan(
                            text: Provider.of<OrderNotifier>(context,
                                        listen: false)
                                    .getTotalQty()
                                    .toString() +
                                ' Pesanan',
                            style: normalText.copyWith(
                                fontSize: 14, color: Colors.white)),
                      ])),
                  Text(
                      'Rp. ' +
                          Provider.of<OrderNotifier>(context, listen: false)
                              .getTotalPrice()
                              .toString(),
                      style: normalText.copyWith(
                          fontSize: 14, color: Colors.white)),
                ],
              )),
        ),
      ),
    );
  }

  Widget _merchantInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.star_rounded, color: MyColors.yellow1),
                  SizedBox(width: 4),
                  Text('4.3')
                ],
              ),
              Text(
                '80+ Ulasan',
                style: normalText,
              )
            ],
          ),
        ),
        SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.wallet, color: MyColors.yellow1),
                  SizedBox(width: 4),
                  Text('Harga')
                ],
              ),
              Text(
                '14rb-24rb',
                style: normalText,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _recomendation() {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      physics: const ScrollPhysics(),
      mainAxisSpacing: SizeConfig.safeBlockVertical * 2,
      children: [
        makananGrid('assets/images/ill_food.png', 'Nasi Ayam Bakar',
            'Rp. 20000', false, ''),
        makananGrid('assets/images/ill_food.png', 'Nasi Ayam Bakar',
            'Rp. 20000', true, 'Rp 30.000'),
        makananGrid('assets/images/ill_food.png', 'Nasi Ayam Bakar',
            'Rp. 20000', false, ''),
        makananGrid('assets/images/ill_food.png', 'Nasi Ayam Bakar',
            'Rp. 20000', false, '')
      ],
    );
  }

  Widget _listMenu() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const SelectToppingPage(
                          photo: 'assets/images/ill_food.png',
                        )));
          },
          child: makananList('assets/images/ill_food.png', 'itemName', 0, false,
              0, 'itemId$index'),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(height: SizeConfig.safeBlockVertical * 1);
      },
    );
  }

  Widget _customerInfo() {
    return Container(
        padding: const EdgeInsets.all(16),
        width: SizeConfig.screenWidth,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
                image: AssetImage('assets/images/card_overlay_orange.png'),
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
            Image.asset('assets/images/ill_cafetaria.png',
                width: SizeConfig.safeBlockHorizontal * 20,
                fit: BoxFit.fitWidth),
            SizedBox(width: SizeConfig.safeBlockHorizontal * 2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Shabrina',
                    style: normalText.copyWith(
                        color: Colors.white.withOpacity(.7))),
                SizedBox(height: SizeConfig.safeBlockVertical * .5),
                Text(
                  '6281397979797',
                  style: normalText.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                      color: Colors.white),
                ),
                SizedBox(height: SizeConfig.safeBlockVertical * .25),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 50,
                  child: Text(
                      'Jl. HR Rasuna Said One Kav No.62, RT.18/RW.2, Kel. Karet Kuningan, Kec. Setiabudi, Jakarta Selatan',
                      style: normalText.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Colors.white)),
                )
              ],
            )
          ],
        ));
  }

  Widget makananGrid(
      String image, String name, String price, bool promo, String discount) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: SizeConfig.safeBlockHorizontal * 30,
            height: SizeConfig.safeBlockHorizontal * 30,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.fill)),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 1,
          ),
          Text(name, style: normalText),
          Text(
            price,
            style: normalText.copyWith(fontSize: 12),
          ),
          promo
              ? Text(
                  discount,
                  style: normalText.copyWith(
                      decoration: TextDecoration.lineThrough,
                      decorationColor: const Color(0xffB2B4B5),
                      fontSize: 11,
                      color: const Color(0xffB2B4B5)),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  Widget makananList(String image, String name, int price, bool promo,
      double discount, String id) {
    return Consumer<OrderNotifier>(
        builder: (context, OrderNotifier model, child) {
      return IntrinsicHeight(
        child: OverflowBox(
          maxWidth: SizeConfig.screenWidth,
          child: Row(
            children: [
              Visibility(
                visible: model.getData
                        .indexWhere((element) => id == element.item.itemId) !=
                    -1,
                child: Container(width: 4, color: const Color(0xffEA001E)),
              ),
              const SizedBox(width: 20),
              Hero(
                tag: id,
                child: Container(
                  width: SizeConfig.safeBlockHorizontal * 20,
                  height: SizeConfig.safeBlockHorizontal * 20,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.fill)),
                ),
              ),
              SizedBox(
                width: SizeConfig.safeBlockHorizontal * 4,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      model.getData.indexWhere(
                                  (element) => id == element.item.itemId) !=
                              -1
                          ? model
                                  .getData[model.getData.indexWhere(
                                      (element) => id == element.item.itemId)]
                                  .qty
                                  .toString() +
                              'x $name'
                          : name,
                      style: model.getData.indexWhere(
                                  (element) => id == element.item.itemId) !=
                              -1
                          ? normalText.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffEA001E))
                          : normalText.copyWith(fontSize: 15)),
                  Text(
                    'Rp. $price',
                    style: normalText.copyWith(fontSize: 15),
                  ),
                  promo
                      ? Text(
                          'Rp. ' + (price / (1 - discount)).toStringAsFixed(0),
                          style: normalText.copyWith(
                              decoration: TextDecoration.lineThrough,
                              decorationColor: const Color(0xffB2B4B5),
                              fontSize: 11,
                              color: const Color(0xffB2B4B5)),
                        )
                      : const SizedBox()
                ],
              ))
            ],
          ),
        ),
      );
    });
  }
}

class MakananDetail extends StatefulWidget {
  final String title;
  const MakananDetail({Key? key, required this.title}) : super(key: key);

  @override
  _MakananDetailState createState() => _MakananDetailState(title);
}

class _MakananDetailState extends State<MakananDetail> {
  String title;
  _MakananDetailState(this.title);
  List<FoodOrder> orders = [];
  int total = 0;
  int price = 0;

  late Future<MakananModel> futureFoodItem;
  TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xff333435));
  TextStyle headlineStyle = const TextStyle(
      fontWeight: FontWeight.w700, fontSize: 24, color: Color(0xff333435));

  @override
  void initState() {
    super.initState();
    futureFoodItem = getFoodItems();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Consumer(builder: (context, OrderNotifier model, child) {
      return Scaffold(
        backgroundColor: const Color(0xffFCFBFC),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xffee3124)),
          backgroundColor: Colors.white,
          elevation: 1,
          title: Text(
            title,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff333435)),
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<MakananModel>(
            future: futureFoodItem,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24, vertical: 16.0),
                  children: [
                    Container(
                        padding: const EdgeInsets.all(16),
                        width: SizeConfig.screenWidth,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/card_overlay_orange.png'),
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
                    Text(
                      'REKOMENDASI UNTUKMU',
                      style: textStyle.copyWith(color: const Color(0xff8C8F93)),
                    ),
                    SizedBox(height: SizeConfig.safeBlockVertical * 1),
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      physics: const ScrollPhysics(),
                      mainAxisSpacing: SizeConfig.safeBlockVertical * 2,
                      children: [
                        makananGrid('assets/illustration/ill_food.png',
                            'Nasi Ayam Bakar', 'Rp. 20000', false, ''),
                        makananGrid('assets/illustration/ill_food.png',
                            'Nasi Ayam Bakar', 'Rp. 20000', true, 'Rp 30.000'),
                        makananGrid('assets/illustration/ill_food.png',
                            'Nasi Ayam Bakar', 'Rp. 20000', false, ''),
                        makananGrid('assets/illustration/ill_food.png',
                            'Nasi Ayam Bakar', 'Rp. 20000', false, '')
                      ],
                    ),
                    SizedBox(height: SizeConfig.safeBlockVertical * 1),
                    Text(
                      'AYAM',
                      style: textStyle.copyWith(color: const Color(0xff8C8F93)),
                    ),
                    SizedBox(height: SizeConfig.safeBlockVertical * 1),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemCount: snapshot.data!.data.menus.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () async {
                            int i = model.getData.indexWhere((element) =>
                                element.item.itemId ==
                                snapshot.data!.data.menus[index].itemId);
                            FoodOrder order = i != -1
                                ? await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ToppingPage(
                                              photo:
                                                  'assets/illustration/ill_food.png',
                                              foodItem: snapshot
                                                  .data!.data.menus[index],
                                              qty: model.getData[i].qty,
                                              note: model.getData[i].note,
                                            )))
                                : await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => ToppingPage(
                                              photo:
                                                  'assets/illustration/ill_food.png',
                                              foodItem: snapshot
                                                  .data!.data.menus[index],
                                              qty: 0,
                                              note: '',
                                            )));
                            if (order.qty == 0) {
                              Provider.of<OrderNotifier>(context, listen: false)
                                  .removeData(order);
                              Provider.of<OrderNotifier>(context, listen: false)
                                  .removeMenuData(
                                      snapshot.data!.data.menus[index]);
                            } else {
                              int i = model.getData.indexWhere((element) =>
                                  element.item.itemId == order.item.itemId);
                              if (i != -1) {
                                Provider.of<OrderNotifier>(context,
                                        listen: false)
                                    .updateData(order);
                              } else {
                                Provider.of<OrderNotifier>(context,
                                        listen: false)
                                    .addData(order);
                                Provider.of<OrderNotifier>(context,
                                        listen: false)
                                    .addMenuData(
                                        snapshot.data!.data.menus[index]);
                              }
                            }
                          },
                          child: makananList(
                              'assets/illustration/ill_food.png',
                              snapshot.data!.data.menus[index].itemName,
                              snapshot.data!.data.menus[index].price,
                              snapshot.data!.data.menus[index].isActivePromo,
                              snapshot.data!.data.menus[index].percentPromo,
                              snapshot.data!.data.menus[index].itemId),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                            height: SizeConfig.safeBlockVertical * 1);
                      },
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
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
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ChangeNotifierProvider<OrderNotifier>(
                              create: (_) => OrderNotifier(),
                              child: const KeranjangPage())));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Keranjang • ',
                            style: headlineStyle.copyWith(
                                fontSize: 14, color: Colors.white),
                            children: [
                          TextSpan(
                              text: Provider.of<OrderNotifier>(context,
                                          listen: false)
                                      .getTotalQty()
                                      .toString() +
                                  ' Pesanan',
                              style: textStyle.copyWith(
                                  fontSize: 14, color: Colors.white)),
                        ])),
                    Text(
                        'Rp. ' +
                            Provider.of<OrderNotifier>(context, listen: false)
                                .getTotalPrice()
                                .toString(),
                        style: headlineStyle.copyWith(
                            fontSize: 14, color: Colors.white)),
                  ],
                )),
          ),
        ),
      );
    });
  }

  Widget makananGrid(
      String image, String name, String price, bool promo, String discount) {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: SizeConfig.safeBlockHorizontal * 30,
            height: SizeConfig.safeBlockHorizontal * 30,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.fill)),
          ),
          SizedBox(
            height: SizeConfig.safeBlockVertical * 1,
          ),
          Text(name, style: textStyle),
          Text(
            price,
            style: headlineStyle.copyWith(fontSize: 12),
          ),
          promo
              ? Text(
                  discount,
                  style: textStyle.copyWith(
                      decoration: TextDecoration.lineThrough,
                      decorationColor: const Color(0xffB2B4B5),
                      fontSize: 11,
                      color: const Color(0xffB2B4B5)),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  Widget makananList(String image, String name, int price, bool promo,
      double discount, String id) {
    return Consumer<OrderNotifier>(
        builder: (context, OrderNotifier model, child) {
      return IntrinsicHeight(
        child: OverflowBox(
          maxWidth: SizeConfig.screenWidth,
          child: Row(
            children: [
              Visibility(
                visible: model.getData
                        .indexWhere((element) => id == element.item.itemId) !=
                    -1,
                child: Container(width: 4, color: const Color(0xffEA001E)),
              ),
              const SizedBox(width: 20),
              Hero(
                tag: id,
                child: Container(
                  width: SizeConfig.safeBlockHorizontal * 20,
                  height: SizeConfig.safeBlockHorizontal * 20,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.fill)),
                ),
              ),
              SizedBox(
                width: SizeConfig.safeBlockHorizontal * 4,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      model.getData.indexWhere(
                                  (element) => id == element.item.itemId) !=
                              -1
                          ? model
                                  .getData[model.getData.indexWhere(
                                      (element) => id == element.item.itemId)]
                                  .qty
                                  .toString() +
                              'x $name'
                          : name,
                      style: model.getData.indexWhere(
                                  (element) => id == element.item.itemId) !=
                              -1
                          ? textStyle.copyWith(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xffEA001E))
                          : textStyle.copyWith(fontSize: 15)),
                  Text(
                    'Rp. $price',
                    style: headlineStyle.copyWith(fontSize: 15),
                  ),
                  promo
                      ? Text(
                          'Rp. ' + (price / (1 - discount)).toStringAsFixed(0),
                          style: textStyle.copyWith(
                              decoration: TextDecoration.lineThrough,
                              decorationColor: const Color(0xffB2B4B5),
                              fontSize: 11,
                              color: const Color(0xffB2B4B5)),
                        )
                      : const SizedBox()
                ],
              ))
            ],
          ),
        ),
      );
    });
  }
}
