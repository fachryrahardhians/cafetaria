import 'package:authentication_repository/authentication_repository.dart';
import 'package:cafetaria/feature/pembeli/bloc/history_order_bloc/history_order_bloc.dart';
import 'package:cafetaria/feature/pembeli/bloc/list_merchant_bloc/list_merchant_bloc.dart';
import 'package:cafetaria/feature/pembeli/views/history_detail_page.dart';
import 'package:cafetaria/styles/box_shadows.dart';
import 'package:cafetaria/styles/colors.dart';
import 'package:cafetaria/styles/text_styles.dart';
import 'package:cafetaria/utilities/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:merchant_repository/merchant_repository.dart';
import 'package:order_repository/order_repository.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const History();
  }
}

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Color(0xffee3124)),
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'RIWAYAT CAFETARIA',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Color(0xff333435)),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: MyColors.red1,
            indicatorWeight: 4,
            labelColor: textStyle.color,
            unselectedLabelColor: const Color(0xffB1B5BA),
            unselectedLabelStyle: textStyle,
            labelStyle: headlineStyle.copyWith(fontSize: 15),
            tabs: const [
              Tab(
                text: 'Proses',
                iconMargin: EdgeInsets.only(bottom: 4),
              ),
              Tab(
                text: 'Selesai',
                iconMargin: EdgeInsets.only(bottom: 4),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [ProcessList(), DoneList()],
        ),
      ),
    );
  }
}

class ProcessList extends StatelessWidget {
  const ProcessList({Key? key}) : super(key: key);

  Color getStatusColor(int time) {
    if (time >= 15) {
      return Colors.red;
    } else {
      return Colors.yellow;
    }
  }

  int getDiffTime(DateTime time) {
    DateTime now = DateTime.now();
    Duration different = now.difference(time);
    if (different.inMinutes > 60) {
      return 60;
    } else {
      return different.inMinutes;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HistoryOrderBloc>(
          create: (context) => HistoryOrderBloc(
              orderRepository: context.read<OrderRepository>(),
              authenticationRepository:
                  context.read<AuthenticationRepository>())
            ..add(GetHistoryOrder('process')),
        ),
        BlocProvider<ListMerchantBloc>(
            create: (context) => ListMerchantBloc(
                merchantRepository: context.read<MerchantRepository>())
              ..add(GetListMerchant()))
      ],
      child: BlocBuilder<HistoryOrderBloc, HistoryOrderState>(
          builder: (context, state) {
        final status = state.status;
        if (status == HistoryOrderStatus.loading) {
          return Center(child: const CircularProgressIndicator());
        } else if (status == HistoryOrderStatus.failure) {
          return Center(
            child: Text('Terjadi kesalahan error: ' + state.errorMessage!),
          );
        } else if (status == HistoryOrderStatus.success) {
          if (state.items != null) {
            final items = state.items!;
            return BlocBuilder<ListMerchantBloc, ListMerchantState>(
                builder: (context, merchantState) {
              final merchantStatus = merchantState.status;
              if (merchantStatus == ListMerchantStatus.loading) {
                return Center(child: CircularProgressIndicator());
              } else if (merchantStatus == ListMerchantStatus.success) {
                return SizedBox(
                  height: 200,
                  child: ListView.separated(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        DateTime date = DateTime.parse(item.timestamp!);
                        int minutes = getDiffTime(date);
                        List<String> dateFormated = DateFormat('EEE MMM d')
                            .format(date)
                            .toString()
                            .trim()
                            .split(' ');
                        MerchantModel? merchant;
                        merchantState.items!.forEach((element) {
                          if (element.merchantId == item.merchantId)
                            merchant = element;
                        });
                        return listCard(dateFormated[0], dateFormated[2],
                            dateFormated[1], context,
                            item: item, minutes: minutes, merchant: merchant!);
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                            height: SizeConfig.safeBlockVertical * 3);
                      },
                      itemCount: items.length),
                );
              } else if (merchantStatus == ListMerchantStatus.failure)
                return Text(merchantState.errorMessage!);
              else
                return SizedBox();
            });
          } else {
            return Text('No Data');
          }
        }
        return const SizedBox();
      }),
    );
  }

  Widget listCard(String day, String date, String month, BuildContext context,
      {required HistoryModel item,
      required int minutes,
      required MerchantModel merchant}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => HistoryDetailPage(
                      item: item,
                      merchant: merchant,
                    )));
      },
      child: Container(
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 4),
                  color: Colors.black.withOpacity(.04),
                  blurRadius: 12)
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: SizeConfig.safeBlockHorizontal * 30,
                  height: SizeConfig.safeBlockVertical * 3,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(8),
                          bottomLeft: Radius.circular(8)),
                      color: getStatusColor(minutes).withOpacity(.25)),
                  child: Center(
                    child: Text(
                      minutes > 60 ? '>60 menit lalu' : '$minutes menit lalu',
                      style: textStyle.copyWith(
                          color: getStatusColor(minutes),
                          fontSize: 10,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: SizeConfig.safeBlockVertical * 1),
            Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    width: SizeConfig.safeBlockVertical * 9,
                    height: SizeConfig.safeBlockVertical * 9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xff808285),
                              Color(0xff333435),
                              Color(0xff333435),
                            ]),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 4),
                              color: Colors.black.withOpacity(.04),
                              blurRadius: 12)
                        ]),
                    child: Column(
                      children: [
                        Text(
                          day,
                          style: textStyle.copyWith(color: Colors.white),
                        ),
                        Text(date,
                            style: headlineStyle.copyWith(
                              color: Colors.white,
                            )),
                        Text(
                          month,
                          style: textStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withOpacity(.5)),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: SizeConfig.safeBlockHorizontal * 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal * 55,
                        child: Text(
                          item.orderId.toString(),
                          style: headlineStyle.copyWith(fontSize: 14),
                        ),
                      ),
                      SizedBox(height: SizeConfig.safeBlockVertical * 1),
                      Text(
                        merchant.name ?? 'No name',
                        style: textStyle.copyWith(fontWeight: FontWeight.w500),
                      ),
                      // SizedBox(height: SizeConfig.safeBlockVertical * .5),
                      // Text(
                      //   'Tower A • Lantai 1 • Nomor 37',
                      //   style: textStyle.copyWith(fontWeight: FontWeight.w500),
                      // ),
                      // SizedBox(height: SizeConfig.safeBlockVertical * .5),
                      // Text(
                      //   'Perkiraan waktu 08:00 - 10:00',
                      //   style: textStyle.copyWith(
                      //       fontSize: 11, color: Color(0xff999B9D)),
                      // )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DoneList extends StatefulWidget {
  const DoneList({Key? key}) : super(key: key);

  @override
  State<DoneList> createState() => _DoneListState();
}

class _DoneListState extends State<DoneList> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HistoryOrderBloc>(
          create: (context) => HistoryOrderBloc(
              orderRepository: context.read<OrderRepository>(),
              authenticationRepository:
                  context.read<AuthenticationRepository>())
            ..add(GetHistoryOrder('done')),
        ),
        BlocProvider<ListMerchantBloc>(
            create: (context) => ListMerchantBloc(
                merchantRepository: context.read<MerchantRepository>())
              ..add(GetListMerchant()))
      ],
      child: BlocBuilder<HistoryOrderBloc, HistoryOrderState>(
        builder: (childContext, state) {
          final status = state.status;
          if (status == HistoryOrderStatus.loading) {
            return Center(child: const CircularProgressIndicator());
          } else if (status == HistoryOrderStatus.failure) {
            return Center(
              child: Text('Terjadi kesalahan error: ' + state.errorMessage!),
            );
          } else if (status == HistoryOrderStatus.success) {
            if (state.items != null) {
              final items = state.items!;
              return BlocBuilder<ListMerchantBloc, ListMerchantState>(
                  builder: (context, merchantState) {
                final merchantStatus = merchantState.status;
                if (merchantStatus == ListMerchantStatus.loading)
                  return Center(child: const CircularProgressIndicator());
                else if (merchantStatus == ListMerchantStatus.success) {
                  return SizedBox(
                    height: 200,
                    child: ListView.separated(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        itemBuilder: (context, index) {
                          final item = items[index];
                          MerchantModel? merchant;
                          merchantState.items!.forEach((element) {
                            if (element.merchantId == item.merchantId)
                              merchant = element;
                          });
                          return _doneCard(item: item, merchant: merchant!);
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                              height: SizeConfig.safeBlockVertical * 3);
                        },
                        itemCount: items.length),
                  );
                } else
                  return SizedBox();
              });
            } else {
              return Text('No Data');
            }
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _doneCard(
      {required HistoryModel item, required MerchantModel merchant}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => HistoryDetailPage(
                      item: item,
                      merchant: merchant,
                    )));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: boxShadows),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal * 50,
                  child: Text(
                    item.merchantId ?? '',
                    style: headlineStyle.copyWith(fontSize: 14),
                  ),
                ),
                Text('Rp ${item.total}', style: textStyle),
              ],
            ),
            SizedBox(height: SizeConfig.safeBlockVertical * 1),
            Text(
              item.timestamp.toString(),
              style: textStyle.copyWith(color: Color(0xffB1B5BA)),
            )
          ],
        ),
      ),
    );
  }
}
