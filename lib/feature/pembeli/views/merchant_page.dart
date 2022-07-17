import 'package:cafetaria/feature/pembeli/bloc/list_merchant_bloc/list_merchant_bloc.dart';
import 'package:cafetaria/feature/pembeli/views/makanan_page.dart';
import 'package:cafetaria/feature/pembeli/views/widget/merchant_widget.dart';
import 'package:cafetaria/feature/pembeli/views/widget/promo_widget.dart';
import 'package:cafetaria/gen/assets.gen.dart';
import 'package:cafetaria/utilities/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merchant_repository/merchant_repository.dart';

class MerchantPage extends StatefulWidget {
  const MerchantPage({Key? key}) : super(key: key);

  @override
  _MerchantPageState createState() => _MerchantPageState();
}

class _MerchantPageState extends State<MerchantPage> {
  TextStyle textStyle = const TextStyle(
      fontWeight: FontWeight.w400, fontSize: 12, color: Color(0xff333435));
  TextStyle headlineStyle = const TextStyle(
      color: Color(0xff333435), fontSize: 20, fontWeight: FontWeight.w700);
  late ListMerchantBloc listMerchantBloc;
  @override
  void initState() {
    // TODO: implement initState
    listMerchantBloc = ListMerchantBloc(
        merchantRepository: context.read<MerchantRepository>());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var size = MediaQuery.of(context).size;

    return BlocProvider(
        create: ((context) => listMerchantBloc..add(GetListMerchant())),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
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
                    style: textStyle.copyWith(color: const Color(0xff808285)),
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
                    style: textStyle.copyWith(color: const Color(0xff808285)),
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => MakananPage(
                                                title: state
                                                        .items?[index].nama ??
                                                    'Shabrina’s Kitchen - Gambir',
                                                idMerchant: state
                                                    .items![index].merchantId
                                                    .toString(),
                                                rating:
                                                    state.items?[index].rating,
                                                jumlahUlasan: state
                                                    .items?[index]
                                                    .totalCountRating,
                                                minPrice: state
                                                    .items?[index].minPrice,
                                                maxPrice: state
                                                    .items?[index].maxPrice,
                                              )));
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: SizeConfig.safeBlockVertical * 3),
                                  child: outlet(
                                      Assets.images.illCafetariaBanner2.path,
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
            ])));
  }
}
