import 'package:cafetaria/components/textfields/reusable_textfields.dart';
import 'package:cafetaria/feature/pembeli/bloc/add_menu_to_cart_bloc/add_menu_to_cart_bloc.dart';
import 'package:cafetaria/feature/pembeli/bloc/category_bloc/category_bloc.dart';
import 'package:cafetaria/feature/pembeli/bloc/check_menu_preorder_bloc/check_menu_preorder_bloc.dart';
import 'package:cafetaria/feature/pembeli/bloc/list_menu_bloc/list_menu_bloc.dart';
import 'package:cafetaria/feature/pembeli/bloc/list_recomended_menu_bloc/list_recomended_menu_bloc.dart';
import 'package:cafetaria/feature/pembeli/views/Chat_page.dart';
import 'package:cafetaria/feature/pembeli/views/keranjang_page.dart';
import 'package:cafetaria/feature/pembeli/views/topping_page.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:category_repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:provider/provider.dart';

class MakananPage extends StatelessWidget {
  final String title;
  final String idMerchant;
  final String iduser;
  final String? tutup_toko;
  final String? buka_toko;
  final String alamat;
  final double? rating;
  final int? jumlahUlasan;
  final int? minPrice;
  final int? maxPrice;
  const MakananPage(
      {Key? key,
      required this.tutup_toko,
      required this.buka_toko,
      required this.title,
      required this.iduser,
      required this.idMerchant,
      required this.alamat,
      required this.rating,
      required this.jumlahUlasan,
      required this.minPrice,
      required this.maxPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: ListMenu(
        buka_toko: buka_toko,
        iduser: iduser,
        tutup_toko: tutup_toko,
        title: title,
        idMerchant: idMerchant,
        alamat: alamat,
        rating: rating,
        jumlahUlasan: jumlahUlasan,
        minPrice: minPrice,
        maxPrice: maxPrice,
      ),
    );
  }
}

class ListMenu extends StatefulWidget {
  final String title;
  final String? tutup_toko;
  final String? buka_toko;
  final String idMerchant;
  final String alamat;
  final double? rating;
  final int? jumlahUlasan;
  final int? minPrice;
  final int? maxPrice;
  final String iduser;
  const ListMenu(
      {Key? key,
      required this.title,
      required this.tutup_toko,
      required this.buka_toko,
      required this.iduser,
      required this.idMerchant,
      required this.alamat,
      required this.rating,
      required this.jumlahUlasan,
      required this.minPrice,
      required this.maxPrice})
      : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ListMenu> createState() => _ListMenuState(title, idMerchant);
}

class _ListMenuState extends State<ListMenu> {
  String title;
  String idMerchant;
  _ListMenuState(this.title, this.idMerchant);

  late ListMenuBloc _listMenuBloc;
  late AddMenuToCartBloc _addMenuToCartBloc;
  late ListRecomendedMenuBloc _listRecomendedMenuBloc;
  late MenuPreorderBloc _menuPreorderBloc;

  int pesananCount = 0;
  int totalHarga = 0;
  List<Keranjang> listMenuInKeranjang = [];

  bool _preOrder = false;
  String? tutupToko;
  String? bukaToko;

  @override
  void initState() {
    _listMenuBloc =
        ListMenuBloc(menuRepository: context.read<MenuRepository>());
    _addMenuToCartBloc =
        AddMenuToCartBloc(menuRepository: context.read<MenuRepository>());
    _listRecomendedMenuBloc =
        ListRecomendedMenuBloc(menuRepository: context.read<MenuRepository>());
    _menuPreorderBloc =
        MenuPreorderBloc(menuRepository: context.read<MenuRepository>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.tutup_toko != null && widget.tutup_toko != "kosong") &&
        (widget.buka_toko != null && widget.buka_toko != "kosong")) {
      tutupToko = widget.tutup_toko;
      bukaToko = widget.buka_toko;
    }
    final dataProvider = Provider.of<DataProvider>(context);
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: ((context) => _addMenuToCartBloc..add(GetMenusInCart()))),
          BlocProvider(create: ((context) => _listMenuBloc)),
          BlocProvider(
              create: ((context) => _listRecomendedMenuBloc
                ..add(GetListRecomendedMenu(idMerchant)))),
          BlocProvider(create: ((context) => _menuPreorderBloc))
        ],
        child: WillPopScope(
          onWillPop: () {
            Navigator.pop(context);
            return Future.value(true);
          },
          child: Scaffold(
              backgroundColor: const Color(0xffFCFBFC),
              body: CustomScrollView(
                slivers: [
                  SliverPersistentHeader(
                    delegate: CustomSliverAppbarDelegate(
                        dataProvider: dataProvider,
                        expandedHeight: 200,
                        title: title,
                        idMerchant: idMerchant),
                    pinned: true,
                  ),
                  // SliverAppBar(
                  //     expandedHeight: 150.0,
                  //     flexibleSpace: FlexibleSpaceBar(
                  //       centerTitle: true,
                  //       title: Text(
                  //         title,
                  //         style: const TextStyle(
                  //             fontSize: 16,
                  //             fontWeight: FontWeight.w700,
                  //             color: Color(0xff333435)),
                  //       ),
                  //     ),
                  //     floating: true,
                  //     pinned: true,
                  //     iconTheme: IconThemeData(color: Color(0xffee3124)),
                  //     backgroundColor: Color(0xffFCFBFC),
                  //     elevation: 0),
                  SliverToBoxAdapter(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16.0),
                        child: Column(
                          children: [
                            if (tutupToko != "kosong" && bukaToko != "kosong")
                              tutupToko != null
                                  ? ((DateTime.now().hour >=
                                                  DateTime.parse(
                                                          tutupToko.toString())
                                                      .hour) &&
                                              (DateTime.now().minute >=
                                                  DateTime.parse(
                                                          tutupToko.toString())
                                                      .minute)) ||
                                          ((DateTime.now().hour <
                                                  DateTime.parse(
                                                          bukaToko.toString())
                                                      .hour) ||
                                              (DateTime.now().minute <
                                                  DateTime.parse(
                                                          bukaToko.toString())
                                                      .minute))
                                      ? const Padding(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Text(
                                            "Mohon maaf toko tutup",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromARGB(
                                                    255, 223, 19, 19)),
                                          ),
                                        )
                                      : Container()
                                  : Container(),
                            SizedBox(height: SizeConfig.safeBlockVertical * 2),
                            _merchantInfo(widget.rating, widget.jumlahUlasan,
                                widget.minPrice, widget.maxPrice),
                            SizedBox(height: SizeConfig.safeBlockVertical * 2),
                            Container(
                                height: 45,
                                width: double.infinity,
                                margin: const EdgeInsets.only(right: 8),
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        side: const BorderSide(
                                          color: MyColors.red1,
                                        ),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            side: BorderSide.none)),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ChatPage(
                                                    idMerchant:
                                                        widget.idMerchant,
                                                    iduser: widget.iduser,
                                                    title: widget.title,
                                                  )));
                                    },
                                    child: Text(
                                      "CHAT",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.black.withOpacity(1)),
                                    ))),
                            SizedBox(height: SizeConfig.safeBlockVertical * 3),
                            _customerInfo(),
                            SizedBox(height: SizeConfig.safeBlockVertical * 3),
                            Text(
                              'REKOMENDASI UNTUKMU',
                              style: normalText.copyWith(
                                  color: const Color(0xff8C8F93)),
                            ),
                            SizedBox(height: SizeConfig.safeBlockVertical * 1),
                            BlocBuilder<ListRecomendedMenuBloc,
                                    ListRecomendedMenuState>(
                                builder: ((context, state) {
                              if (state.status ==
                                  ListRecomendedMenuStatus.loading) {
                                return const CircularProgressIndicator();
                              } else if (state.status ==
                                  ListRecomendedMenuStatus.failure) {
                                return Text(state.errorMessage.toString());
                              } else if (state.status ==
                                  ListRecomendedMenuStatus.success) {
                                return GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: state.items!.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing:
                                        SizeConfig.safeBlockVertical * 2,
                                  ),
                                  physics: const ScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    var a = listMenuInKeranjang.firstWhere(
                                        (element) =>
                                            element.menuId ==
                                            state.items![index].menuId,
                                        orElse: (() => Keranjang(
                                            quantity: -1, totalPrice: -1)));
                                    return GestureDetector(
                                        onTap: () async {
                                          widget.tutup_toko != "kosong" &&
                                                  widget.buka_toko != "kosong"
                                              ? ((DateTime.now().hour >=
                                                              DateTime.parse(tutupToko.toString())
                                                                  .hour) &&
                                                          (DateTime.now().minute >=
                                                              DateTime.parse(tutupToko
                                                                      .toString())
                                                                  .minute)) ||
                                                      ((DateTime.now().hour <
                                                              DateTime.parse(bukaToko
                                                                      .toString())
                                                                  .hour) ||
                                                          (DateTime.now().minute <
                                                              DateTime.parse(
                                                                      bukaToko.toString())
                                                                  .minute))
                                                  ? print('tutup toko')
                                                  : await Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) => SelectToppingPage(
                                                                itemInKeranjang:
                                                                    a,
                                                                model: state
                                                                        .items![
                                                                    index],
                                                              ))).then((val) {
                                                      _addMenuToCartBloc.add(
                                                          GetMenusInCart());
                                                      _listRecomendedMenuBloc.add(
                                                          GetListRecomendedMenu(
                                                              idMerchant));
                                                    })
                                              : await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => SelectToppingPage(
                                                            itemInKeranjang: a,
                                                            model: state
                                                                .items![index],
                                                          ))).then((val) {
                                                  _addMenuToCartBloc
                                                      .add(GetMenusInCart());
                                                  _listRecomendedMenuBloc.add(
                                                      GetListRecomendedMenu(
                                                          idMerchant));
                                                });
                                        },
                                        child: makananGrid(
                                            state.items![index].image
                                                .toString(),
                                            state.items![index].name.toString(),
                                            state.items![index].price
                                                .toString(),
                                            false,
                                            ''));
                                  },
                                );
                              } else {
                                return const SizedBox();
                              }
                            })),
                            SizedBox(height: SizeConfig.safeBlockVertical * 1),
                            Text(
                              'LIST MENU',
                              style: normalText.copyWith(
                                  color: const Color(0xff8C8F93)),
                            ),
                            SizedBox(height: SizeConfig.safeBlockVertical * 1),
                            dataProvider.data != null
                                ? ListView.separated(
                                    shrinkWrap: true,
                                    physics: const ScrollPhysics(),
                                    itemCount: dataProvider.data!.length,
                                    itemBuilder: (context, index) {
                                      late Widget makananItem;
                                      var a = listMenuInKeranjang.firstWhere(
                                          (element) =>
                                              element.menuId ==
                                              dataProvider.data![index].menuId,
                                          orElse: (() => Keranjang(
                                              quantity: -1, totalPrice: -1)));

                                      makananItem = makananList(
                                          dataProvider.data![index].image
                                              .toString(),
                                          dataProvider.data![index].name
                                              .toString(),
                                          dataProvider.data![index].price ?? 0,
                                          false,
                                          0,
                                          dataProvider.data![index].menuId
                                              .toString(),
                                          a.quantity);

                                      return GestureDetector(
                                          onTap: () async {
                                            (widget.tutup_toko != "kosong") &&
                                                    (widget.buka_toko !=
                                                        "kosong")
                                                ? ((DateTime.now().hour >=
                                                                DateTime.parse(tutupToko.toString())
                                                                    .hour) &&
                                                            (DateTime.now()
                                                                    .minute >=
                                                                DateTime.parse(tutupToko.toString())
                                                                    .minute)) ||
                                                        ((DateTime.now().hour <
                                                                DateTime.parse(bukaToko
                                                                        .toString())
                                                                    .hour) ||
                                                            (DateTime.now()
                                                                    .minute <
                                                                DateTime.parse(
                                                                        bukaToko
                                                                            .toString())
                                                                    .minute))
                                                    ? print('tutup toko')
                                                    : await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) => SelectToppingPage(
                                                                  itemInKeranjang:
                                                                      a,
                                                                  model: dataProvider
                                                                          .data![
                                                                      index],
                                                                ))).then((val) {
                                                        _addMenuToCartBloc.add(
                                                            GetMenusInCart());
                                                        _listRecomendedMenuBloc.add(
                                                            GetListRecomendedMenu(
                                                                idMerchant));
                                                      })
                                                : await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) => SelectToppingPage(
                                                              itemInKeranjang:
                                                                  a,
                                                              model: dataProvider
                                                                  .data![index],
                                                            ))).then((val) {
                                                    _addMenuToCartBloc
                                                        .add(GetMenusInCart());
                                                    _listRecomendedMenuBloc.add(
                                                        GetListRecomendedMenu(
                                                            idMerchant));
                                                  });
                                          },
                                          child: makananItem);
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                          height:
                                              SizeConfig.safeBlockVertical * 1);
                                    },
                                  )
                                : BlocBuilder<ListMenuBloc, ListMenuState>(
                                    builder: ((context, state) {
                                    if (state.status ==
                                        ListMenuStatus.loading) {
                                      return const CircularProgressIndicator();
                                    } else if (state.status ==
                                        ListMenuStatus.failure) {
                                      return Text(
                                          state.errorMessage.toString());
                                    } else if (state.status ==
                                        ListMenuStatus.success) {
                                      return ListView.separated(
                                        shrinkWrap: true,
                                        physics: const ScrollPhysics(),
                                        itemCount: state.items!.length,
                                        itemBuilder: (context, index) {
                                          late Widget makananItem;
                                          var a =
                                              listMenuInKeranjang.firstWhere(
                                                  (element) =>
                                                      element.menuId ==
                                                      state
                                                          .items![index].menuId,
                                                  orElse: (() => Keranjang(
                                                      quantity: -1,
                                                      totalPrice: -1)));

                                          makananItem = makananList(
                                              state.items![index].image
                                                  .toString(),
                                              state.items![index].name
                                                  .toString(),
                                              state.items![index].price ?? 0,
                                              false,
                                              0,
                                              state.items![index].menuId
                                                  .toString(),
                                              a.quantity);

                                          return GestureDetector(
                                              onTap: () async {
                                                (widget.tutup_toko != "kosong") &&
                                                        (widget.buka_toko !=
                                                            "kosong")
                                                    ? ((DateTime.now().hour >=
                                                                    DateTime.parse(tutupToko.toString())
                                                                        .hour) &&
                                                                (DateTime.now()
                                                                        .minute >=
                                                                    DateTime.parse(tutupToko.toString())
                                                                        .minute)) ||
                                                            ((DateTime.now().hour <
                                                                    DateTime.parse(bukaToko.toString())
                                                                        .hour) ||
                                                                (DateTime.now()
                                                                        .minute <
                                                                    DateTime.parse(bukaToko.toString())
                                                                        .minute))
                                                        ? print('tutup toko')
                                                        : await Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (_) =>
                                                                        SelectToppingPage(
                                                                          itemInKeranjang:
                                                                              a,
                                                                          model:
                                                                              state.items![index],
                                                                        ))).then(
                                                            (val) {
                                                            _addMenuToCartBloc.add(
                                                                GetMenusInCart());
                                                            _listRecomendedMenuBloc.add(
                                                                GetListRecomendedMenu(
                                                                    idMerchant));
                                                          })
                                                    : await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) => SelectToppingPage(
                                                                  itemInKeranjang:
                                                                      a,
                                                                  model: state
                                                                          .items![
                                                                      index],
                                                                ))).then((val) {
                                                        _addMenuToCartBloc.add(
                                                            GetMenusInCart());
                                                        _listRecomendedMenuBloc.add(
                                                            GetListRecomendedMenu(
                                                                idMerchant));
                                                      });
                                              },
                                              child: makananItem);
                                        },
                                        separatorBuilder: (context, index) {
                                          return SizedBox(
                                              height:
                                                  SizeConfig.safeBlockVertical *
                                                      1);
                                        },
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  })),
                          ],
                        )),
                  )
                ],
              ),
              bottomNavigationBar: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: SizedBox(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.safeBlockVertical * 6.5,
                  child: BlocListener<MenuPreorderBloc, MenuPreorderState>(
                      listener: (context, checkState) {
                        if (checkState is CheckResult) {
                          setState(() {
                            _preOrder = checkState.result;
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SummaryPage(
                                      merchantId: idMerchant,
                                      preOrder: _preOrder)));
                        }
                      },
                      child: ElevatedButton(
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(16)),
                            elevation: MaterialStateProperty.all(0),
                            backgroundColor: widget.tutup_toko != "kosong" &&
                                    widget.buka_toko != "kosong"
                                ? ((DateTime.now().hour >=
                                                DateTime.parse(tutupToko.toString())
                                                    .hour) &&
                                            (DateTime.now().minute >=
                                                DateTime.parse(
                                                        tutupToko.toString())
                                                    .minute)) ||
                                        ((DateTime.now().hour <
                                                DateTime.parse(bukaToko.toString())
                                                    .hour) ||
                                            (DateTime.now().minute <
                                                DateTime.parse(bukaToko.toString())
                                                    .minute))
                                    ? MaterialStateProperty.all(
                                        const Color.fromARGB(255, 168, 164, 164))
                                    : MaterialStateProperty.all(const Color(0xffee3124))
                                : MaterialStateProperty.all(const Color(0xffee3124)),
                            foregroundColor: widget.tutup_toko != "kosong"
                                ? ((DateTime.now().hour >= DateTime.parse(tutupToko.toString()).hour) && (DateTime.now().minute >= DateTime.parse(tutupToko.toString()).minute)) || ((DateTime.now().hour < DateTime.parse(bukaToko.toString()).hour) || (DateTime.now().minute < DateTime.parse(bukaToko.toString()).minute))
                                    ? MaterialStateProperty.all(const Color.fromARGB(255, 168, 164, 164))
                                    : MaterialStateProperty.all(const Color(0xffee3124))
                                : MaterialStateProperty.all(const Color(0xffee3124)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8), side: BorderSide.none))),
                        onPressed: () {
                          widget.tutup_toko != "kosong"
                              ? ((DateTime.now().hour >=
                                              DateTime.parse(
                                                      tutupToko.toString())
                                                  .hour) &&
                                          (DateTime.now().minute >=
                                              DateTime.parse(
                                                      tutupToko.toString())
                                                  .minute)) ||
                                      ((DateTime.now().hour <
                                              DateTime.parse(
                                                      bukaToko.toString())
                                                  .hour) ||
                                          (DateTime.now().minute <
                                              DateTime.parse(
                                                      bukaToko.toString())
                                                  .minute))
                                  ? print("toko tutup")
                                  : _menuPreorderBloc.add(CheckMenuPreorder())
                              : _menuPreorderBloc.add(CheckMenuPreorder());
                        },
                        child:
                            BlocConsumer<AddMenuToCartBloc, AddMenuToCartState>(
                          builder: ((context, state) {
                            if (state is MenuInCartRetrieveLoading) {
                              return const CircularProgressIndicator();
                            } else if (state is MenuInCartRetrieved) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          text: 'Keranjang • ',
                                          style: normalText.copyWith(
                                              fontSize: 14,
                                              color: Colors.white),
                                          children: [
                                        TextSpan(
                                            text:
                                                '${state.menuInCart.length} Pesanan',
                                            style: normalText.copyWith(
                                                fontSize: 14,
                                                color: Colors.white)),
                                      ])),
                                  Text('Rp. ' + state.totalPrice.toString(),
                                      style: normalText.copyWith(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              );
                            } else if (state is MenuInCartRetrieveFailed) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          text: 'Keranjang • ',
                                          style: normalText.copyWith(
                                              fontSize: 14,
                                              color: Colors.white),
                                          children: [
                                        TextSpan(
                                            text: '0' + ' Pesanan',
                                            style: normalText.copyWith(
                                                fontSize: 14,
                                                color: Colors.white)),
                                      ])),
                                  Text('Rp. ' + '0',
                                      style: normalText.copyWith(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              );
                            } else {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          text: 'Keranjang • ',
                                          style: normalText.copyWith(
                                              fontSize: 14,
                                              color: Colors.white),
                                          children: [
                                        TextSpan(
                                            text: '0' + ' Pesanan',
                                            style: normalText.copyWith(
                                                fontSize: 14,
                                                color: Colors.white)),
                                      ])),
                                  Text('Rp. ' + '0',
                                      style: normalText.copyWith(
                                          fontSize: 14, color: Colors.white)),
                                ],
                              );
                            }
                          }),
                          listener: (context, state) {
                            if (state is MenuInCartRetrieved) {
                              pesananCount = state.menuInCart.length;
                              totalHarga = state.totalPrice;
                              listMenuInKeranjang = state.menuInCart;
                              _listMenuBloc.add(GetListMenu(idMerchant));
                            }
                          },
                        ),
                      )),
                ),
              )),
        ));
  }

  Widget _merchantInfo(
    double? rating,
    int? jumlahUlasan,
    int? minPrice,
    int? maxPrice,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.star_rounded, color: MyColors.yellow1),
                  const SizedBox(width: 4),
                  Text(rating.toString())
                ],
              ),
              Text(
                '$jumlahUlasan Ulasan',
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
                '$minPrice-$maxPrice',
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
        makananGrid(Assets.images.illFood.path, 'Nasi Ayam Bakar', 'Rp. 20000',
            false, ''),
        makananGrid(Assets.images.illFood.path, 'Nasi Ayam Bakar', 'Rp. 20000',
            true, 'Rp 30.000'),
        makananGrid(Assets.images.illFood.path, 'Nasi Ayam Bakar', 'Rp. 20000',
            false, ''),
        makananGrid(Assets.images.illFood.path, 'Nasi Ayam Bakar', 'Rp. 20000',
            false, '')
      ],
    );
  }

  // Widget _listMenu() {
  //   return ListView.separated(
  //     shrinkWrap: true,
  //     physics: const ScrollPhysics(),
  //     itemCount: 3,
  //     itemBuilder: (context, index) {
  //       return GestureDetector(
  //         onTap: () async {
  //           await Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (_) => SelectToppingPage(
  //                         photo: Assets.images.illFood.path,
  //                       )));
  //         },
  //         child: makananList(Assets.images.illFood.path, 'itemName', 0, false,
  //             0, 'itemId$index'),
  //       );
  //     },
  //     separatorBuilder: (context, index) {
  //       return SizedBox(height: SizeConfig.safeBlockVertical * 1);
  //     },
  //   );
  // }

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
                // Text('Shabrina',
                //     style: normalText.copyWith(
                //         color: Colors.white.withOpacity(.7))),
                // SizedBox(height: SizeConfig.safeBlockVertical * .5),
                // Text(
                //   '',
                //   style: normalText.copyWith(
                //       fontWeight: FontWeight.w500,
                //       fontSize: 15,
                //       color: Colors.white),
                // ),
                SizedBox(height: SizeConfig.safeBlockVertical * .25),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 50,
                  child: Text(widget.alamat,
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
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
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
      double discount, String id, int quantity) {
    return IntrinsicHeight(
      child: OverflowBox(
        maxWidth: SizeConfig.screenWidth,
        child: Row(
          children: [
            Visibility(
              visible: quantity != -1,
              child: Container(width: 4, color: const Color(0xffEA001E)),
            ),
            const SizedBox(width: 20),
            Hero(
              tag: id,
              child: Container(
                width: SizeConfig.safeBlockHorizontal * 20,
                height: SizeConfig.safeBlockHorizontal * 20,
                clipBehavior: Clip.hardEdge,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // image:
                  // DecorationImage(
                  //     image:
                  //     AssetImage(image), fit: BoxFit.fill)
                ),
              ),
            ),
            SizedBox(
              width: SizeConfig.safeBlockHorizontal * 4,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(quantity != -1 ? '${quantity}x $name' : name,
                    style: normalText.copyWith(
                        fontSize: 15,
                        fontWeight:
                            quantity != -1 ? FontWeight.w500 : FontWeight.w400,
                        color: quantity != -1
                            ? const Color(0xffEA001E)
                            : Colors.black)),
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
  }
}

class DataProvider with ChangeNotifier {
  List<MenuModel>? menuModel;
  List<MenuModel>? get data => menuModel;

  void updateData(List<MenuModel>? newData) {
    menuModel = newData;
    notifyListeners();
  }
}

class CustomSliverAppbarDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final DataProvider dataProvider;
  final double expandedHeight;
  final String idMerchant;

  const CustomSliverAppbarDelegate(
      {required this.expandedHeight,
      required this.dataProvider,
      this.title = "",
      required this.idMerchant});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return Column(
      children: [
        buildAppbar(shrinkOffset),
        buildAppBar2(shrinkOffset),
      ],
    );
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;
  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;
  Widget buildAppBar2(double shrinkOffset) {
    bool field = false;
    TextEditingController keyword = TextEditingController();
    return Opacity(
      opacity: appear(shrinkOffset),
      child: Container(
        color: Colors.white,
        height: 40,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocProvider(
                create: (context) => CategoryBloc(
                  categoryRepository: context.read<CategoryRepository>(),
                )..add(GetMenuMakanan(idMerchant)),
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, state) {
                    final status = state.status;
                    if (status == CategoryStatus.loading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (status == CategoryStatus.failure) {
                      return const Center(
                        child: Text('Terjadi kesalahan'),
                      );
                    } else if (status == CategoryStatus.success) {
                      // final items = state.items!;
                      if (field == true) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width / 2,
                          child: TextField(
                            style: const TextStyle(fontSize: 13),
                            onSubmitted: (value) {
                              if (value.isNotEmpty) {
                                context
                                    .read<MenuRepository>()
                                    .searchMenuByKeyword(
                                        keyword.text, idMerchant)
                                    .then((value) {
                                  print(value.first);
                                  dataProvider.updateData(value);
                                });
                              } else {
                                return;
                              }
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.search,
                                color: MyColors.red1,
                                size: 20,
                              ),
                              hintText: "Kamu lagi mau makan apa?",
                              hintStyle: const TextStyle(fontSize: 13),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(
                          //height: 55,
                          width: MediaQuery.of(context).size.width / 2,
                          child: DropdownButtonFormField<CategoryModel>(
                            icon: const Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: Colors.red,
                            ),
                            decoration: const InputDecoration.collapsed(
                              hintText: 'Pilih kategori',
                            ),
                            borderRadius: BorderRadius.circular(20),
                            items: state.items!
                                .map((category) => DropdownMenuItem(
                                      value: category,
                                      child: Text(category.category.toString()),
                                    ))
                                .toList(),
                            value: state.items![0],
                            onChanged: (val) {
                              // context.read<PilihKawasanBloc>().add(
                              //     KawasanChange(val!.kawasanId.toString()));
                              context
                                  .read<MenuRepository>()
                                  .searchMenuByCategory(
                                      val!.categoryId.toString(), idMerchant)
                                  .then((value) {
                                print(value.first);
                                dataProvider.updateData(value);
                              });
                            },
                          ),
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  field = !field;
                  print(field);
                },
                child: Container(
                  width: 70,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 0.5)),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(Icons.search, size: 20),
                        Text("Cari")
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAppbar(double shrinkOffset) => AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff333435)),
        ),
      );
  @override
  // TODO: implement maxExtent
  double get maxExtent => expandedHeight;

  @override
  // TODO: implement minExtent
  double get minExtent => kToolbarHeight + 70;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
