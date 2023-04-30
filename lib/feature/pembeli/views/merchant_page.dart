// ignore_for_file: avoid_print

import 'package:admin_repository/admin_repository.dart';
import 'package:cafetaria/app/bloc/app_bloc.dart';
import 'package:cafetaria/components/view_info.dart';
import 'package:cafetaria/feature/Authentication/bloc/bloc/pilih_kawasan_bloc.dart';
import 'package:cafetaria/feature/pembeli/bloc/add_menu_to_cart_bloc/add_menu_to_cart_bloc.dart';
import 'package:cafetaria/feature/pembeli/bloc/list_merchant_bloc/list_merchant_bloc.dart';
import 'package:cafetaria/feature/pembeli/bloc/list_merchant_login_bloc/list_merchant_login_bloc.dart';
import 'package:cafetaria/feature/pembeli/views/hasil_search_merchant.dart';
import 'package:cafetaria/feature/pembeli/views/makanan_page.dart';
import 'package:cafetaria/feature/pembeli/views/widget/merchant_widget.dart';
import 'package:cafetaria/feature/penjual/views/widgets/item_info.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:category_repository/category_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:menu_repository/menu_repository.dart';
import 'package:merchant_repository/merchant_repository.dart';
import 'package:sharedpref_repository/sharedpref_repository.dart';

class MerchantPage extends StatefulWidget {
  final String id;
  const MerchantPage({Key? key, required this.id}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MerchantPageState createState() => _MerchantPageState();
}

class _MerchantPageState extends State<MerchantPage>
    with WidgetsBindingObserver {
  TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xff333435));
  TextStyle headlineStyle = const TextStyle(
      color: Color(0xff333435), fontSize: 20, fontWeight: FontWeight.w700);
  late ListMerchantBloc listMerchantBloc;
  late AddMenuToCartBloc addMenuToCartBloc;
  late ListMerchantLoginBloc listMerchantLoginBloc;
  late PilihKawasanBloc pilihKawasanBloc;
  double? long;
  double? lat;
  String? merchantIdInKeranjang;
  MerchantModel? selectedMerchant;

  @override
  void initState() {
    // TODO: implement initState

    listMerchantBloc = ListMerchantBloc(
        merchantRepository: context.read<MerchantRepository>());
    addMenuToCartBloc =
        AddMenuToCartBloc(menuRepository: context.read<MenuRepository>());
    listMerchantLoginBloc = ListMerchantLoginBloc(
        merchantRepository: context.read<MerchantRepository>(),
        appSharedPref: context.read<AppSharedPref>());
    pilihKawasanBloc = PilihKawasanBloc(
        categoryRepository: context.read<CategoryRepository>());
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final statusApp = context.select((AppBloc bloc) => bloc.state.status);
    SizeConfig().init(context);
    //var size = MediaQuery.of(context).size;
    // show == true
    //     ? Future.delayed(Duration.zero, () => showAlert(context))
    //     : print("Kosong");
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: ((context) =>
                  listMerchantBloc..add(const GetListMerchant()))),
          BlocProvider(
              create: ((context) => addMenuToCartBloc..add(GetMenusInCart()))),
          BlocProvider(
              create: ((context) =>
                  listMerchantLoginBloc..add(GetListMerchantLogin(widget.id)))),
        ],
        child: Scaffold(
          body: BlocListener<AddMenuToCartBloc, AddMenuToCartState>(
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
                                iduser: widget.id,
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
              child: SingleChildScrollView(
                child: Column(children: [
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
                                if (value.isNotEmpty &&
                                    lat != null &&
                                    long != null) {
                                  Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => HasilMerchant(
                                                cari: value.toString(),
                                                lat: lat!,
                                                long: long!,
                                                id: widget.id),
                                          ))
                                      .then((value) => {
                                            addMenuToCartBloc
                                              ..add(GetMenusInCart())
                                          });
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          "mohon Pilih Kawasan Terlebih Dahulu",
                                      toastLength: Toast.LENGTH_LONG);
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
                          padding: const EdgeInsets.only(
                              left: 22, right: 22, top: 10),
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
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                height: 47,
                                width: SizeConfig.screenWidth / 2.5,
                                child: FutureBuilder(
                                  future: Future.wait([
                                    context.read<AppSharedPref>().getLong(),
                                    context.read<AppSharedPref>().getLat(),
                                  ]),
                                  builder: (context,
                                      AsyncSnapshot<List<String?>> snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.done) {
                                      if (snapshot.hasData) {
                                        List<String?> data = snapshot.data!;
                                        long = double.parse(data[0]!);
                                        lat = double.parse(data[1]!);
                                        return BlocProvider(
                                            create: (context) => PilihKawasanBloc(
                                                categoryRepository: context
                                                    .read<CategoryRepository>())
                                              ..add(GetDistanceKawasan(
                                                  lat: lat.toString(),
                                                  long: long.toString())),
                                            child: BlocBuilder<PilihKawasanBloc,
                                                PilihKawasanState>(
                                              builder: (context, state) {
                                                final status = state.status;
                                                if (status ==
                                                    PilihKawasanStatus
                                                        .loading) {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                } else if (status ==
                                                    PilihKawasanStatus
                                                        .failure) {
                                                  return const Center(
                                                    child: Text(
                                                        'Terjadi kesalahan'),
                                                  );
                                                } else if (status ==
                                                    PilihKawasanStatus
                                                        .success) {
                                                  lat = state.items?[0]
                                                      .kawasan_latitude;
                                                  long = state.items?[0]
                                                      .kawasan_longitude;
                                                  // final items = state.items!;
                                                  return DropdownButtonFormField<
                                                      PilihKawasanModel>(
                                                    isExpanded: true,
                                                    items: state.items!
                                                        .map((kawasan) =>
                                                            DropdownMenuItem(
                                                              value: kawasan,
                                                              child: Text(
                                                                kawasan.name
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                            ))
                                                        .toList(),
                                                    value: state.items![0],
                                                    icon: const Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      color: Colors.white,
                                                    ),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    selectedItemBuilder:
                                                        (BuildContext context) {
                                                      return state.items!
                                                          .map<Widget>(
                                                              (item) => Text(
                                                                    item.name
                                                                        .toString(),
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white),
                                                                  ))
                                                          .toList();
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      border: InputBorder.none,
                                                    ),
                                                    onChanged: (val) {
                                                      setState(() {
                                                        lat = val
                                                            ?.kawasan_latitude;
                                                        long = val
                                                            ?.kawasan_longitude;
                                                        context
                                                            .read<
                                                                AppSharedPref>()
                                                            .setLat(
                                                                lat.toString());
                                                        context
                                                            .read<
                                                                AppSharedPref>()
                                                            .setLong(long
                                                                .toString());
                                                      });
                                                      listMerchantLoginBloc.add(GetListMerchantLogin(widget.id));
                                                    },
                                                  );
                                                }
                                                return const SizedBox.shrink();
                                              },
                                            ));
                                      } else {
                                        // handle error case
                                        return Text(snapshot.error.toString());
                                      }
                                    } else {
                                      // show progress indicator
                                      return const CircularProgressIndicator();
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // const Center(
                  //   child: Text(
                  //     'CAFETARIA',
                  //     style: TextStyle(
                  //         fontSize: 16,
                  //         fontWeight: FontWeight.w700,
                  //         color: Color(0xff333435)),
                  //   ),
                  // ),
                  // SizedBox(height: SizeConfig.safeBlockVertical * 3),
                  SizedBox(height: SizeConfig.safeBlockVertical * 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'REKOMENDASI UNTUKMU',
                          style: textStyle.copyWith(
                              color: const Color(0xff808285)),
                        ),
                        Text(
                          'Lihat semua',
                          style: textStyle.copyWith(
                              fontSize: 12, color: const Color(0xffee3124)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical * 2),
                  statusApp == AppStatus.unauthenticated
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 16.0, horizontal: 24),
                          child:
                              BlocBuilder<ListMerchantBloc, ListMerchantState>(
                                  builder: ((context, state) {
                            if (state.status == ListMerchantStatus.loading) {
                              return const CircularProgressIndicator();
                            } else if (state.status ==
                                ListMerchantStatus.success) {
                              //inisialisasi fungsi future untuk menginput list merchant yang memiliki list menu
                              List<MerchantModel> merchant = [];
                              Future<List<MerchantModel>> listmerchant() async {
                                for (var element in state.items!) {
                                  final menu = await context
                                      .read<MenuRepository>()
                                      .getAllMenu(
                                          element.merchantId.toString());
                                  if (menu.isEmpty) {
                                    print("data Kosong");
                                  } else {
                                    try {
                                      merchant.add(element);
                                    } catch (e) {
                                      throw Exception('Failed to get All menu');
                                    }
                                  }
                                }
                                return merchant;
                              }

                              return FutureBuilder<List<MerchantModel>>(
                                  future: listmerchant(),
                                  builder: (context, snapshot) {
                                    // print(snapshot.data?.length);
                                    if (snapshot.data?.length == null) {
                                      return const CircularProgressIndicator();
                                    } else {
                                      return ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: snapshot.data?.length,
                                          itemBuilder: ((context, index) {
                                            return InkWell(
                                                onTap: () {
                                                  selectedMerchant =
                                                      snapshot.data?[index];
                                                  if (merchantIdInKeranjang !=
                                                          null &&
                                                      snapshot.data?[index]
                                                              .merchantId !=
                                                          merchantIdInKeranjang) {
                                                    showDialog(
                                                        context: context,
                                                        builder: ((context) {
                                                          return dialogWarnCart(
                                                              snapshot.data?[
                                                                  index]);
                                                        }));
                                                  } else {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (_) =>
                                                                    MakananPage(
                                                                      iduser:
                                                                          widget
                                                                              .id,
                                                                      title: snapshot
                                                                              .data?[index]
                                                                              .name ??
                                                                          'Shabrina’s Kitchen - Gambir',
                                                                      idMerchant: snapshot
                                                                          .data![
                                                                              index]
                                                                          .merchantId
                                                                          .toString(),
                                                                      alamat: snapshot
                                                                          .data![
                                                                              index]
                                                                          .address
                                                                          .toString(),
                                                                      buka_toko: snapshot.data![index].buka_toko ==
                                                                              null
                                                                          ? "kosong"
                                                                          : snapshot
                                                                              .data![index]
                                                                              .buka_toko
                                                                              .toString(),
                                                                      tutup_toko: snapshot.data![index].tutup_toko ==
                                                                              null
                                                                          ? "kosong"
                                                                          : snapshot
                                                                              .data![index]
                                                                              .tutup_toko
                                                                              .toString(),
                                                                      rating: snapshot
                                                                          .data?[
                                                                              index]
                                                                          .rating,
                                                                      jumlahUlasan: snapshot
                                                                          .data?[
                                                                              index]
                                                                          .totalCountRating,
                                                                      minPrice: snapshot
                                                                          .data?[
                                                                              index]
                                                                          .minPrice,
                                                                      maxPrice: snapshot
                                                                          .data?[
                                                                              index]
                                                                          .maxPrice,
                                                                    ))).then(
                                                        (value) => {
                                                              addMenuToCartBloc
                                                                ..add(
                                                                    GetMenusInCart())
                                                            });
                                                  }
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: SizeConfig
                                                              .safeBlockVertical *
                                                          3),
                                                  child: outlet(
                                                      Assets
                                                          .images
                                                          .illCafetariaBanner2
                                                          .path,
                                                      snapshot
                                                          .data?[index].image,
                                                      false,
                                                      snapshot.data?[index]
                                                              .name ??
                                                          'Shabrina’s Kitchen - Gambir',
                                                      'Lantai 1',
                                                      'Cafetaria',
                                                      '${snapshot.data?[index].rating} • ${snapshot.data?[index].totalCountRating} rating'),
                                                ));
                                          }));
                                    }
                                  });
                            } else if (state.status ==
                                ListMerchantStatus.failure) {
                              return Text(state.errorMessage.toString());
                            } else {
                              return const SizedBox();
                            }
                          })),
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: BlocBuilder<ListMerchantLoginBloc,
                                  ListMerchantLoginState>(
                              builder: ((context, state) {
                            if (state.status ==
                                ListMerchantLoginStatus.loading) {
                              return const CircularProgressIndicator();
                            } else if (state.status ==
                                ListMerchantLoginStatus.success) {
                              //inisialisasi fungsi future untuk menginput list merchant yang memiliki list menu
                              List<MerchantModel> merchant = [];
                              Future<List<MerchantModel>> listmerchant() async {
                                for (var element in state.items!) {
                                  final menu = await context
                                      .read<MenuRepository>()
                                      .getAllMenu(
                                          element.merchantId.toString());
                                  if (menu.isEmpty) {
                                    print("data Kosong");
                                  } else {
                                    try {
                                      merchant.add(element);
                                    } catch (e) {
                                      throw Exception('Failed to get All menu');
                                    }
                                  }
                                }
                                return merchant;
                              }

                              return FutureBuilder<List<MerchantModel>>(
                                  future: listmerchant(),
                                  builder: (context, snapshot) {
                                    // print(snapshot.data?.length);
                                    if (snapshot.data?.length == null) {
                                      return const CircularProgressIndicator();
                                    } else {
                                      return ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: snapshot.data?.length,
                                          itemBuilder: ((context, index) {
                                            double distance =
                                                snapshot.data![index].distance!;
                                            double parseDistance = double.parse(
                                                distance.toStringAsFixed(2));
                                            return InkWell(
                                                onTap: () {
                                                  selectedMerchant =
                                                      snapshot.data?[index];
                                                  if (merchantIdInKeranjang !=
                                                          null &&
                                                      snapshot.data?[index]
                                                              .merchantId !=
                                                          merchantIdInKeranjang) {
                                                    showDialog(
                                                        context: context,
                                                        builder: ((context) {
                                                          return dialogWarnCart(
                                                              snapshot.data?[
                                                                  index]);
                                                        }));
                                                  } else {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder:
                                                                (_) =>
                                                                    MakananPage(
                                                                      iduser:
                                                                          widget
                                                                              .id,
                                                                      title: snapshot
                                                                              .data?[index]
                                                                              .name ??
                                                                          'Shabrina’s Kitchen - Gambir',
                                                                      idMerchant: snapshot
                                                                          .data![
                                                                              index]
                                                                          .merchantId
                                                                          .toString(),
                                                                      alamat: snapshot
                                                                          .data![
                                                                              index]
                                                                          .address
                                                                          .toString(),
                                                                      buka_toko: snapshot.data![index].buka_toko ==
                                                                              null
                                                                          ? "kosong"
                                                                          : snapshot
                                                                              .data![index]
                                                                              .buka_toko
                                                                              .toString(),
                                                                      tutup_toko: snapshot.data![index].tutup_toko ==
                                                                              null
                                                                          ? "kosong"
                                                                          : snapshot
                                                                              .data![index]
                                                                              .tutup_toko
                                                                              .toString(),
                                                                      rating: snapshot
                                                                          .data?[
                                                                              index]
                                                                          .rating,
                                                                      jumlahUlasan: snapshot
                                                                          .data?[
                                                                              index]
                                                                          .totalCountRating,
                                                                      minPrice: snapshot
                                                                          .data?[
                                                                              index]
                                                                          .minPrice,
                                                                      maxPrice: snapshot
                                                                          .data?[
                                                                              index]
                                                                          .maxPrice,
                                                                    ))).then(
                                                        (value) => {
                                                              addMenuToCartBloc
                                                                ..add(
                                                                    GetMenusInCart())
                                                            });
                                                  }
                                                },
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: SizeConfig
                                                              .safeBlockVertical *
                                                          3),
                                                  child: outlet(
                                                      Assets
                                                          .images
                                                          .illCafetariaBanner2
                                                          .path,
                                                      snapshot
                                                          .data?[index].image,
                                                      false,
                                                      snapshot.data?[index]
                                                              .name ??
                                                          'Shabrina’s Kitchen - Gambir',
                                                      "$parseDistance Km",
                                                      'Cafetaria',
                                                      '${snapshot.data?[index].rating} • ${snapshot.data?[index].totalCountRating} rating'),
                                                ));
                                          }));
                                    }
                                  });
                            } else if (state.status ==
                                ListMerchantLoginStatus.failure) {
                              return Text(state.errorMessage.toString());
                            } else {
                              return const SizedBox();
                            }
                          })),
                        ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'PAPAN INFO',
                          style: textStyle.copyWith(
                              color: const Color(0xff808285)),
                        ),
                        Text(
                          'Lihat semua',
                          style: textStyle.copyWith(
                              fontSize: 12, color: const Color(0xffee3124)),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 24),
                    child: StreamBuilder<List<InfoModel>>(
                      stream: context.read<AdminRepository>().getStreamInfo(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text("Ada masalah ${snapshot.error}");
                        } else if (snapshot.hasData) {
                          final items = snapshot.data;
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 5,
                            child: ListView.builder(
                              itemCount: items!.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return items[index].status == "active"
                                    ? items[index].type == "pembeli" ||
                                            items[index].type == "semua"
                                        ? GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => ViewInfo(
                                                          infoModel:
                                                              items[index])));
                                            },
                                            child: HomeItemInfo(
                                              image:
                                                  items[index].image.toString(),
                                              title:
                                                  items[index].title.toString(),
                                              author: 'Charlie Natalie',
                                            ),
                                          )
                                        : const SizedBox.shrink()
                                    : const SizedBox.shrink();
                              },
                            ),
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                ]),
              )),
        ));
  }

  Dialog dialogWarnCart(MerchantModel? model) {
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
                          onPressed: () {
                            addMenuToCartBloc.add(RemoveAllMenuInCart());
                            Navigator.pop(context);
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
