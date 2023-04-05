// ignore_for_file: avoid_print

import 'package:cafetaria/feature/Authentication/bloc/bloc/pilih_kawasan_bloc.dart';
import 'package:cafetaria/feature/pembeli/bloc/add_menu_to_cart_bloc/add_menu_to_cart_bloc.dart';

import 'package:cafetaria/feature/pembeli/views/makanan_page.dart';
import 'package:cafetaria/feature/pembeli/views/widget/merchant_widget.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:category_repository/category_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:merchant_repository/merchant_repository.dart';

class HasilMerchant extends StatelessWidget {
  final String cari;
  final String id;
  final double lat;
  final double long;
  const HasilMerchant(
      {Key? key,
      this.cari = "",
      this.id = "",
      required this.lat,
      required this.long})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AddMenuToCartBloc(
                  menuRepository: context.read<MenuRepository>())
                ..add(GetMenusInCart())),
          BlocProvider(
              create: (context) => PilihKawasanBloc(
                  categoryRepository: context.read<CategoryRepository>())
                ..add(const GetPilihKawasan()))
        ],
        child: HasilSearchMerchant(
          search: cari,
          id: id,
          lat: lat,
          long: long,
        ));
  }
}

class HasilSearchMerchant extends StatefulWidget {
  final String search;
  final String id;
  final double lat;
  final double long;
  const HasilSearchMerchant(
      {Key? key,
      this.search = "",
      this.id = "",
      required this.lat,
      required this.long})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HasilSearchMerchantState createState() => _HasilSearchMerchantState();
}

class _HasilSearchMerchantState extends State<HasilSearchMerchant>
    with WidgetsBindingObserver {
  TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xff333435));
  TextStyle headlineStyle = const TextStyle(
      color: Color(0xff333435), fontSize: 20, fontWeight: FontWeight.w700);
  double? long;
  double? lat;

  late AddMenuToCartBloc addMenuToCartBloc;

  String? merchantIdInKeranjang;
  MerchantModel? selectedMerchant;
  String? idUser;
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      idUser = widget.id;
    });
    print(widget.lat);
    print(widget.long);
    addMenuToCartBloc =
        AddMenuToCartBloc(menuRepository: context.read<MenuRepository>());
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return Future.value(true);
      },
      child: Scaffold(
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
        body: Column(children: [
          // const Center(
          //   child: Text(
          //     'Hasil Search',
          //     style: TextStyle(
          //         fontSize: 16,
          //         fontWeight: FontWeight.w700,
          //         color: Color(0xff333435)),
          //   ),
          // ),

          Container(
            width: double.infinity,
            height: 150,
            color: const Color.fromARGB(255, 234, 0, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: SizeConfig.safeBlockVertical * 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: TextField(
                      style: const TextStyle(fontSize: 13),
                      onSubmitted: (value) {
                        if (value.isNotEmpty && lat != null && long != null) {
                          Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HasilMerchant(
                                        cari: value.toString(),
                                        lat: lat!,
                                        long: long!,
                                        id: widget.id),
                                  ))
                              .then((value) =>
                                  {addMenuToCartBloc..add(GetMenusInCart())});
                        } else {
                          return;
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: MyColors.grey1,
                          size: 20,
                        ),
                        hintText: "Cari Produk Apa ?",
                        hintStyle: const TextStyle(fontSize: 13),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 22, right: 22, top: 10),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      Text(
                        "Kawasan Kamu",
                        style: textStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: 47,
                        width: SizeConfig.screenWidth / 2.5,
                        child: BlocBuilder<PilihKawasanBloc, PilihKawasanState>(
                          builder: (context, state) {
                            final status = state.status;
                            if (status == PilihKawasanStatus.loading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (status == PilihKawasanStatus.failure) {
                              return const Center(
                                child: Text('Terjadi kesalahan'),
                              );
                            } else if (status == PilihKawasanStatus.success) {
                              // final items = state.items!;
                              return DropdownButtonFormField<PilihKawasanModel>(
                                isExpanded: true,
                                items: state.items!
                                    .map((kawasan) => DropdownMenuItem(
                                          value: kawasan,
                                          child: Text(
                                            kawasan.name.toString(),
                                          ),
                                        ))
                                    .toList(),
                                value: state.items![0],
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: Colors.white,
                                ),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight
                                        .bold // set the text color here
                                    ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,

                                  // other properties like labelText, hintText, etc.
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    lat = val?.kawasan_latitude;
                                    long = val?.kawasan_longitude;
                                  });
                                },
                              );
                            }
                            return const SizedBox.shrink();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
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
                                iduser: widget.id,
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
                future: context.read<MerchantRepository>().searchMerchant(
                    widget.search,
                    lat: widget.lat,
                    long: widget.long),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.none) {
                    return const Text("Error");
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return Expanded(
                        child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        double? distance = snapshot.data?[index].source!.distance;
                        double parseDistance =
                            double.parse(distance!.toStringAsFixed(2));
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: InkWell(
                              onTap: () {
                                selectedMerchant = MerchantModel(
                                    address:
                                        snapshot.data?[index].source!.address,
                                    merchantId: snapshot.data?[index].id,
                                    name: snapshot.data?[index].source?.name,
                                    maxPrice:
                                        snapshot.data?[index].source?.maxPrice,
                                    totalCountRating: snapshot
                                        .data?[index].source!.totalCountRating,
                                    minPrice:
                                        snapshot.data?[index].source?.minPrice,
                                    rating: snapshot.data?[index].source?.rating
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
                                                iduser: widget.id,
                                                idMerchant: snapshot
                                                    .data![index].id
                                                    .toString(),
                                                alamat: snapshot.data![index]
                                                    .source!.address
                                                    .toString(),
                                                buka_toko: snapshot.data?[index]
                                                        .source?.buka_toko ??
                                                    "kosong",
                                                tutup_toko: snapshot
                                                        .data?[index]
                                                        .source
                                                        ?.tutup_toko ??
                                                    "kosong",
                                                rating: snapshot.data?[index]
                                                    .source?.rating!
                                                    .toDouble(),
                                                jumlahUlasan: snapshot
                                                    .data?[index]
                                                    .source
                                                    ?.totalCountRating,
                                                minPrice: snapshot.data?[index]
                                                    .source?.minPrice,
                                                maxPrice: snapshot.data?[index]
                                                    .source?.maxPrice,
                                              ))).then((value) => {
                                        addMenuToCartBloc..add(GetMenusInCart())
                                      });
                                }
                              },
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: SizeConfig.safeBlockVertical * 3),
                                child: outlet(
                                    Assets.images.illCafetariaBanner2.path,
                                    snapshot.data?[index].source?.image,
                                    false,
                                    snapshot.data?[index].source?.name ??
                                        'Shabrina’s Kitchen - Gambir',
                                    "$parseDistance KM",
                                    'Cafetaria',
                                    '${snapshot.data?[index].source?.rating} • ${snapshot.data?[index].source?.totalCountRating} rating'),
                              )),
                        );
                      },
                    ));
                  }
                  return const Text("Error");
                },
              ))
        ]),
      ),
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
                          onPressed: () async {
                            Navigator.pop(context);
                            addMenuToCartBloc.add(RemoveAllMenuInCart());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => MakananPage(
                                          buka_toko: model?.source?.buka_toko ??
                                              "kosong",
                                          title: model?.source?.buka_toko ??
                                              'Shabrina’s Kitchen - Gambir',
                                          iduser: widget.id,
                                          idMerchant: model!.id.toString(),
                                          alamat:
                                              model.source!.address.toString(),
                                          rating:
                                              model.source!.rating!.toDouble(),
                                          jumlahUlasan:
                                              model.source!.totalCountRating,
                                          tutup_toko:
                                              model.source!.tutup_toko ??
                                                  "kosong",
                                          minPrice: model.source!.minPrice,
                                          maxPrice: model.source!.maxPrice,
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
