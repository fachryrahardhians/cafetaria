import 'dart:async';

import 'package:cafetaria/app/bloc/app_bloc.dart';
import 'package:cafetaria/components/textfields/reusable_textfields.dart';
import 'package:cafetaria/feature/Authentication/authentication.dart';
import 'package:cafetaria/feature/pembeli/bloc/add_menu_to_cart_bloc/add_menu_to_cart_bloc.dart';
import 'package:cafetaria/feature/pembeli/bloc/category_bloc/category_bloc.dart';
import 'package:cafetaria/feature/pembeli/bloc/check_menu_preorder_bloc/check_menu_preorder_bloc.dart';
import 'package:cafetaria/feature/pembeli/bloc/list_menu_bloc/list_menu_bloc.dart';
import 'package:cafetaria/feature/pembeli/bloc/list_merchant_category_bloc/list_merchant_category_bloc.dart';
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
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
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
  late ListMerchantCategoryBloc _listMerchantCategoryBloc;
  late AddMenuToCartBloc _addMenuToCartBloc;
  late ListRecomendedMenuBloc _listRecomendedMenuBloc;
  late MenuPreorderBloc _menuPreorderBloc;
  List<MenuCategory>? searchResults;
  int pesananCount = 0;
  int totalHarga = 0;
  List<Keranjang> listMenuInKeranjang = [];
  final ScrollController _scrollController = ScrollController();
  bool _preOrder = false;
  String? tutupToko;
  String? bukaToko;
  late StreamSubscription keyboard;
  int _selectedIndex = 0;
  double itemHeight = 200;
  @override
  void initState() {
    _listMenuBloc =
        ListMenuBloc(menuRepository: context.read<MenuRepository>());
    _addMenuToCartBloc =
        AddMenuToCartBloc(menuRepository: context.read<MenuRepository>());
    _listMerchantCategoryBloc = ListMerchantCategoryBloc(
        menuRepository: context.read<MenuRepository>());
    _listRecomendedMenuBloc =
        ListRecomendedMenuBloc(menuRepository: context.read<MenuRepository>());
    _menuPreorderBloc =
        MenuPreorderBloc(menuRepository: context.read<MenuRepository>());
    super.initState();
  }

  // @override
  // void dispose() {
  //   keyboard.cancel();
  //   super.dispose();
  // }
  void _handleSelection(int index, double height) {
    setState(() {
      _selectedIndex = index;
    });
    _scrollController.animateTo(index == 0 ? 800 : index * height / 1.6,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final statusApp = context.select((AppBloc bloc) => bloc.state.status);

    if ((widget.tutup_toko != null && widget.tutup_toko != "kosong") &&
        (widget.buka_toko != null && widget.buka_toko != "kosong")) {
      tutupToko = widget.tutup_toko;
      bukaToko = widget.buka_toko;
    }
    final dataProvider = Provider.of<DataProvider>(context);
    keyboard = KeyboardVisibilityController().onChange.listen((event) {
      if (event == false) {
        dataProvider.updateDataField(!dataProvider.dataField!);
      } else {
        // ignore: avoid_print
        print(event);
      }
    });
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: ((context) => _addMenuToCartBloc..add(GetMenusInCart()))),
          BlocProvider(create: ((context) => _listMenuBloc)),
          BlocProvider(create: ((context) => _listMerchantCategoryBloc)),
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
              body: BlocBuilder<ListMerchantCategoryBloc,
                  ListMerchantCategoryState>(
                builder: (context, state) {
                  if (state.status == ListMerchantCategoryStatus.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state.status ==
                      ListMerchantCategoryStatus.failure) {
                    return Text(state.errorMessage.toString());
                  } else if (state.status ==
                      ListMerchantCategoryStatus.success) {
                   
                    return CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverPersistentHeader(
                          delegate: CustomSliverAppbarDelegate(
                              dataProvider: dataProvider,
                              expandedHeight: itemHeight,
                              title: title,
                              appbar2: Container(
                                color: Colors.white,
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: dataProvider.dataField == true
                                      ? SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.1,
                                          child: TextField(
                                            style:
                                                const TextStyle(fontSize: 13),
                                            onChanged: (value) {
                                              if (value.isNotEmpty) {
                                                // for (var element
                                                //     in state.items!) {
                                                //   setState(() {
                                                //     searchResults = element
                                                //         .menu!
                                                //         .where((element) =>
                                                //             element.name!.toString()
                                                //                 .contains(
                                                //                     value))
                                                //         .toList();
                                                //   });
                                                //   print(searchResults);
                                                // }
                                                setState(() {
                                                  searchResults = state.items!
                                                      .where((item) => item
                                                          .menu!
                                                          .where((val) => val
                                                              .name!
                                                              .toLowerCase()
                                                              .contains(value
                                                                  .toLowerCase()))
                                                          .toList()
                                                          .isNotEmpty)
                                                      .toList();
                                                });
                                                print(searchResults);
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
                                              hintText:
                                                  "Kamu lagi mau makan apa?",
                                              hintStyle:
                                                  const TextStyle(fontSize: 13),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                              ),
                                            ),
                                          ),
                                        )
                                      : Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              //height: 55,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child:
                                                  DropdownButtonFormField<int>(
                                                icon: const Icon(
                                                  Icons
                                                      .keyboard_arrow_down_rounded,
                                                  color: Colors.red,
                                                ),
                                                decoration:
                                                    const InputDecoration
                                                        .collapsed(
                                                  hintText: 'Pilih kategori',
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                items: [
                                                  for (int i = 0;
                                                      i < state.items!.length;
                                                      i++)
                                                    DropdownMenuItem(
                                                      value: i,
                                                      child: Text(state
                                                          .items![i].category!),
                                                    ),
                                                ],
                                                value: _selectedIndex,
                                                onChanged: (val) {
                                                  _handleSelection(
                                                      val!,
                                                      _key.currentContext!.size!
                                                          .height);
                                                },
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                dataProvider.updateDataField(
                                                    !dataProvider.dataField!);
                                              },
                                              child: Container(
                                                width: 70,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 0.5)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8,
                                                      vertical: 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: const [
                                                      Icon(Icons.search,
                                                          size: 20),
                                                      Text("Cari")
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                ),
                              )),
                          pinned: true,
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 16.0),
                              child: Column(
                                key: _key,
                                children: [
                                  if (tutupToko != "kosong" &&
                                      bukaToko != "kosong")
                                    tutupToko != null
                                        ? ((DateTime.now().hour >=
                                                        DateTime.parse(tutupToko
                                                                .toString())
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
                                                        DateTime.parse(bukaToko
                                                                .toString())
                                                            .minute))
                                            ? const Padding(
                                                padding:
                                                    EdgeInsets.only(bottom: 10),
                                                child: Text(
                                                  "Mohon maaf toko tutup",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color.fromARGB(
                                                          255, 223, 19, 19)),
                                                ),
                                              )
                                            : Container()
                                        : Container(),
                                  SizedBox(
                                      height: SizeConfig.safeBlockVertical * 2),
                                  _merchantInfo(
                                     double.parse(widget.rating!.toStringAsFixed(2)),
                                      widget.jumlahUlasan,
                                      widget.minPrice,
                                      widget.maxPrice),
                                  SizedBox(
                                      height: SizeConfig.safeBlockVertical * 2),
                                  Container(
                                      height: 45,
                                      width: double.infinity,
                                      margin: const EdgeInsets.only(right: 8),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.white,
                                              side: const BorderSide(
                                                color: MyColors.red1,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  side: BorderSide.none)),
                                          onPressed: () {
                                            if (statusApp ==
                                                AppStatus.unauthenticated) {
                                              showDialog(
                                                  context: context,
                                                  builder: ((context) {
                                                    return dialogWarnCart();
                                                  }));
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChatPage(
                                                            idMerchant: widget
                                                                .idMerchant,
                                                            iduser:
                                                                widget.iduser,
                                                            title: widget.title,
                                                          )));
                                            }
                                          },
                                          child: Text(
                                            "CHAT",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black
                                                    .withOpacity(1)),
                                          ))),
                                  SizedBox(
                                      height: SizeConfig.safeBlockVertical * 3),
                                  _customerInfo(),
                                  SizedBox(
                                      height: SizeConfig.safeBlockVertical * 3),
                                  Text(
                                    'REKOMENDASI UNTUKMU',
                                    style: normalText.copyWith(
                                        color: const Color(0xff8C8F93)),
                                  ),
                                  SizedBox(
                                      height: SizeConfig.safeBlockVertical * 1),
                                  BlocBuilder<ListRecomendedMenuBloc,
                                          ListRecomendedMenuState>(
                                      builder: ((context, state) {
                                    if (state.status ==
                                        ListRecomendedMenuStatus.loading) {
                                      return const CircularProgressIndicator();
                                    } else if (state.status ==
                                        ListRecomendedMenuStatus.failure) {
                                      return Text(
                                          state.errorMessage.toString());
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
                                          var a =
                                              listMenuInKeranjang.firstWhere(
                                                  (element) =>
                                                      element.menuId ==
                                                      state
                                                          .items![index].menuId,
                                                  orElse: (() => Keranjang(
                                                      quantity: -1,
                                                      totalPrice: -1)));
                                          return GestureDetector(
                                              onTap: () async {
                                                widget.tutup_toko != "kosong" &&
                                                        widget.buka_toko !=
                                                            "kosong"
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
                                              child: makananGrid(
                                                  state.items![index].image
                                                      .toString(),
                                                  state.items![index].name
                                                      .toString(),
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
                                  SizedBox(
                                      height: SizeConfig.safeBlockVertical * 1),
                                  // Text(
                                  //   'LIST MENU',
                                  //   style: normalText.copyWith(
                                  //       color: const Color(0xff8C8F93)),
                                  // ),
                                  SizedBox(
                                      height: SizeConfig.safeBlockVertical * 1),
                                  if (searchResults != null)
                                    ListView.separated(
                                      //controller: _scrollController,
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      itemCount: 1 + searchResults!.length,
                                      itemBuilder: (context, index) {
                                        if (index == 0 ||
                                            index ==
                                                searchResults!.length + 1) {
                                          return const SizedBox.shrink();
                                        }
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: searchResults![index - 1]
                                              .menu!
                                              .length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, i) {
                                            final data =
                                                searchResults![index - 1]
                                                    .menu![i];
                                            late Widget makananItem;
                                            var a =
                                                listMenuInKeranjang.firstWhere(
                                                    (element) =>
                                                        element.menuId ==
                                                        data.menuId,
                                                    orElse: (() => Keranjang(
                                                        quantity: -1,
                                                        totalPrice: -1)));

                                            makananItem = makananList(
                                                data.image.toString(),
                                                data.name.toString(),
                                                data.price ?? 0,
                                                false,
                                                0,
                                                data.menuId.toString(),
                                                a.quantity);

                                            return GestureDetector(
                                                onTap: () async {
                                                  (widget.tutup_toko !=
                                                              "kosong") &&
                                                          (widget.buka_toko !=
                                                              "kosong")
                                                      ? ((DateTime.now().hour >=
                                                                      DateTime.parse(tutupToko.toString())
                                                                          .hour) &&
                                                                  (DateTime.now()
                                                                          .minute >=
                                                                      DateTime.parse(tutupToko.toString())
                                                                          .minute)) ||
                                                              ((DateTime.now()
                                                                          .hour <
                                                                      DateTime.parse(bukaToko.toString())
                                                                          .hour) ||
                                                                  (DateTime.now()
                                                                          .minute <
                                                                      DateTime.parse(
                                                                              bukaToko.toString())
                                                                          .minute))
                                                          ? null
                                                          : await Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) => SelectToppingPage(
                                                                        itemInKeranjang:
                                                                            a,
                                                                        model:
                                                                            data,
                                                                      ))).then((val) {
                                                              _addMenuToCartBloc
                                                                  .add(
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
                                                                    model: data,
                                                                  ))).then((val) {
                                                          _addMenuToCartBloc.add(
                                                              GetMenusInCart());
                                                          _listRecomendedMenuBloc.add(
                                                              GetListRecomendedMenu(
                                                                  idMerchant));
                                                        });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: makananItem,
                                                ));
                                          },
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        height:
                                            SizeConfig.safeBlockVertical * 5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(state
                                              .items![index].category
                                              .toString()),
                                        ),
                                      ),
                                    )
                                  else
                                    ListView.separated(
                                      //controller: _scrollController,
                                      shrinkWrap: true,
                                      physics: const ScrollPhysics(),
                                      itemCount: 1 + state.items!.length,
                                      itemBuilder: (context, index) {
                                        if (index == 0 ||
                                            index == state.items!.length + 1) {
                                          return const SizedBox.shrink();
                                        }
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: state
                                              .items![index - 1].menu!.length,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, i) {
                                            final data = state
                                                .items![index - 1].menu![i];
                                            late Widget makananItem;
                                            var a =
                                                listMenuInKeranjang.firstWhere(
                                                    (element) =>
                                                        element.menuId ==
                                                        data.menuId,
                                                    orElse: (() => Keranjang(
                                                        quantity: -1,
                                                        totalPrice: -1)));

                                            makananItem = makananList(
                                                data.image.toString(),
                                                data.name.toString(),
                                                data.price ?? 0,
                                                false,
                                                0,
                                                data.menuId.toString(),
                                                a.quantity);

                                            return GestureDetector(
                                                onTap: () async {
                                                  (widget.tutup_toko !=
                                                              "kosong") &&
                                                          (widget.buka_toko !=
                                                              "kosong")
                                                      ? ((DateTime.now().hour >=
                                                                      DateTime.parse(tutupToko.toString())
                                                                          .hour) &&
                                                                  (DateTime.now()
                                                                          .minute >=
                                                                      DateTime.parse(tutupToko.toString())
                                                                          .minute)) ||
                                                              ((DateTime.now()
                                                                          .hour <
                                                                      DateTime.parse(bukaToko.toString())
                                                                          .hour) ||
                                                                  (DateTime.now()
                                                                          .minute <
                                                                      DateTime.parse(
                                                                              bukaToko.toString())
                                                                          .minute))
                                                          ? null
                                                          : await Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (_) => SelectToppingPage(
                                                                        itemInKeranjang:
                                                                            a,
                                                                        model:
                                                                            data,
                                                                      ))).then((val) {
                                                              _addMenuToCartBloc
                                                                  .add(
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
                                                                    model: data,
                                                                  ))).then((val) {
                                                          _addMenuToCartBloc.add(
                                                              GetMenusInCart());
                                                          _listRecomendedMenuBloc.add(
                                                              GetListRecomendedMenu(
                                                                  idMerchant));
                                                        });
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: makananItem,
                                                ));
                                          },
                                        );
                                      },
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        height:
                                            SizeConfig.safeBlockVertical * 5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(state
                                              .items![index].category
                                              .toString()),
                                        ),
                                      ),
                                    )
                                ],
                              )),
                        )
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
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
                              _listMerchantCategoryBloc
                                  .add(GetListMerchantCategory(idMerchant));
                            }
                          },
                        ),
                      )),
                ),
              )),
        ));
  }

  Dialog dialogWarnCart() {
    return Dialog(
        child: Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 15, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.images.icGrfxWarning.image(),
          const Text(
            "Anda Belum Login",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff222222),
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 16),
            child: Text(
              "Jika ingin melakukan pemesanan maka anda harus melakukan login terlebih dahulu",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xff808285),
                  fontSize: 12,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                      height: 44,
                      margin: const EdgeInsets.only(right: 8),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              side: const BorderSide(
                                color: MyColors.red1,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  side: BorderSide.none)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "TIDAK",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.black.withOpacity(1)),
                          )))),
              Expanded(
                  flex: 1,
                  child: Container(
                      height: 44,
                      margin: const EdgeInsets.only(left: 8),
                      child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xffee3124)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                      side: BorderSide.none))),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text(
                            "LOGIN",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Colors.white.withOpacity(1)),
                          ))))
            ],
          )
        ],
      ),
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

  // Widget _recomendation() {
  //   return GridView.count(
  //     shrinkWrap: true,
  //     crossAxisCount: 2,
  //     physics: const ScrollPhysics(),
  //     mainAxisSpacing: SizeConfig.safeBlockVertical * 2,
  //     children: [
  //       makananGrid(Assets.images.illFood.path, 'Nasi Ayam Bakar', 'Rp. 20000',
  //           false, ''),
  //       makananGrid(Assets.images.illFood.path, 'Nasi Ayam Bakar', 'Rp. 20000',
  //           true, 'Rp 30.000'),
  //       makananGrid(Assets.images.illFood.path, 'Nasi Ayam Bakar', 'Rp. 20000',
  //           false, ''),
  //       makananGrid(Assets.images.illFood.path, 'Nasi Ayam Bakar', 'Rp. 20000',
  //           false, '')
  //     ],
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  // image:
                  // DecorationImage(
                  //     image:
                  //     AssetImage(image), fit: BoxFit.fill)
                ),
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
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
  bool? field = false;
  bool? get dataField => field;

  void updateData(List<MenuModel>? newData) {
    menuModel = newData;
    notifyListeners();
  }

  void updateDataField(bool? newData) {
    field = newData;
    notifyListeners();
  }
}

class CustomSliverAppbarDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final DataProvider dataProvider;
  final double expandedHeight;
  final Widget appbar2;
  const CustomSliverAppbarDelegate({
    required this.expandedHeight,
    required this.dataProvider,
    this.title = "",
    required this.appbar2,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Column(
        children: [
          buildAppbar(shrinkOffset),
          Opacity(opacity: appear(shrinkOffset), child: appbar2)
        ],
      );
    });
  }

  double appear(double shrinkOffset) => shrinkOffset / expandedHeight;
  double disappear(double shrinkOffset) => 1 - shrinkOffset / expandedHeight;

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
