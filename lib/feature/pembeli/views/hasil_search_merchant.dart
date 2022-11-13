// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:cafetaria/feature/pembeli/bloc/add_menu_to_cart_bloc/add_menu_to_cart_bloc.dart';
import 'package:cafetaria/feature/pembeli/bloc/list_merchant_bloc/list_merchant_bloc.dart';
import 'package:cafetaria/feature/pembeli/views/makanan_page.dart';
import 'package:cafetaria/feature/pembeli/views/widget/merchant_widget.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:merchant_repository/merchant_repository.dart';
import 'package:cloud_functions/cloud_functions.dart';

class HasilMerchant extends StatelessWidget {
  final String cari;
  const HasilMerchant({Key? key, this.cari = ""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AddMenuToCartBloc(
                  menuRepository: context.read<MenuRepository>())
                ..add(GetMenusInCart())),
        ],
        child: HasilSearchMerchant(
          search: cari,
        ));
  }
}

class HasilSearchMerchant extends StatefulWidget {
  final String search;
  const HasilSearchMerchant({Key? key, this.search = ""}) : super(key: key);

  @override
  _HasilSearchMerchantState createState() => _HasilSearchMerchantState();
}

class _HasilSearchMerchantState extends State<HasilSearchMerchant>
    with WidgetsBindingObserver {
  TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xff333435));
  TextStyle headlineStyle = const TextStyle(
      color: Color(0xff333435), fontSize: 20, fontWeight: FontWeight.w700);

  late AddMenuToCartBloc addMenuToCartBloc;

  String? merchantIdInKeranjang;
  MerchantModel? selectedMerchant;

  @override
  void initState() {
    // TODO: implement initState

    addMenuToCartBloc =
        AddMenuToCartBloc(menuRepository: context.read<MenuRepository>());
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xffee3124)),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Hasil Search",
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Color(0xff333435)),
        ),
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back)),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            // const Center(
            //   child: Text(
            //     'Hasil Search',
            //     style: TextStyle(
            //         fontSize: 16,
            //         fontWeight: FontWeight.w700,
            //         color: Color(0xff333435)),
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
              child: SizedBox(
                width: double.infinity,
                height: 40,
                child: TextField(
                  style: TextStyle(fontSize: 13),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HasilMerchant(cari: value.toString()),
                              ))
                          .then((value) =>
                              {addMenuToCartBloc..add(GetMenusInCart())});
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
              ),
            ),
            SizedBox(height: SizeConfig.safeBlockVertical * 1),
            BlocListener<AddMenuToCartBloc, AddMenuToCartState>(
                listener: ((context, state) {
                  if (state is MenuInCartRetrieved) {
                    if (state.menuInCart.isNotEmpty) {
                      merchantIdInKeranjang = state.menuInCart[0].merchantId;
                    }
                  } else if (state is AllMenuRemoved) {
                    merchantIdInKeranjang = null;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => MakananPage(
                                  buka_toko:
                                      selectedMerchant?.buka_toko ?? "kosong",
                                  title: selectedMerchant?.name ??
                                      'Shabrina’s Kitchen - Gambir',
                                  idMerchant:
                                      selectedMerchant!.merchantId.toString(),
                                  alamat: selectedMerchant!.address.toString(),
                                  rating: selectedMerchant?.rating,
                                  jumlahUlasan:
                                      selectedMerchant?.totalCountRating,
                                  tutup_toko:
                                      selectedMerchant?.tutup_toko ?? "kosong",
                                  minPrice: selectedMerchant?.minPrice,
                                  maxPrice: selectedMerchant?.maxPrice,
                                ))).then(
                        (value) => {addMenuToCartBloc..add(GetMenusInCart())});
                  }
                }),
                child: FutureBuilder<List<MechantSearch>>(
                  future: context
                      .read<MerchantRepository>()
                      .searchMerchant(widget.search),
                  builder: (context, snapshot) {
                    return snapshot.data?.length == null
                        ? const CircularProgressIndicator()
                        : Expanded(
                            child: ListView.builder(
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    selectedMerchant = MerchantModel(
                                        address: snapshot
                                            .data?[index].source!.address,
                                        merchantId: snapshot.data?[index].id,
                                        name:
                                            snapshot.data?[index].source?.name,
                                        maxPrice: 50000,
                                        totalCountRating:
                                            snapshot.data?[index].score,
                                        minPrice: 4000,
                                        rating: snapshot
                                            .data?[index].source?.rating
                                            ?.toDouble());
                                    if (merchantIdInKeranjang != null &&
                                        snapshot.data?[index].id !=
                                            merchantIdInKeranjang) {
                                      showDialog(
                                          context: context,
                                          builder: ((context) {
                                            return dialogWarnCart(
                                                snapshot.data?[index]);
                                          }));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => MakananPage(
                                                    title: snapshot.data?[index]
                                                            .source?.name ??
                                                        'Shabrina’s Kitchen - Gambir',
                                                    idMerchant: snapshot
                                                        .data![index].id
                                                        .toString(),
                                                    alamat: snapshot
                                                        .data![index]
                                                        .source!
                                                        .address
                                                        .toString(),
                                                    buka_toko: "kosong",
                                                    tutup_toko: "kosong",
                                                    rating: snapshot
                                                        .data?[index]
                                                        .source
                                                        ?.rating!
                                                        .toDouble(),
                                                    jumlahUlasan: snapshot
                                                        .data?[index].score,
                                                    minPrice: 4000,
                                                    maxPrice: 50000,
                                                  ))).then((value) => {
                                            addMenuToCartBloc
                                              ..add(GetMenusInCart())
                                          });
                                    }
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: SizeConfig.safeBlockVertical * 3),
                                    child: outlet(
                                        Assets.images.illCafetariaBanner2.path,
                                        null,
                                        false,
                                        snapshot.data?[index].source?.name ??
                                            'Shabrina’s Kitchen - Gambir',
                                        'Lantai 1',
                                        'Cafetaria',
                                        '${snapshot.data?[index].source?.rating!.toDouble()} • ${snapshot.data?[index].score} rating'),
                                  ));
                            },
                          ));
                  },
                ))
          ])),
    );
  }

  Dialog dialogWarnCart(MechantSearch? model) {
    return Dialog(
        child: Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 15, bottom: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Assets.images.icGrfxWarning.image(),
          const Text(
            "Mau ganti pesanan dari resto lain?",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Color(0xff222222),
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 8, bottom: 16),
            child: Text(
              "Jika ingin mengganti resto lain maka menu yang Anda pilih dari resto sebelumnya akan dihapus.",
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
                              primary: Colors.white,
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
                            addMenuToCartBloc.add(RemoveAllMenuInCart());
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MakananPage(
                                          title: model!.source!.name ??
                                              'Shabrina’s Kitchen - Gambir',
                                          idMerchant: model.id.toString(),
                                          alamat:
                                              model.source!.address.toString(),
                                          buka_toko: "kosong",
                                          tutup_toko: "kosong",
                                          rating:
                                              model.source?.rating!.toDouble(),
                                          jumlahUlasan: model.score,
                                          minPrice: 4000,
                                          maxPrice: 50000,
                                        ))).then((value) =>
                                {addMenuToCartBloc..add(GetMenusInCart())});
                          },
                          child: Text(
                            "YA GANTI",
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

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
