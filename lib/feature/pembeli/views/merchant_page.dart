import 'package:cafetaria/feature/pembeli/bloc/add_menu_to_cart_bloc/add_menu_to_cart_bloc.dart';
import 'package:cafetaria/feature/pembeli/bloc/list_merchant_bloc/list_merchant_bloc.dart';
import 'package:cafetaria/feature/pembeli/views/makanan_page.dart';
import 'package:cafetaria/feature/pembeli/views/widget/merchant_widget.dart';
import 'package:cafetaria/feature/pembeli/views/widget/promo_widget.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/utilities/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:menu_repository/menu_repository.dart';
import 'package:merchant_repository/merchant_repository.dart';

class MerchantPage extends StatefulWidget {
  const MerchantPage({Key? key}) : super(key: key);

  @override
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

  String? merchantIdInKeranjang;
  MerchantModel? selectedMerchant;

  @override
  void initState() {
    // TODO: implement initState
    listMerchantBloc = ListMerchantBloc(
        merchantRepository: context.read<MerchantRepository>());
    addMenuToCartBloc =
        AddMenuToCartBloc(menuRepository: context.read<MenuRepository>());
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: ((context) => listMerchantBloc..add(GetListMerchant()))),
          BlocProvider(
              create: ((context) => addMenuToCartBloc..add(GetMenusInCart())))
        ],
        child: BlocListener<AddMenuToCartBloc, AddMenuToCartState>(
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
                              title: selectedMerchant?.nama ??
                                  'Shabrina’s Kitchen - Gambir',
                              idMerchant:
                                  selectedMerchant!.merchantId.toString(),
                              rating: selectedMerchant?.rating,
                              jumlahUlasan: selectedMerchant?.totalCountRating,
                              minPrice: selectedMerchant?.minPrice,
                              maxPrice: selectedMerchant?.maxPrice,
                            ))).then(
                    (value) => {addMenuToCartBloc..add(GetMenusInCart())});
              }
            }),
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
                child: Column(children: [
                  SizedBox(height: SizeConfig.safeBlockVertical * 1),
                  const Center(
                    child: Text(
                      'CAFETARIA',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff333435)),
                    ),
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical * 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'PROMO HARI INI',
                        style:
                            textStyle.copyWith(color: const Color(0xff808285)),
                      ),
                      Text(
                        'Lihat semua',
                        style: textStyle.copyWith(
                            fontSize: 12, color: const Color(0xffee3124)),
                      )
                    ],
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical * 2),
                  promo(),
                  SizedBox(height: SizeConfig.safeBlockVertical * 3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'REKOMENDASI UNTUKMU',
                        style:
                            textStyle.copyWith(color: const Color(0xff808285)),
                      ),
                      Text(
                        'Lihat semua',
                        style: textStyle.copyWith(
                            fontSize: 12, color: const Color(0xffee3124)),
                      )
                    ],
                  ),
                  SizedBox(height: SizeConfig.safeBlockVertical * 2),

                  BlocBuilder<ListMerchantBloc, ListMerchantState>(
                      builder: ((context, state) {
                    if (state.status == ListMerchantStatus.loading) {
                      return CircularProgressIndicator();
                    } else if (state.status == ListMerchantStatus.success) {
                      return Expanded(
                          child: ListView.builder(
                              itemCount: state.items!.length,
                              itemBuilder: ((context, index) {
                                return InkWell(
                                    onTap: () {
                                      selectedMerchant = state.items?[index];
                                      if (merchantIdInKeranjang != null &&
                                          state.items?[index].merchantId !=
                                              merchantIdInKeranjang) {
                                        showDialog(
                                            context: context,
                                            builder: ((context) {
                                              return dialogWarnCart(
                                                  state.items?[index]);
                                            }));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => MakananPage(
                                                      title: state.items?[index]
                                                              .nama ??
                                                          'Shabrina’s Kitchen - Gambir',
                                                      idMerchant: state
                                                          .items![index]
                                                          .merchantId
                                                          .toString(),
                                                      rating: state
                                                          .items?[index].rating,
                                                      jumlahUlasan: state
                                                          .items?[index]
                                                          .totalCountRating,
                                                      minPrice: state
                                                          .items?[index]
                                                          .minPrice,
                                                      maxPrice: state
                                                          .items?[index]
                                                          .maxPrice,
                                                    ))).then((value) => {
                                              addMenuToCartBloc
                                                ..add(GetMenusInCart())
                                            });
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top:
                                              SizeConfig.safeBlockVertical * 3),
                                      child: outlet(
                                          Assets
                                              .images.illCafetariaBanner2.path,
                                          false,
                                          state.items?[index].nama ??
                                              'Shabrina’s Kitchen - Gambir',
                                          'Lantai 1',
                                          'Cafetaria',
                                          '${state.items?[index].rating} • ${state.items?[index].totalCountRating} rating'),
                                    ));
                              })));
                    } else if (state.status == ListMerchantStatus.failure) {
                      return Text(state.errorMessage.toString());
                    } else {
                      return SizedBox();
                    }
                  })),
                  // GestureDetector(
                  //   onTap: () => Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (_) => MakananPage(
                  //                 title: 'Key-Pop Korean Street Food - Antapani',
                  //               ))),
                  //   child: outlet(
                  //       Assets.images.illCafetariaBanner1.path,
                  //       true,
                  //       'Key-Pop Korean Street Food - Antapani',
                  //       '1.2 km',
                  //       '15 min',
                  //       '4.8 • 1rb+ rating'),
                  // ),
                ]))));
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